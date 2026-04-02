# tc32sim — Simulator

## Overview

Three scripts manage the emulated TC-32 device pool.

```
simulator/
  tc32_emulator.bash      single device emulator
  run_simulators.bash     start / stop all 64 instances
  check_simulators.bash   verify all instances are streaming
```

---

## tc32_emulator.bash

Simulates one TC-32 device. Uses `socat` to create a TCP listener and streams
32 channels of temperature data continuously.

### Output format

```
CH00: 23.5
CH01: 41.8
...
CH31: 19.3
```

Channel numbering is 0-based. One full 32-channel cycle completes every ~0.3 s,
giving approximately 3 Hz update rate per channel.

### Temperature simulation

Temperatures are managed as integers in tenths of a degree (100–900 = 10.0–90.0 °C).
Each cycle applies a random change of ±0–7 tenths per channel using bash integer
arithmetic. No external processes are spawned during the main loop.

### Dependencies

| Command | Purpose |
|---|---|
| `socat` | TCP-to-PTY bridge |
| `mktemp` | Temporary log file for PTY device detection |

`bc` is not required.

### Usage

```bash
./simulator/tc32_emulator.bash                  # default port 9400
./simulator/tc32_emulator.bash --port 9401
```

### How it works

1. `socat` starts a TCP listener on the specified port and creates a PTY device
   (e.g. `/dev/pts/5`).
2. The script waits up to 20 seconds for the PTY path to appear in the socat log.
3. Temperature values are initialized randomly in the range 10.0–90.0 °C.
4. The main loop writes one `CH<NN>: <temp>` line per channel to the PTY.
   `socat` forwards each line to any connected TCP client.
5. On exit (`Ctrl+C` or signal), the `cleanup` trap kills the socat process and
   removes the temporary log file.

---

## run_simulators.bash

Starts or stops all 64 emulator instances.

### Usage

```bash
./simulator/run_simulators.bash           # start all 64 (ports 9400-9463)
./simulator/run_simulators.bash --stop    # kill all instances
```

### Port assignment

Device N uses port `9400 + N - 1`.

| Device | Port |
|---|---|
| 001 | 9400 |
| 002 | 9401 |
| ... | ... |
| 064 | 9463 |

### GNU parallel

When `parallel` is available, all 64 instances are launched concurrently with
`--jobs 64`, independent of the number of CPU cores. Each emulator is I/O bound
(`socat` waiting for TCP connections, PTY writes) so running 64 in parallel does
not saturate CPU.

If `parallel` is not available, instances are started as background processes.

---

## check_simulators.bash

Connects to each emulator port, reads one line, and verifies the format
matches `CH<NN>: <float>`.

### Usage

```bash
./simulator/check_simulators.bash              # check all 64
./simulator/check_simulators.bash --first 5   # check first 5 only
./simulator/check_simulators.bash --port 9400  # check one port
```

### Output

```
------------------------------------------------------------
Checking 64 emulator instances (timeout 2s per port)
------------------------------------------------------------
OK    device 001  port 9400  CH00: 23.5
OK    device 002  port 9401  CH00: 41.8
...
------------------------------------------------------------
Result: 64 OK  0 FAIL  (total 64)
------------------------------------------------------------
```

Exit code is 0 when all checked ports pass, non-zero otherwise.

### Requirements

`nc` (netcat) must be available and support `-w` (timeout) and `-q` flags.

---

## Typical workflow

```bash
# 1. Start all emulators
./simulator/run_simulators.bash

# 2. Verify before starting the IOC
./simulator/check_simulators.bash

# 3. Spot-check one device manually
nc localhost 9400

# 4. Stop all emulators
./simulator/run_simulators.bash --stop
```
