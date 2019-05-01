# Mordhau 

* As of 29.4.2019 [(/Dockerfile)](https://github.com/Tetricz/docker-mordhau-server/blob/master/Dockerfile)

# What is Mordhau?
https://mordhau.com/faq/#what-is-mordhau

Mordhau is a multiplayer medieval first-person fighting game with a strong emphasis on skill-based competitive play and customization.
It features a deep and fluid combat system that allows those that master it to turn into an unstoppable force on the battlefield.

NOTE: This is only the server. You still have to buy the game. (https://store.steampowered.com/app/629760/)

## Quick Start

Run the server to create the necessary folder structure and configuration files. For this example data is stored in `/opt/mordhau`.

```
sudo mkdir -p /opt/mordhau

sudo chown 99:100 /opt/mordhau

docker run -d \
 -p 27015:27015/udp \
 -p 27015:27015 \
 -p 7777:7777 \
 -p 7778:7778 \
 -p 7777:7777/udp \
 -p 7778:7778/udp \
 --net=bridge \
 --restart=unless-stopped
 -v /opt/mordhau:/serverdata/mordhau \
 --name mordhau tetricz/mordhau-server
```

For those new to Docker, here is an explanation of the options:

* `-d` - Run as a daemon ("detached").
* `-p` - Expose ports.
* `-v` - Mount `/opt/mordhau` on the local file system to `/mordhau` in the container.
* `--restart` - Restart the server if it crashes and at system start unless you have stopped it
* `--name` - Name the container "mordhau" (otherwise it has a funny random name).

The `chown` command is needed because in 0.16+, we no longer run the game server as root for security reasons, but rather as a 'mordhau' user with user id 845. The host must therefore allow these files to be written by that user.

Check the logs to see what happened:

```
docker logs mordhau
```

Stop the server:

```
docker stop mordhau
```

In order to customize the server you must go to /opt/mordhau/Mordhau/Saved/Config/LinuxServer, there you will find (Game.ini). In order to make yourself an admin you need your SteamID64. Go here to find yours: https://steamid.io/

```
docker start mordhau
```

Try to connect to the server. Check the logs if it isn't working.
