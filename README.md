# Mordhau 

* [(/Dockerfile)](https://github.com/Tetricz/docker-mordhau-server/blob/master/Dockerfile)

# What is Mordhau?
https://mordhau.com/faq/#what-is-mordhau

Mordhau is a multiplayer medieval first-person fighting game with a strong emphasis on skill-based competitive play and customization.
It features a deep and fluid combat system that allows those that master it to turn into an unstoppable force on the battlefield.

NOTE: This is only the server. You still have to buy the game. (https://store.steampowered.com/app/629760/)

## Quick Start

Before running create the necessary folder structure. For this example data is stored in `/opt/mordhau`.
```
mkdir -p /opt/mordhau
chown 99:100 /opt/mordhau
```
For a Steam directory in case you want to run multiple containers.
```
mkdir -p /opt/steamcmd
chown -R 99:100 /opt
```
The `chown` command is needed because we don't run the game server as root for security reasons, but rather as a 'steam' user with user id 99:100(by default). The host must therefore allow these files to be written by that user.
```
mkdir -p /home/<user>/mordhau
chown 99:100 /home/<user>/mordhau
```

For those new to Docker, here is an explanation of the options:

* `-d` - Run as a daemon ("detached").
* `-p` - Expose ports. The left side is what the world sees.
* `-v` - Mount `/opt/mordhau` on the local file system to `/mordhau` in the container.
* `--restart` - Restart the server if it crashes and at system start unless you have stopped it
* `--name` - Name the container "mordhau" (otherwise it has a funny random name).
* `-e` - Change the ENV to something else. `-e VALIDATE=false` will make stop steam from validating game files.

Environment variables that should be changed.
```
-e STEAMID64=""
-e PLAYER_COUNT="16"
-e SERVER_NAME="PLZ CHANGE"
-e SERVER_PASSWORD=""
-e ADMIN_PASSWORD=""
-e QUERYPORT=27015
-e GAME_PORT=7777
```
Run the server :
```
docker run -d \
 -p 27015:27015/udp \
 -p 7777:7777/udp \
 -e QUERYPORT=27015 \
 -e GAME_PORT=7777 \
 -e STEAMID64="" \
 -e PLAYER_COUNT="16" \
 -e SERVER_NAME="PLZ CHANGE" \
 -e SERVER_PASSWORD="" \
 -e ADMIN_PASSWORD="" \
 --net=bridge \
 --restart=unless-stopped \
 -v /opt/mordhau:/serverdata/mordhau \
 -v /opt/steamcmd:/serverdata/steamcmd \
 --name mordhau tetricz/mordhau-server
```

If you get an error where it says "read-only file system" somewhere at the end. It's a permission issue and you chould change the path to one elsewhere or correct the permissions.

Check the logs to see what happened:

```
docker logs mordhau
```

Stop the server:

```
docker stop mordhau
```

In order to customize the server you must go to /opt/mordhau/Mordhau/Saved/Config/LinuxServer, there you will find (Game.ini). In order to make yourself an admin you need your SteamID64. Go here to find yours: https://steamid.io/

Tips for map rotation.
```
Front Line:
MapRotation=FL_Taiga
MapRotation=FL_MountainPeak
MapRotation=FL_Camp
MapRotation=FL_Grad

Skirmage:
MapRotation=SKM_Contraband
MapRotation=SKM_Camp
MapRotation=SKM_Grad
MapRotation=SKM_ThePit
MapRotation=SKM_MountainPeak
MapRotation=SKM_Tourney
MapRotation=SKM_Tiaga

Skrimmage 64:
MapRotation=SKM_Taiga_64
MapRotation=SKM_MountainPeak_64
MapRotation=SKM_Grad_64
MapRotation=SKM_Camp_64

Team Death Match:
MapRotation=TDM_Contraband
MapRotation=TDM_Camp
MapRotation=TDM_Grad
MapRotation=TDM_ThePit
MapRotation=TDM_MountainPeak
MapRotation=TDM_Taiga
MapRotation=TDM_Tourney

Team Death Match 64 player:
MapRotation=TDM_Taiga_64
MapRotation=TDM_Camp_64

Deathmatch/Free For All:
MapRotation=FFA_Contraband
MapRotation=FFA_Camp
MapRotation=FFA_Grad
MapRotation=FFA_ThePit
MapRotation=FFA_MountainPeak
MapRotation=FFA_Taiga
MapRotation=FFA_Tourney

Horde:
MapRotation=HRD_Camp
MapRotation=HRD_Grad
MapRotation=HRD_Taiga
MapRotation=HRD_MountainPeak

Battle Royal:
MapRotation=BR_Grad
MapRotation=BR_Taiga
```
Start the server:
```
docker start mordhau
```

Try to connect to the server. Check the logs if it isn't working.
