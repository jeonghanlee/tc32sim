# tc32sim — TC-32 Simulator IOC Architecture

## 1. Purpose

tc32sim replaces physical TC-32 thermocouple measurement hardware with a TCP stream
emulator, providing a structurally identical EPICS IOC and PVA object for miribom
development and integration testing.

The production TCMD IOC uses the measComp driver (`MultiFunctionConfig`) to communicate
with hardware over Ethernet. tc32sim replaces that driver with StreamDevice reading from
`tc32_emulator.bash` over a local TCP connection. Every other layer — the CA records,
the PVXS QSRV2 group mapping, the PVA object structure, and the type identifier — is
identical to production.

---

## 2. Signal Chain

```
tc32_emulator.bash
        | TCP  "CH00: 23.5\n" ... "CH31: 45.1\n"
        ↓
tc32.proto
        | get_temp($1) → in "CH\$1: %f"
        ↓
temperature-sim.template
        | record(ai, "$(P)Ti0")  SCAN=I/O Intr  ADDR=00
        | record(ai, "$(P)Ti1")  SCAN=I/O Intr  ADDR=01
        | ...
        | record(ai, "$(P)Ti31") SCAN=I/O Intr  ADDR=31
        ↓
tcmd_group.json
        | "ch00.temp": "+channel": "$(P)Ti0.VAL"
        | "ch01.temp": "+channel": "$(P)Ti1.VAL"
        | ...
        | "ch31.temp": "+channel": "$(P)Ti31.VAL"
        ↓
$(P)group   [alsu:nt/TC32:1.0]
```

---

## 3. Emulator

`tc32_emulator.bash` creates a TCP listener on a specified port using `socat`.
It emits 32 lines per cycle, one per channel. Channel numbering is 0-based:

```
CH00: 23.5
CH01: 41.8
...
CH31: 19.3
```

Temperature values are managed as integers in tenths of a degree (100–900 = 10.0–90.0 °C)
using bash integer arithmetic. No external processes (`bc`) are spawned during the main
loop, keeping CPU usage low across 64 concurrent instances.

64 instances run on ports 9400–9463:

```bash
./simulator/run_simulators.bash
```

---

## 4. StreamDevice Protocol

`tc32.proto` defines a single command, `get_temp`, that parses one line of emulator
output:

```
get_temp
{
    in "CH\$1: %f";
}
```

`$1` is replaced at record load time by the `ADDR` argument passed from the `INP` field.
For example, `Ti0` passes `ADDR=00`, so the protocol matches `CH00: <float>`.

---

## 5. Record Mapping

`temperature-sim.template` defines five records per channel, matching the structure of
`measCompTemperatureIn-alsu.template`. The `ai` record uses StreamDevice instead of
`asynFloat64Average`. The remaining four records use `Soft Channel` with fixed initial
values since no hardware driver is present.

| Record | Type | DTYP | Notes |
|---|---|---|---|
| `$(P)$(R)` | ai | stream | temperature from emulator |
| `$(P)$(R)Scale` | mbbo | Soft Channel | default: Celsius |
| `$(P)$(R)TCType` | mbbo | Soft Channel | default: Type K |
| `$(P)$(R)Filter` | mbbo | Soft Channel | default: Filter |
| `$(P)$(R)OpenTCDetect` | bo | Soft Channel | default: Enable |

`TC-32-sim.substitutions` provides the `R` (record name) and `ADDR` (stream token)
arguments for all 32 channels:

| R | ADDR | CA record | Stream token |
|---|---|---|---|
| Ti0 | 00 | `$(P)Ti0` | `CH00` |
| Ti1 | 01 | `$(P)Ti1` | `CH01` |
| ... | ... | ... | ... |
| Ti31 | 31 | `$(P)Ti31` | `CH31` |

---

## 6. Metadata Records

`tc32-sim-meta.template` provides static records for the device metadata fields
required by `tcmd_group.json`. All records carry `PINI=YES` and write once at IOC
initialization.

