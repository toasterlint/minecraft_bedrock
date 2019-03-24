FROM ubuntu:latest
LABEL maintainer="henry@toasterlint.com"

RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y install unzip curl wget libxml2-utils && mkdir /data && groupadd -g 1000 minecraft && useradd -u 1000 -g 1000 -r minecraft

RUN wget -O /opt/bedrock_server.zip $(wget -q -O - https://minecraft.net/en-us/download/server/bedrock/ | xmllint --html --xpath '/html/body/div/div/div[3]/main/div/div/div/div/div/div/div[1]/div[2]/div/div/div[2]/div[3]/div/a' - 2>/dev/null | grep -zoP '<a[^<][^<]*href="\K[^"]+')
ADD start.sh /opt/start.sh
RUN chown -R minecraft:minecraft /data && chmod +x /opt/start.sh

USER minecraft:minecraft
RUN cd /data

VOLUME /data
WORKDIR /data

EXPOSE 19132
EXPOSE 19132/udp

CMD ["/opt/start.sh"]
