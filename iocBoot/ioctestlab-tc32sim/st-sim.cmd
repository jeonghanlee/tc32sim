#!../../bin/linux-x86_64/tc32sim

< envPaths

epicsEnvSet("DB_TOP",           "$(TOP)/db")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(DB_TOP)")
epicsEnvSet("IOCSH_LOCAL_TOP",   "$(TOP)/iocsh")

epicsEnvSet("IOCNAME", "testlab-tc32sim")
epicsEnvSet("IOC",     "ioctestlab-tc32sim")

dbLoadDatabase "$(TOP)/dbd/tc32sim.dbd"
tc32sim_registerRecordDeviceDriver pdbbase

cd "${TOP}/iocBoot/${IOC}"

# --- Device 01 ---
epicsEnvSet("PORT1",    "TCP001")
epicsEnvSet("P1",       "TC32:001:")
epicsEnvSet("TCPPORT1", "9400")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT1),P=$(P1),TCP_PORT=$(TCPPORT1),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 02 ---
epicsEnvSet("PORT2",    "TCP002")
epicsEnvSet("P2",       "TC32:002:")
epicsEnvSet("TCPPORT2", "9401")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT2),P=$(P2),TCP_PORT=$(TCPPORT2),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 03 ---
epicsEnvSet("PORT3",    "TCP003")
epicsEnvSet("P3",       "TC32:003:")
epicsEnvSet("TCPPORT3", "9402")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT3),P=$(P3),TCP_PORT=$(TCPPORT3),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 04 ---
epicsEnvSet("PORT4",    "TCP004")
epicsEnvSet("P4",       "TC32:004:")
epicsEnvSet("TCPPORT4", "9403")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT4),P=$(P4),TCP_PORT=$(TCPPORT4),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 05 ---
epicsEnvSet("PORT5",    "TCP005")
epicsEnvSet("P5",       "TC32:005:")
epicsEnvSet("TCPPORT5", "9404")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT5),P=$(P5),TCP_PORT=$(TCPPORT5),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 06 ---
epicsEnvSet("PORT6",    "TCP006")
epicsEnvSet("P6",       "TC32:006:")
epicsEnvSet("TCPPORT6", "9405")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT6),P=$(P6),TCP_PORT=$(TCPPORT6),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 07 ---
epicsEnvSet("PORT7",    "TCP007")
epicsEnvSet("P7",       "TC32:007:")
epicsEnvSet("TCPPORT7", "9406")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT7),P=$(P7),TCP_PORT=$(TCPPORT7),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 08 ---
epicsEnvSet("PORT8",    "TCP008")
epicsEnvSet("P8",       "TC32:008:")
epicsEnvSet("TCPPORT8", "9407")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT8),P=$(P8),TCP_PORT=$(TCPPORT8),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 09 ---
epicsEnvSet("PORT9",    "TCP009")
epicsEnvSet("P9",       "TC32:009:")
epicsEnvSet("TCPPORT9", "9408")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT9),P=$(P9),TCP_PORT=$(TCPPORT9),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 10 ---
epicsEnvSet("PORT10",    "TCP010")
epicsEnvSet("P10",       "TC32:010:")
epicsEnvSet("TCPPORT10", "9409")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT10),P=$(P10),TCP_PORT=$(TCPPORT10),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 11 ---
epicsEnvSet("PORT11",    "TCP011")
epicsEnvSet("P11",       "TC32:011:")
epicsEnvSet("TCPPORT11", "9410")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT11),P=$(P11),TCP_PORT=$(TCPPORT11),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 12 ---
epicsEnvSet("PORT12",    "TCP012")
epicsEnvSet("P12",       "TC32:012:")
epicsEnvSet("TCPPORT12", "9411")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT12),P=$(P12),TCP_PORT=$(TCPPORT12),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 13 ---
epicsEnvSet("PORT13",    "TCP013")
epicsEnvSet("P13",       "TC32:013:")
epicsEnvSet("TCPPORT13", "9412")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT13),P=$(P13),TCP_PORT=$(TCPPORT13),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 14 ---
epicsEnvSet("PORT14",    "TCP014")
epicsEnvSet("P14",       "TC32:014:")
epicsEnvSet("TCPPORT14", "9413")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT14),P=$(P14),TCP_PORT=$(TCPPORT14),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 15 ---
epicsEnvSet("PORT15",    "TCP015")
epicsEnvSet("P15",       "TC32:015:")
epicsEnvSet("TCPPORT15", "9414")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT15),P=$(P15),TCP_PORT=$(TCPPORT15),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 16 ---
epicsEnvSet("PORT16",    "TCP016")
epicsEnvSet("P16",       "TC32:016:")
epicsEnvSet("TCPPORT16", "9415")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT16),P=$(P16),TCP_PORT=$(TCPPORT16),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 17 ---
epicsEnvSet("PORT17",    "TCP017")
epicsEnvSet("P17",       "TC32:017:")
epicsEnvSet("TCPPORT17", "9416")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT17),P=$(P17),TCP_PORT=$(TCPPORT17),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 18 ---
epicsEnvSet("PORT18",    "TCP018")
epicsEnvSet("P18",       "TC32:018:")
epicsEnvSet("TCPPORT18", "9417")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT18),P=$(P18),TCP_PORT=$(TCPPORT18),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 19 ---
epicsEnvSet("PORT19",    "TCP019")
epicsEnvSet("P19",       "TC32:019:")
epicsEnvSet("TCPPORT19", "9418")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT19),P=$(P19),TCP_PORT=$(TCPPORT19),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 20 ---
epicsEnvSet("PORT20",    "TCP020")
epicsEnvSet("P20",       "TC32:020:")
epicsEnvSet("TCPPORT20", "9419")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT20),P=$(P20),TCP_PORT=$(TCPPORT20),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 21 ---
epicsEnvSet("PORT21",    "TCP021")
epicsEnvSet("P21",       "TC32:021:")
epicsEnvSet("TCPPORT21", "9420")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT21),P=$(P21),TCP_PORT=$(TCPPORT21),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 22 ---
epicsEnvSet("PORT22",    "TCP022")
epicsEnvSet("P22",       "TC32:022:")
epicsEnvSet("TCPPORT22", "9421")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT22),P=$(P22),TCP_PORT=$(TCPPORT22),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 23 ---
epicsEnvSet("PORT23",    "TCP023")
epicsEnvSet("P23",       "TC32:023:")
epicsEnvSet("TCPPORT23", "9422")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT23),P=$(P23),TCP_PORT=$(TCPPORT23),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 24 ---
epicsEnvSet("PORT24",    "TCP024")
epicsEnvSet("P24",       "TC32:024:")
epicsEnvSet("TCPPORT24", "9423")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT24),P=$(P24),TCP_PORT=$(TCPPORT24),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 25 ---
epicsEnvSet("PORT25",    "TCP025")
epicsEnvSet("P25",       "TC32:025:")
epicsEnvSet("TCPPORT25", "9424")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT25),P=$(P25),TCP_PORT=$(TCPPORT25),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 26 ---
epicsEnvSet("PORT26",    "TCP026")
epicsEnvSet("P26",       "TC32:026:")
epicsEnvSet("TCPPORT26", "9425")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT26),P=$(P26),TCP_PORT=$(TCPPORT26),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 27 ---
epicsEnvSet("PORT27",    "TCP027")
epicsEnvSet("P27",       "TC32:027:")
epicsEnvSet("TCPPORT27", "9426")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT27),P=$(P27),TCP_PORT=$(TCPPORT27),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 28 ---
epicsEnvSet("PORT28",    "TCP028")
epicsEnvSet("P28",       "TC32:028:")
epicsEnvSet("TCPPORT28", "9427")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT28),P=$(P28),TCP_PORT=$(TCPPORT28),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 29 ---
epicsEnvSet("PORT29",    "TCP029")
epicsEnvSet("P29",       "TC32:029:")
epicsEnvSet("TCPPORT29", "9428")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT29),P=$(P29),TCP_PORT=$(TCPPORT29),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 30 ---
epicsEnvSet("PORT30",    "TCP030")
epicsEnvSet("P30",       "TC32:030:")
epicsEnvSet("TCPPORT30", "9429")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT30),P=$(P30),TCP_PORT=$(TCPPORT30),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 31 ---
epicsEnvSet("PORT31",    "TCP031")
epicsEnvSet("P31",       "TC32:031:")
epicsEnvSet("TCPPORT31", "9430")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT31),P=$(P31),TCP_PORT=$(TCPPORT31),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 32 ---
epicsEnvSet("PORT32",    "TCP032")
epicsEnvSet("P32",       "TC32:032:")
epicsEnvSet("TCPPORT32", "9431")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT32),P=$(P32),TCP_PORT=$(TCPPORT32),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 33 ---
epicsEnvSet("PORT33",    "TCP033")
epicsEnvSet("P33",       "TC32:033:")
epicsEnvSet("TCPPORT33", "9432")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT33),P=$(P33),TCP_PORT=$(TCPPORT33),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 34 ---
epicsEnvSet("PORT34",    "TCP034")
epicsEnvSet("P34",       "TC32:034:")
epicsEnvSet("TCPPORT34", "9433")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT34),P=$(P34),TCP_PORT=$(TCPPORT34),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 35 ---
epicsEnvSet("PORT35",    "TCP035")
epicsEnvSet("P35",       "TC32:035:")
epicsEnvSet("TCPPORT35", "9434")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT35),P=$(P35),TCP_PORT=$(TCPPORT35),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 36 ---
epicsEnvSet("PORT36",    "TCP036")
epicsEnvSet("P36",       "TC32:036:")
epicsEnvSet("TCPPORT36", "9435")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT36),P=$(P36),TCP_PORT=$(TCPPORT36),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 37 ---
epicsEnvSet("PORT37",    "TCP037")
epicsEnvSet("P37",       "TC32:037:")
epicsEnvSet("TCPPORT37", "9436")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT37),P=$(P37),TCP_PORT=$(TCPPORT37),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 38 ---
epicsEnvSet("PORT38",    "TCP038")
epicsEnvSet("P38",       "TC32:038:")
epicsEnvSet("TCPPORT38", "9437")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT38),P=$(P38),TCP_PORT=$(TCPPORT38),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 39 ---
epicsEnvSet("PORT39",    "TCP039")
epicsEnvSet("P39",       "TC32:039:")
epicsEnvSet("TCPPORT39", "9438")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT39),P=$(P39),TCP_PORT=$(TCPPORT39),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 40 ---
epicsEnvSet("PORT40",    "TCP040")
epicsEnvSet("P40",       "TC32:040:")
epicsEnvSet("TCPPORT40", "9439")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT40),P=$(P40),TCP_PORT=$(TCPPORT40),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 41 ---
epicsEnvSet("PORT41",    "TCP041")
epicsEnvSet("P41",       "TC32:041:")
epicsEnvSet("TCPPORT41", "9440")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT41),P=$(P41),TCP_PORT=$(TCPPORT41),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 42 ---
epicsEnvSet("PORT42",    "TCP042")
epicsEnvSet("P42",       "TC32:042:")
epicsEnvSet("TCPPORT42", "9441")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT42),P=$(P42),TCP_PORT=$(TCPPORT42),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 43 ---
epicsEnvSet("PORT43",    "TCP043")
epicsEnvSet("P43",       "TC32:043:")
epicsEnvSet("TCPPORT43", "9442")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT43),P=$(P43),TCP_PORT=$(TCPPORT43),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 44 ---
epicsEnvSet("PORT44",    "TCP044")
epicsEnvSet("P44",       "TC32:044:")
epicsEnvSet("TCPPORT44", "9443")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT44),P=$(P44),TCP_PORT=$(TCPPORT44),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 45 ---
epicsEnvSet("PORT45",    "TCP045")
epicsEnvSet("P45",       "TC32:045:")
epicsEnvSet("TCPPORT45", "9444")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT45),P=$(P45),TCP_PORT=$(TCPPORT45),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 46 ---
epicsEnvSet("PORT46",    "TCP046")
epicsEnvSet("P46",       "TC32:046:")
epicsEnvSet("TCPPORT46", "9445")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT46),P=$(P46),TCP_PORT=$(TCPPORT46),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 47 ---
epicsEnvSet("PORT47",    "TCP047")
epicsEnvSet("P47",       "TC32:047:")
epicsEnvSet("TCPPORT47", "9446")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT47),P=$(P47),TCP_PORT=$(TCPPORT47),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 48 ---
epicsEnvSet("PORT48",    "TCP048")
epicsEnvSet("P48",       "TC32:048:")
epicsEnvSet("TCPPORT48", "9447")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT48),P=$(P48),TCP_PORT=$(TCPPORT48),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 49 ---
epicsEnvSet("PORT49",    "TCP049")
epicsEnvSet("P49",       "TC32:049:")
epicsEnvSet("TCPPORT49", "9448")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT49),P=$(P49),TCP_PORT=$(TCPPORT49),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 50 ---
epicsEnvSet("PORT50",    "TCP050")
epicsEnvSet("P50",       "TC32:050:")
epicsEnvSet("TCPPORT50", "9449")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT50),P=$(P50),TCP_PORT=$(TCPPORT50),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 51 ---
epicsEnvSet("PORT51",    "TCP051")
epicsEnvSet("P51",       "TC32:051:")
epicsEnvSet("TCPPORT51", "9450")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT51),P=$(P51),TCP_PORT=$(TCPPORT51),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 52 ---
epicsEnvSet("PORT52",    "TCP052")
epicsEnvSet("P52",       "TC32:052:")
epicsEnvSet("TCPPORT52", "9451")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT52),P=$(P52),TCP_PORT=$(TCPPORT52),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 53 ---
epicsEnvSet("PORT53",    "TCP053")
epicsEnvSet("P53",       "TC32:053:")
epicsEnvSet("TCPPORT53", "9452")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT53),P=$(P53),TCP_PORT=$(TCPPORT53),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 54 ---
epicsEnvSet("PORT54",    "TCP054")
epicsEnvSet("P54",       "TC32:054:")
epicsEnvSet("TCPPORT54", "9453")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT54),P=$(P54),TCP_PORT=$(TCPPORT54),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 55 ---
epicsEnvSet("PORT55",    "TCP055")
epicsEnvSet("P55",       "TC32:055:")
epicsEnvSet("TCPPORT55", "9454")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT55),P=$(P55),TCP_PORT=$(TCPPORT55),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 56 ---
epicsEnvSet("PORT56",    "TCP056")
epicsEnvSet("P56",       "TC32:056:")
epicsEnvSet("TCPPORT56", "9455")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT56),P=$(P56),TCP_PORT=$(TCPPORT56),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 57 ---
epicsEnvSet("PORT57",    "TCP057")
epicsEnvSet("P57",       "TC32:057:")
epicsEnvSet("TCPPORT57", "9456")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT57),P=$(P57),TCP_PORT=$(TCPPORT57),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 58 ---
epicsEnvSet("PORT58",    "TCP058")
epicsEnvSet("P58",       "TC32:058:")
epicsEnvSet("TCPPORT58", "9457")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT58),P=$(P58),TCP_PORT=$(TCPPORT58),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 59 ---
epicsEnvSet("PORT59",    "TCP059")
epicsEnvSet("P59",       "TC32:059:")
epicsEnvSet("TCPPORT59", "9458")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT59),P=$(P59),TCP_PORT=$(TCPPORT59),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 60 ---
epicsEnvSet("PORT60",    "TCP060")
epicsEnvSet("P60",       "TC32:060:")
epicsEnvSet("TCPPORT60", "9459")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT60),P=$(P60),TCP_PORT=$(TCPPORT60),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 61 ---
epicsEnvSet("PORT61",    "TCP061")
epicsEnvSet("P61",       "TC32:061:")
epicsEnvSet("TCPPORT61", "9460")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT61),P=$(P61),TCP_PORT=$(TCPPORT61),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 62 ---
epicsEnvSet("PORT62",    "TCP062")
epicsEnvSet("P62",       "TC32:062:")
epicsEnvSet("TCPPORT62", "9461")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT62),P=$(P62),TCP_PORT=$(TCPPORT62),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 63 ---
epicsEnvSet("PORT63",    "TCP063")
epicsEnvSet("P63",       "TC32:063:")
epicsEnvSet("TCPPORT63", "9462")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT63),P=$(P63),TCP_PORT=$(TCPPORT63),DATABASE_TOP=$(DB_TOP),PVX=")

# --- Device 64 ---
epicsEnvSet("PORT64",    "TCP064")
epicsEnvSet("P64",       "TC32:064:")
epicsEnvSet("TCPPORT64", "9463")
iocshLoad("$(IOCSH_LOCAL_TOP)/tc32sim.iocsh", "PORT=$(PORT64),P=$(P64),TCP_PORT=$(TCPPORT64),DATABASE_TOP=$(DB_TOP),PVX=")

iocInit

ClockTime_Report

dbl > ${IOCNAME}

