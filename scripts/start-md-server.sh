#!/bin/bash
if [ ! -f ${STEAMCMD}/steamcmd.sh ]; then
    wget -q -O ${STEAMCMD}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD} -xvzf /opt/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD}/steamcmd_linux.tar.gz
fi

echo "update steamcmd"

if [ ! -f "${STEAMCMD}/public/steambootstrapper_english.txt" ]; then
    ${STEAMCMD}/steamcmd.sh \
    +login anonymous \
    +quit
fi

echo "download / update game"

if [ "${VALIDATE}" == "" ]; then
	${STEAMCMD}/steamcmd.sh \
	+runscript updatemordhau \
	+quit
else
	${STEAMCMD}/steamcmd.sh \
	+runscript validatemordhau \
	+quit
fi

echo "start-server"

${GAME_DIR}/./MordhauServer.sh
