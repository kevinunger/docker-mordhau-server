#!/bin/bash
#--------------------
#Applying Port offset
#--------------------
export QUERYPORT=$(expr ${QUERYPORT} + ${PORT_OFFSET})
echo "${QUERYPORT}"
export BEACONPORT=$(expr ${BEACONPORT} + ${PORT_OFFSET})
echo "${BEACONPORT}"
export GAME_PORT=$(expr ${GAME_PORT} + ${PORT_OFFSET})
echo "${GAME_PORT}"
#--------------------