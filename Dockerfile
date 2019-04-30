FROM ubuntu

MAINTAINER Tetricz

RUN apt-get update
RUN apt-get -y install lib32gcc1 wget
RUN apt-get -y install libfontconfig1 libpangocairo-1.0-0 libnss3 libgconf2-4 libxi6 libxcursor1 libxss1 libxcomposite1 libasound2 libxdamage1 libxtst6 libatk1.0-0 libxrandr2

ENV DATA="/opt"
ENV STEAMCMD="${DATA}/steamcmd"
ENV GAME_DIR="${DATA}/mordhau"
ENV GAME_ID="629800"
ENV VAC_PORT=27015
ENV GAME_PORT=7777
ENV GAME_PORT1=7778
ENV VALIDATE=""
ENV UID=99
ENV GID=100

RUN mkdir -p $DATA
RUN mkdir -p $STEAMCMD
RUN mkdir -p $GAME_DIR
RUN useradd -d $DATA -s /bin/bash --uid $UID --gid $GID steam
RUN chown -R steam $DATA

RUN mkdir -p /opt/scripts
ADD /scripts/ /opt/scripts/
COPY /scripts/updatemordhau.txt /opt/steamcmd/updatemordhau.txt
COPY /scripts/validatemordhau.txt /opt/steamcmd/validatemordhau.txt
RUN chmod -R 770 /opt/scripts/
RUN chown -R steam /opt

USER steam

EXPOSE $VAC_PORT/tcp
EXPOSE $GAME_PORT/udp
EXPOSE $GAME_PORT1/udp

ENTRYPOINT ["/opt/scripts/start-md-server.sh"]