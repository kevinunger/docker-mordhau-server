#!/bin/bash

#---------------------
#Install Steam Command
#---------------------
if [ ! -f ${STEAMCMD}/./steamcmd.sh ]; then
	echo "steam not found -- downloading"
	curl -o ${STEAMCMD}/steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
	tar --directory ${STEAMCMD} -xvzf ${STEAMCMD}/steamcmd_linux.tar.gz
	rm -v ${STEAMCMD}/steamcmd_linux.tar.gz
else
	echo "steam found"
fi
#---------------------

#------------------------
#Connect to steam Download and Update Game
#------------------------
if [ "${STEAM_CONNECT}" == "True" ]; then
	echo "${STEAM_CONNECT}"
	echo "downloading / updating game"
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
else
	echo "Steam is disabled for this containter"
fi
#------------------------

#--------------------------------------------------------------------------------
#Setting Gamemode -- If anyone knows a better way to do this. Please let me know.
#--------------------------------------------------------------------------------
if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "FL" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/TaigaMap/FL_Taiga.FL_Taiga"
		export MAP1="MapRotation=FL_Taiga" \
		MAP2="MapRotation=FL_MountainPeak" \
		MAP3="MapRotation=FL_Camp" \
		MAP4="MapRotation=FL_Grad"
	fi
fi

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "SKM" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/DuelCamp/SKM_Camp.SKM_Camp"
		export MAP1="MapRotation=SKM_Contraband" \
		MAP2="MapRotation=SKM_Camp" \
		MAP3="MapRotation=SKM_Grad" \
		MAP4="MapRotation=SKM_ThePit" \
		MAP5="MapRotation=SKM_MountainPeak" \
		MAP6="MapRotation=SKM_Tourney" \
		MAP7="MapRotation=SKM_Tiaga"
	fi
fi

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "SKM_64" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/DuelCamp/SKM_Camp.SKM_Camp"
		export MAP1="MapRotation=SKM_Taiga_64" \
		MAP2="MapRotation=SKM_MountainPeak_64" \
		MAP3="MapRotation=SKM_Grad_64" \
		MAP4="MapRotation=SKM_Camp_64"
	fi
fi

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "TDM" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/ThePit/TDM_ThePit.TDM_ThePit"
		export MAP1="MapRotation=TDM_Contraband" \
		MAP2="MapRotation=TDM_Camp" \
		MAP3="MapRotation=TDM_Grad" \
		MAP4="MapRotation=TDM_ThePit" \
		MAP5="MapRotation=TDM_MountainPeak" \
		MAP6="MapRotation=TDM_Taiga" \
		MAP7="MapRotation=TDM_Tourney"
	fi
fi

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "TDM_64" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/ThePit/TDM_ThePit.TDM_ThePit"
		export MAP1="MapRotation=TDM_Contraband" \
		MAP2="MapRotation=TDM_Camp" \
		MAP3="MapRotation=TDM_Grad" \
		MAP4="MapRotation=TDM_ThePit" \
		MAP5="MapRotation=TDM_MountainPeak" \
		MAP6="MapRotation=TDM_Taiga" \
		MAP7="MapRotation=TDM_Tourney" 
		MAP8="MapRotation=TDM_Taiga_64" \
		MAP9="MapRotation=TDM_Camp_64"
	fi
fi

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "FFA" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/ThePit/FFA_ThePit.FFA_ThePit"
		export MAP1="MapRotation=FFA_Contraband" \
		MAP2="MapRotation=FFA_Camp" \
		MAP3="MapRotation=FFA_Grad" \
		MAP4="MapRotation=FFA_ThePit" \
		MAP5="MapRotation=FFA_MountainPeak" \
		MAP6="MapRotation=FFA_Taiga" \
		MAP7="MapRotation=FFA_Tourney"
	fi
fi
if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "HRD" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/DuelCamp/HRD_Camp.HRD_Camp"
		export MAP1="MapRotation=HRD_Camp" \
		MAP2="MapRotation=HRD_Grad" \
		MAP3="MapRotation=HRD_Taiga" \
		MAP4="MapRotation=HRD_MountainPeak"
	fi
fi

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "BR" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/TaigaMap/BR_Taiga.BR_Taiga"
		export MAP1="MapRotation=BR_Grad" \
		MAP2="MapRotation=BR_Taiga"
	fi
fi
if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	if [ "${GAME_MODE}" == "" ]; then
		export DEFAULTMAP="ServerDefaultMap=/Game/Mordhau/Maps/ThePit/FFA_ThePit.FFA_ThePit"
		export MAP1="MapRotation=FFA_Contraband" \
		MAP2="MapRotation=FFA_Camp" \
		MAP3="MapRotation=TDM_Grad" \
		MAP4="MapRotation=FFA_ThePit" \
		MAP5="MapRotation=TDM_Camp" \
		MAP6="MapRotation=TDM_ThePit" \
		MAP7="MapRotation=FFA_Tourney"
	fi
fi
#--------------------------------------------------------------------------------

#------------------------------------------
#Copying default config and change settings
#------------------------------------------
echo "Checking Game.ini"

if [ ! -f ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini ]; then
	export COPY_CONFIG="true"
else
	echo "Game.ini found"
	export COPY_CONFIG="false"
fi

if [ "${COPY_CONFIG}" == "true" ]; then
	mkdir -p ${GAME_DIR}/Mordhau/Saved/Config/LinuxServer
	curl -o ${GAME_DIR}/temp.ini "https://raw.githubusercontent.com/Tetricz/docker-mordhau-server/experimental/scripts/Game.ini"
	envsubst < "${GAME_DIR}/temp.ini" > "${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini"
	rm -v "${GAME_DIR}/temp.ini"
	curl -o ${GAME_DIR}/temp2.ini "https://raw.githubusercontent.com/Tetricz/docker-mordhau-server/experimental/scripts/Engine.ini"
	envsubst < "${GAME_DIR}/temp2.ini" > "${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Engine${SERVER}.ini"
	rm -v "${GAME_DIR}/temp2.ini"
fi
#--------------------------------------------


echo "starting-server"

${GAME_DIR}/./MordhauServer.sh -log -port=$GAME_PORT -queryport=$QUERYPORT -BeaconPort=$BEACONPORT -GAMEINI=${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Game${SERVER}.ini -ENGINEINI=${GAME_DIR}/Mordhau/Saved/Config/LinuxServer/Engine${SERVER}.ini
