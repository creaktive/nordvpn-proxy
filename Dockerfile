FROM ubuntu:20.04

EXPOSE 1080
EXPOSE 3128

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    ca-certificates \
    dante-server \
    jq \
    openvpn \
    squid \
    unzip \
    wget
RUN apt-get -y clean

WORKDIR /root

RUN wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
RUN unzip ovpn.zip
RUN rm ovpn.zip

ADD danted.conf /etc
ADD squid.conf /etc/squid
ADD run.sh .
ADD up.sh .
ADD auth.txt .

CMD [ "./run.sh" ]
