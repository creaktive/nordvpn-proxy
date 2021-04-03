#!/bin/sh
cd $HOME

if [ -z "$PROTOCOL" ]; then
    PROTOCOL=tcp
fi

if [ -z "$SERVER" ]; then
    SERVER=nl868.nordvpn.com
fi

sed 's/auth-user-pass/auth-user-pass auth.txt/' "ovpn_${PROTOCOL}/${SERVER}.${PROTOCOL}.ovpn" > nordvpn.ovpn
openvpn --config nordvpn.ovpn --daemon
sleep 5
service danted start

echo "<Ctrl-C> to end"
tail -F /var/log/danted.log
