#!/bin/bash
if [ ! -f ${STEAMCMD}/./steamcmd.sh ]; then
	echo "steam not found -- downloading"
	curl -o ${STEAMCMD}/steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
	tar --directory ${STEAMCMD} -xvzf ${STEAMCMD}/steamcmd_linux.tar.gz
	rm -v ${STEAMCMD}/steamcmd_linux.tar.gz
else
	echo "steam found"
fi

echo "download / update game"

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game.ini ]; then
	export COPY_CONFIG="true"
else
	export COPY_CONFIG="false"
fi

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


if [ "${COPY_CONFIG}" == "true" ]; then
	mkdir -p ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer
	curl -o ${GAME_DIR}/temp.ini "https://raw.githubusercontent.com/Tetricz/docker-mordhau-server/master/scripts/Game.ini"
	envsubst < "${GAME_DIR}/temp.ini" > "${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game.ini"
else
	echo "Game.ini found"
	echo "You will have to edit the file manually or delete it and restart the docker."
fi

echo "starting-server"

${GAME_DIR}/./MordhauServer.sh -log -port=$GAME_PORT -queryport=$QUERYPORT