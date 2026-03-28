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
        | TCP  "CH01: 23.5\n" ... "CH32: 45.1\n"
        ↓
tc32.proto
        | get_temp($1) → in "CH\$1: %f"
        ↓
temperature-sim.template
        | record(ai, "$(P)Ti0") SCAN=I/O Intr
        | record(ai, "$(P)Ti1") SCAN=I/O Intr
        | ...
        | record(ai, "$(P)Ti31") SCAN=I/O Intr
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
It emits 32 lines per cycle, one per channel:

```
CH01: 23.5
CH02: 41.8
...
CH32: 19.3
```

The update rate is continuous — each `generate_temp()` call takes approximately 6–15 ms,
so one full 32-channel cycle completes in roughly 200–480 ms (~2–5 Hz effective rate
per channel).

64 instances run on ports 9400–9463:

```bash
parallel ./tc32_emulator.bash --port ::: $(seq 9400 9463)
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

`$1` is replaced at record load time by the channel number argument passed from the
`INP` field. For example, `Ti0` passes `01`, so the protocol matches `CH01: <float>`.

---

## 5. Record Mapping

`temperature-sim.template` defines one `ai` record per channel. The record name follows
the `Ti<N>` pattern required by `tcmd_group.json`:

```
record(ai, "$(P)$(R)")
{
    field(DTYP, "stream")
    field( INP, "@tc32.proto get_temp($(CH)) $(PORT)")
    field(SCAN, "I/O Intr")
    ...
}
```

`TC32-sim.substitutions` provides the `R` (record name) and `CH` (stream token)
arguments for all 32 channels:

| R | CH | CA record | Stream token |
|---|---|---|---|
| Ti0 | 01 | `$(P)Ti0` | `CH01` |
| Ti1 | 02 | `$(P)Ti1` | `CH02` |
| ... | ... | ... | ... |
| Ti31 | 32 | `$(P)Ti31` | `CH32` |

This mapping is the only difference between tc32sim and the production TCMD IOC.
In production, `$(P)Ti0.VAL` is written by the measComp driver. In tc32sim, it is
written by StreamDevice reading from the TCP emulator.

---

## 6. Metadata Records

`tc32-sim-meta.template` provides static records for the device metadata fields
required by `tcmd_group.json`:

| Record | Value | maps to |
|---|---|---|
| `$(P)ModelName` | `TC32-SIM` | `device.model` |
| `$(P)FirmwareVersion` | `1.00-sim` | `device.firmware` |
| `$(P)ModelNumber` | `TC-32` | `tc32.model_number` |
| `$(P)UniqueID` | `$(IPADDR)` | `tc32.unique_id` |
| `$(P)ULVersion` | `0.0-sim` | `tc32.ul_version` |
| `$(P)DriverVersion` | `0.0-sim` | `tc32.driver_version` |
| `$(P)PollTimeMS` | `333` | `tc32.poll_time_ms` |
| `$(P)PollSleepMS` | `0` | `tc32.poll_sleep_ms` |
| `$(P)LastErrorMessage` | `""` | `device.error` |

All records carry `PINI=YES` and write once at IOC initialization.

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

`tcmd-sim.iocsh` replaces `MultiFunctionConfig` with `drvAsynIPPortConfigure`:

**Production (`tcmd.iocsh`):**
```
MultiFunctionConfig("$(PORT)", "$(IPADDR)", 1, 1)
dbLoadRecords("$(DATABASE_TOP)/TC32.db", ...)
dbLoadGroup("$(DATABASE_TOP)/tcmd_group.json", ...)
```

**Simulator (`tcmd-sim.iocsh`):**
```
drvAsynIPPortConfigure("$(PORT)", "$(IPADDR):$(TCP_PORT)", 0, 0, 0)
asynOctetSetInputEos( "$(PORT)", 0, "\n")
asynOctetSetOutputEos("$(PORT)", 0, "\n")
dbLoadRecords("$(DATABASE_TOP)/TC32-sim.db", ...)
dbLoadRecords("$(DATABASE_TOP)/tc32-sim-meta.template", ...)
dbLoadGroup("$(DATABASE_TOP)/tcmd_group.json", ...)
```

The `$(PVX=)` macro enables `dbLoadGroup`. When `PVX` is not set (default `#--`),
the group is not loaded and only CA records are active.

---

## 9. IOC Startup

`st-sim.cmd` loads 64 device instances using `iocshLoad`. Each instance receives a
unique Asyn port name, PV prefix, and TCP port number:

```
iocshLoad("$(IOCSH_LOCAL_TOP)/tcmd-sim.iocsh",
          "PORT=TCP001,P=TC32:001:,TCP_PORT=9400,DATABASE_TOP=$(DB_TOP),PVX=")
...
iocshLoad("$(IOCSH_LOCAL_TOP)/tcmd-sim.iocsh",
          "PORT=TCP064,P=TC32:064:,TCP_PORT=9463,DATABASE_TOP=$(DB_TOP),PVX=")
```

---

## 10. Building

### Prerequisites

`configure/RELEASE` must include:

```makefile
STREAM = $(EPICS_MODULES)/StreamDevice
PVXS   = $(EPICS_MODULES)/pvxs
```

`tc32simApp/src/Makefile` must include:

```makefile
tc32sim_DBD  += stream.dbd
tc32sim_LIBS += stream
tc32sim_LIBS += pvxs
```

### Build command

```bash
source ~/EPICS-environment/1.2.0/debian-13/7.0.10/setEpicsEnv.bash
cd ioc
make
```

---

## 11. Device and Port Map

| Device | P prefix | TCP port |
|---|---|---|
| 001 | `TC32:001:` | 9400 |
| 002 | `TC32:002:` | 9401 |
| ... | ... | ... |
| 064 | `TC32:064:` | 9463 |
