#!/bin/sh
cd $HOME

if [ -z "$PROTOCOL" ]; then
    PROTOCOL=tcp
fi

if [ -z "$SERVER" ]; then
    SERVER=$( \
        wget -q -O - 'https://nordvpn.com/wp-admin/admin-ajax.php?action=servers_recommendations' | \
        jq --arg type "openvpn_${PROTOCOL}" -r '.[] | select(.status == "online") | select(.technologies[].identifier == $type) | .hostname' | \
        shuf | \
        head -n1
    )
elif [ ${#SERVER} -eq 2 ]; then
    SERVER=$( \
        find "ovpn_${PROTOCOL}" -type f -name "${SERVER}*.ovpn" -print | \
        cut -d / -f 2 | \
        cut -d . -f 1-3 | \
        shuf | \
        head -n1
    )
fi

openvpn \
    --config "ovpn_${PROTOCOL}/${SERVER}.${PROTOCOL}.ovpn" \
    --auth-user-pass auth.txt \
    --script-security 2 \
    --up up.sh