| Record | Value | maps to |
|---|---|---|
| `$(P)ModelName` | `TC32-SIM` | `device.model` |
| `$(P)FirmwareVersion` | `1.00-sim` | `device.firmware` |
| `$(P)ModelNumber` | `TC-32` | `tc32.model_number` |
| `$(P)UniqueID` | `$(IPADDR=127.0.0.1)` | `tc32.unique_id` |
| `$(P)ULVersion` | `0.0-sim` | `tc32.ul_version` |
| `$(P)DriverVersion` | `0.0-sim` | `tc32.driver_version` |
| `$(P)PollTimeMS` | `333` | `tc32.poll_time_ms` |
| `$(P)PollSleepMS` | `0` | `tc32.poll_sleep_ms` |
| `$(P)LastErrorMessage` | `""` | `device.error` |

Both `tc32-sim-meta.template` and `temperature-sim.template` are combined in
`TC-32-sim.substitutions`, which the build system expands into a single `TC-32-sim.db`.

---

## 7. PVA Object Structure

`tcmd_group.json` is identical to the production file. The PVA object delivered to
miribom has the same structure in both environments:

```
$(P)group   [alsu:nt/TC32:1.0]
  device
    model        string          (plain)
    serial       string          (const "")
    firmware     string          (plain)
    error        NTScalar string (scalar, trigger)
  tc32
    model_number   string          (plain)
    ul_version     string          (plain)
    driver_version string          (plain)
    unique_id      string          (plain)
    poll_time_ms   NTScalar double (scalar, trigger)
    poll_sleep_ms  NTScalar double (scalar, putorder=0)
  ch00 .. ch31
    desc         string          (plain)
    temp         NTScalar double (scalar, trigger)
    egu          NTScalar string (scalar, trigger)
    scale        NTScalar int    (scalar, trigger)
    tc_type      NTScalar int    (scalar, trigger)
    filter       NTScalar int    (scalar, trigger)
    open_detect  NTScalar int    (scalar, trigger)
```

---

## 8. Per-Device iocsh Snippet

`tc32sim.iocsh` replaces `MultiFunctionConfig` with `drvAsynIPPortConfigure` and loads
the single combined `TC-32-sim.db`:

**Production (`tcmd.iocsh`):**
```
MultiFunctionConfig("$(PORT)", "$(IPADDR)", 1, 1)
dbLoadRecords("$(DATABASE_TOP)/TC32.db", ...)
dbLoadGroup("$(DATABASE_TOP)/tcmd_group.json", ...)
```

**Simulator (`tc32sim.iocsh`):**
```
drvAsynIPPortConfigure("$(PORT)", "$(IPADDR):$(TCP_PORT)", 0, 0, 0)
asynOctetSetInputEos( "$(PORT)", 0, "\n")
asynOctetSetOutputEos("$(PORT)", 0, "\n")
dbLoadRecords("$(DATABASE_TOP)/TC-32-sim.db", ...)
dbLoadGroup("$(DATABASE_TOP)/tcmd_group.json", ...)
```

The `$(PVX=)` macro enables `dbLoadGroup`. When `PVX` is not set (default `#--`),
the group is not loaded and only CA records are active.

---

## 9. IOC Startup

`st-sim.cmd` loads 64 device instances using `iocshLoad`. Each instance receives a
unique Asyn port name, PV prefix, and TCP port number:

```
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh",
          "PORT=TCP001,P=TC32:001:,TCP_PORT=9400,DATABASE_TOP=$(DB_TOP),PVX=")
...
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh",
          "PORT=TCP064,P=TC32:064:,TCP_PORT=9463,DATABASE_TOP=$(DB_TOP),PVX=")
```

---

---

## 10. Device and Port Map

| Device | P prefix | TCP port |
|---|---|---|
| 001 | `TC32:001:` | 9400 |
| 002 | `TC32:002:` | 9401 |
| ... | ... | ... |
| 064 | `TC32:064:` | 9463 |
