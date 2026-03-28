# tc32sim PVA Object — Command Line Usage

## Get

Read the entire object:

```bash
pvxget TC32:001:group
```

Read a specific field using `-r`:

```bash
pvxget -r "device.model"      TC32:001:group
pvxget -r "device.error"      TC32:001:group
pvxget -r "tc32.poll_time_ms" TC32:001:group
pvxget -r "ch00.temp"         TC32:001:group
pvxget -r "ch31.temp"         TC32:001:group
```

## Monitor

Subscribe to live updates:

```bash
pvxmonitor TC32:001:group
pvxmonitor -r "ch00.temp" TC32:001:group
```

## Put

Write to a writable field. NTScalar fields require the `.value` suffix:

```bash
pvxput TC32:001:group tc32.poll_sleep_ms.value=100
```

## Verify all 64 devices

```bash
for n in $(seq -f "%03g" 1 64); do
    pvxget -r "device.model" TC32:${n}:group
done
```

## Field reference

### device — common skeleton

| Field | Type | Access |
|---|---|---|
| `device.model` | string | read |
| `device.serial` | string | read |
| `device.firmware` | string | read |
| `device.error` | string | read, monitor |

### tc32 — device-specific

| Field | Type | Access |
|---|---|---|
| `tc32.model_number` | string | read |
| `tc32.ul_version` | string | read |
| `tc32.driver_version` | string | read |
| `tc32.unique_id` | string | read |
| `tc32.poll_time_ms` | double | read, monitor |
| `tc32.poll_sleep_ms` | double | read, write |

### chNN — channel payload (ch00 to ch31)

| Field | Type | Access |
|---|---|---|
| `chNN.desc` | string | read |
| `chNN.temp` | double | read, monitor |
| `chNN.egu` | string | read, monitor |
| `chNN.scale` | int | read, monitor |
| `chNN.tc_type` | int | read, monitor |
| `chNN.filter` | int | read, monitor |
| `chNN.open_detect` | int | read, monitor |
