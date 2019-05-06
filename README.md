# Mordhau 

* Latest [(/Dockerfile)](https://github.com/Tetricz/docker-mordhau-server/blob/master/Dockerfile)

# What is [Mordhau?](https://mordhau.com/faq/#what-is-mordhau)

Mordhau is a multiplayer medieval first-person fighting game with a strong emphasis on skill-based competitive play and customization.
It features a deep and fluid combat system that allows those that master it to turn into an unstoppable force on the battlefield.

NOTE: This is only the server. You still have to buy the game. (https://store.steampowered.com/app/629760/)

## Quick Start
Before running create the necessary folder structure. For this example the data is stored in `/opt/mordhau`.
```
mkdir -p /home/steam/mordhau /home/steam/steamcmd
chown -R 99:100 /home/steam
```
The `chown` command is needed because we don't run the game server as root for security reasons, but rather as a 'steam' user with user id 99:100(by default).

### Docker Compose
List of variables
```
PLAYER_COUNT=32
SERVER_NAME=
QUERYPORT=27015
GAME_PORT=7777
STEAMID64=
GAME_MODE=FL
SERVER=3
ADMIN_PASSWORD
```



### Docker Run

For those new to Docker, here is an explanation of the options:

* `-d` - Run as a daemon ("detached").
* `-p` - Expose ports. The left side is what the world sees.
* `-v` - Mount `/home/steam/mordhau` on the local file system to `/serverdata/mordhau` in the container. This allows you to see game
* `--restart` - Restart the server if it crashes and at system start unless you have stopped it
* `--name` - Name the container "mordhau" (otherwise it has a funny random name).
* `-e` - Change the ENV to something else. `-e VALIDATE=false` will make stop steam from validating game files.

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
 --restart=unless-stopped \
 -v /home/steam/mordhau:/serverdata/mordhau \
 -v /home/steam/steamcmd:/serverdata/steamcmd \
 --name mordhau tetricz/mordhau-server
```

Check the logs to see what happened:

```
docker logs mordhau
```

Stop the server:

```
docker stop mordhau
```

Start the server:
```
docker start mordhau
```

Try to connect to the server. Check the logs if it isn't working.
