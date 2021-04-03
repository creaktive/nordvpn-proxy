# docker build -t nordvpn-socks .
# docker run -it --privileged --rm --dns=8.8.8.8 --env SERVER=nl868.nordvpn.com --env PROTOCOL=udp -p 1080:1080 nordvpn-socks:latest
FROM ubuntu:18.04

EXPOSE 1080

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    dante-server \
    openvpn \
    unzip \
    wget
RUN apt-get -y clean

WORKDIR /root

RUN wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
RUN unzip ovpn.zip
RUN rm ovpn.zip

ADD danted.conf /etc/danted.conf
ADD auth.txt .
ADD setup.sh .

CMD [ "./setup.sh" ]
