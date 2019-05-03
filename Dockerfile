FROM ubuntu

MAINTAINER Tetricz

RUN apt-get update
RUN apt-get -y install curl lib32gcc1 libfontconfig1 libpangocairo-1.0-0 libnss3 libgconf2-4 libxi6 libxcursor1 libxss1 libxcomposite1 libasound2 libxdamage1 libxtst6 libatk1.0-0 libxrandr2

ENV DATA_DIR="/serverdata"
ENV STEAMCMD="${DATA_DIR}/steamcmd"
ENV GAME_DIR="${DATA_DIR}/mordhau"
ENV QUERYPORT="27015"
ENV GAME_PORT="7777"
ENV VALIDATE=""
ENV UID="99"
ENV GID="100"

RUN mkdir -p $DATA_DIR
RUN mkdir -p $STEAMCMD
RUN mkdir -p $GAME_DIR
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID steam
RUN chown -R $UID:$GID $DATA_DIR

RUN ulimit -n 2048

VOLUME /serverdata

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R $UID:$GID /opt/scripts

USER steam

ENTRYPOINT ["/opt/scripts/start-md-server.sh"]