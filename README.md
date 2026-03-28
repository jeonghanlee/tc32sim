# tc32sim

TC-32 simulator IOC for miribom (미리봄) development and testing.

Replaces physical TC-32 hardware with a TCP stream emulator.
The IOC and PVA group object are structurally identical to the production TCMD IOC.

---

## Signal chain

```
tc32_emulator.bash          "CH01: 23.5\n" ... "CH32: 45.1\n"
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
```

### 2. Build IOC

```bash
source ~/EPICS-environment/1.2.0/debian-13/7.0.10/setEpicsEnv.bash
make
```

### 3. Start IOC

### 4. Verify PVA

```bash
pvxget TC32:001:group
pvxget -r "ch00.temp" TC32:001:group
pvxget TC32:064:group
```

---

## PV naming

| PV | Description |
|---|---|
| `TC32:NNN:group` | PVA group object (`alsu:nt/TC32:1.0`) |
| `TC32:NNN:Ti0` | Channel 0 temperature (mapped from CH01) |
| `TC32:NNN:Ti31` | Channel 31 temperature (mapped from CH32) |

TCP port = 9400 + (NNN − 1)


