#!/bin/sh
cd $HOME

if [ -z "$PROTOCOL" ]; then
    PROTOCOL=tcp
fi

if [ -z "$SERVER" ]; then
    SERVER=nl868.nordvpn.com
fi

openvpn \
    --config "ovpn_${PROTOCOL}/${SERVER}.${PROTOCOL}.ovpn" \
    --auth-user-pass auth.txt \
    --script-security 2 \
    --up up.sh
