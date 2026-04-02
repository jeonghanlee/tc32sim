# tc32sim

TC-32 simulator IOC for miribom (미리봄) development and testing.

Replaces physical TC-32 hardware with a TCP stream emulator.
The IOC and PVA group object are structurally identical to the production TCMD IOC.

---

## Signal chain

```
tc32_emulator.bash          "CH00: 23.5\n" ... "CH31: 45.1\n"  (~3 Hz)
        ↓ TCP
tc32.proto                  get_temp($1) → in "CH\$1: %f"
        ↓ StreamDevice
temperature-sim.template    record(ai, "$(P)Ti0") ... record(ai, "$(P)Ti31")
        ↓ CA records
tcmd_group.json             $(P)Ti0.VAL → ch00.temp, ... $(P)Ti31.VAL → ch31.temp
        ↓ dbLoadGroup
$(P)group                   [alsu:nt/TC32:1.0]
        ↓ PVA
Clients
```

---

## Quick start

### 1. Start simulators (64 devices, ports 9400–9463)

```bash
./simulator/run_simulators.bash
./simulator/check_simulators.bash
```

### 2. Build IOC

```bash
source ~/EPICS-environment/1.2.0/debian-13/7.0.10/setEpicsEnv.bash
make
```

### 3. Start IOC

**Option A — direct**

```bash
cd iocBoot/ioctestlab-tc32sim
./st-sim.cmd
```

**Option B — ioc-runner (system service)**

```bash
ioc-runner install testlab-tc32sim.conf
ioc-runner start  testlab-tc32sim
ioc-runner status testlab-tc32sim
ioc-runner attach testlab-tc32sim
```

See [epics-ioc-runner](https://github.com/jeonghanlee/epics-ioc-runner) for setup.

### 4. Verify PVA

```bash
./tools/check_pva.bash
```

---

## PV naming

| PV | Description |
|---|---|
| `TC32:NNN:group` | PVA group object (`alsu:nt/TC32:1.0`) |
| `TC32:NNN:Ti0` | Channel 0 temperature (mapped from CH00) |
| `TC32:NNN:Ti31` | Channel 31 temperature (mapped from CH31) |

TCP port = 9400 + (NNN − 1)

---

## Documentation

- [Architecture](docs/TC32SIM_ARCHITECTURE.md) — signal chain, record mapping, PVA object structure
- [PVA CLI Usage](docs/TC32SIM_PVXS_CLI.md) — pvxget / pvxmonitor / pvxput
- [Simulator Scripts](docs/TC32SIM_SIMULATOR.md) — emulator usage and internals
- [PVXS Group JSON Reference](docs/tcmd_group_json_reference.md) — QSRV2 group JSON syntax
