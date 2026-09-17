#!../../bin/linux-x86_64/tc32sim

< envPaths

epicsEnvSet("DB_TOP",               "$(TOP)/db")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(DB_TOP)")
epicsEnvSet("IOCSH_LOCAL_TOP",      "$(TOP)/iocsh")
epicsEnvSet("IOCSH_TOP",            "$(EPICS_BASE)/../modules/commonIocsh")

epicsEnvSet("IOCNAME", "testlab-tc32sim")
epicsEnvSet("IOC",     "ioctestlab-tc32sim")

dbLoadDatabase "$(TOP)/dbd/tc32sim.dbd"
tc32sim_registerRecordDeviceDriver pdbbase

cd "${TOP}/iocBoot/${IOC}"

# --- Device 01 (single simulator) ---
epicsEnvSet("PORT1",    "TCP001")
epicsEnvSet("P1",       "TC32:001:")
epicsEnvSet("TCPPORT1", "9400")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT1),P=$(P1),TCP_PORT=$(TCPPORT1),DATABASE_TOP=$(DB_TOP),PVX=")

# --- linStat: host and process by default; one NIC (lo) and one filesystem (/) enabled ---
iocshLoad("$(IOCSH_TOP)/iocsh/linStat.iocsh", "IOC=$(IOC),NICENABLE=,NIC=lo,FSENABLE=,FSID=ROOT,DIR=/")

iocInit

ClockTime_Report

dbl > ${IOCNAME}
