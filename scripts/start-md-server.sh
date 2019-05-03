#!/bin/bash
if [ ! -f ${STEAMCMD}/./steamcmd.sh ]; then
	echo "steam not found"
	curl -o ${STEAMCMD}/steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
	tar --directory ${STEAMCMD} -xvzf ${STEAMCMD}/steamcmd_linux.tar.gz
	rm -v ${STEAMCMD}/steamcmd_linux.tar.gz	
fi

echo "download / update game"

if [ "${VALIDATE}" == "" ]; then
	${STEAMCMD}/./steamcmd.sh \
	+login anonymous \
	+force_install_dir ${GAME_DIR} \
	+app_update 629800 \
	+quit 
else
	${STEAMCMD}/./steamcmd.sh \
	+login anonymous \
	+force_install_dir ${GAME_DIR} \
	+app_update 629800 validate\
	+quit 
fi

echo "start-server"

${GAME_DIR}/./MordhauServer.sh -log -port=$GAME_PORT -queryport=$QUERYPORT