FROM ubuntu

MAINTAINER Tetricz

RUN apt-get update
RUN apt-get -y install curl lib32gcc1 libfontconfig1 gettext-base libpangocairo-1.0-0 libnss3 libgconf2-4 libxi6 libxcursor1 libxss1 libxcomposite1 libasound2 libxdamage1 libxtst6 libatk1.0-0 libxrandr2

ENV DATA_DIR="/serverdata" \
	STEAMCMD="${DATA_DIR}/steamcmd" \
	GAME_DIR="${DATA_DIR}/mordhau" \
	QUERYPORT="27015" \
	GAME_PORT="7777" \
	VALIDATE="TRUE" \
	UID="99" \
	GID="100" \
	STEAMID64="" \
	PLAYER_COUNT="16" \
	SERVER_NAME="PLZ CHANGE" \
	SERVER_PASSWORD="" \
	ADMIN_PASSWORD="" \
	GAME_MODE="" \
	SERVER=""

RUN mkdir -p ${DATA_DIR} \
	mkdir -p ${STEAMCMD} \
	mkdir -p ${GAME_DIR}
	
RUN	useradd -d ${DATA_DIR} -s /bin/bash --uid ${UID} --gid ${GID} steam
RUN	chown -R ${UID}:${GID} ${DATA_DIR}

RUN	ulimit -n 2048

VOLUME /serverdata

COPY /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R ${UID}:${GID} /opt/scripts

USER steam

ENTRYPOINT ["/opt/scripts/start-md-server.sh"]