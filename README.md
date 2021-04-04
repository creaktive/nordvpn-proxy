
docker build -t nordvpn-socks .
docker run -it --privileged --rm --dns=8.8.8.8 --env SERVER=nl868.nordvpn.com --env PROTOCOL=udp -p 1080:1080 -p 3128:3128 nordvpn-socks
