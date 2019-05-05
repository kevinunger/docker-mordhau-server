#!/bin/bash
if [ ! -f ${STEAMCMD}/./steamcmd.sh ]; then
	export copy_config="true"
	echo "steam not found -- downloading"
	curl -o ${STEAMCMD}/steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
	tar --directory ${STEAMCMD} -xvzf ${STEAMCMD}/steamcmd_linux.tar.gz
	rm -v ${STEAMCMD}/steamcmd_linux.tar.gz
else
	export copy_config="false"
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



if [ "${copy_config}" == "true" ]; then
	mkdir -p ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer
	curl - o ${GAME_DIR}/temp.ini "https://raw.githubusercontent.com/Tetricz/docker-mordhau-server/master/scripts/Game.ini"
	envsubst < "${GAME_DIR}/temp.ini" > "${GAME_DIR}/Mordhau/Saved/Config/LinuxServer"

echo "starting-server"

${GAME_DIR}/./MordhauServer.sh -log -port=$GAME_PORT -queryport=$QUERYPORT