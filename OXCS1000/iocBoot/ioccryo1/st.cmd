#!../../bin/linux-x86_64/cryo1

#- You may have to change cryo1 to something else
#- everywhere it appears in this file

< envPaths

epicsEnvSet ("STREAM_PROTOCOL_PATH","$(TOP)/db")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/cryo1.dbd"
cryo1_registerRecordDeviceDriver pdbbase

# CS1000 uses TCP for Status Packets or Commands
# Status Packets
drvAsynIPPortConfigure("L0", "131.243.79.222:10304 TCP", 0, 0, 0)
# Commands
drvAsynIPPortConfigure("OC_CMD", "131.243.79.222:10304 TCP", 0, 0, 0)

# Status Packet and Commands on a Single Port
dbLoadRecords("db/MDO.db", "P=OXCRYO:,Q=CS1000,PORT=L0,R=MDO:,L=0,A=0,PORTCMD=OC_CMD")

#- Set this to see messages from mySub

#var mySubDebug 1
#var streamError 1
#var streamDebug 1

#If are interested in saving logs, it can produce a few GBs of logs, use with caution
#streamSetLogfile("logfile.txt")

#- Set this to see messages from mySub
#-var mySubDebug 1

#- Run this to trace the stages of iocInit
#-traceIocInit

cd "${TOP}/iocBoot/${IOC}"

iocInit

