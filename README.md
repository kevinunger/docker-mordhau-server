# Mordhau 

* [(/Dockerfile)](https://github.com/Tetricz/docker-mordhau-server/blob/master/Dockerfile)

# What is Mordhau?
https://mordhau.com/faq/#what-is-mordhau

Mordhau is a multiplayer medieval first-person fighting game with a strong emphasis on skill-based competitive play and customization.
It features a deep and fluid combat system that allows those that master it to turn into an unstoppable force on the battlefield.

NOTE: This is only the server. You still have to buy the game. (https://store.steampowered.com/app/629760/)

## Network Speeds
```
Upload
16 players, ~4 mbit/s
48 players, ~10 mbit/s
64 players, ~16 mbit/s
Download - Same as upload
```

## Quick Start

Before running create the necessary folder structure and configuration files. For this example data is stored in `/opt/mordhau`.
```
mkdir -p /opt/mordhau
chown 99:100 /opt/mordhau
```
For a Steam directory in case you want to run multiple containers.
```
mkdir -p /opt/steamcmd
chown 99:100 /opt/steamcmd
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

You can also use:

`-e` - Change the ENV to something else. `-e VALIDATE=True` will make steam validate the server files.

You can use this to change the ports for the server will listen on if you plan to run multiple using the same machine.
```
-e QUERYPORT=27015
-e GAME_PORT=7777
```
Run the server :
```
docker run -d \
 -p 27015:27015/udp \
 -p 7777:7777/udp \
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

Tips for map rotation. (The default map and gamemode is FFA_ThePit. There is no way around this other than changing level or waiting for map rotation.)

Ex: FL_Taiga would be frontline on Taiga
```
Gamemodes
FL = Frontline
BR = Battle Royale
HRD = Horde
SKM = Skirmish
FFA = FFA/Deathmatch
TDM = Team Deathmatch
```
```
Maps
ThePit
Camp
Grad
Contraband
Tourney
MountainPeak
Taiga
```
Start the server:
```
docker start mordhau
```

Try to connect to the server. Check the logs if it isn't working.
