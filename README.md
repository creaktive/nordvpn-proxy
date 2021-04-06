# nordvpn-proxy

## Description

Sometimes you want to hide your IP, but just for *one* specific application.
Or a couple; but certainly you do not want to completely switch to another network.

If your application does support SOCKS (or even HTTP) proxy, `nordvpn-proxy` is what you need!

However, please be aware that this is a very hacky solution, suitable for private use but definitely not production-ready (for whatever definition of "production").
You might want to check the links in [References](#References) for other solutions.

## Usage

First, go to the [Nord Account dashboard](https://my.nordaccount.com/dashboard/nordvpn/) to get the _service credentials_:

![Nord Account dashboard screenshot](https://nordvpn.nanorep.co/storage/nr1/kb/3E6DB546/3E6DB64A/3E6E330E/2/gdWAxjdVXb.png)

Paste the credentials to the `auth.txt` file within the same directory as `Dockerfile`.
Username is the first line; password is the second.

Now, build the thing (note that the aforementioned `auth.txt` file will be stored in plaintext within the container!):

```
docker build -t nordvpn-proxy .
```

Customize the parameters (`--env` arguments are optional; default is to use TCP and a recommended server) and run the container:

```
docker run -it --privileged --rm \
    --dns=8.8.8.8 \
    --env SERVER=nl868.nordvpn.com \
    --env PROTOCOL=udp \
    -p 1080:1080 \
    -p 3128:3128 \
    nordvpn-proxy
```

You can also specify just the 2 digits of the country code and a random server from that country will be selected:

```
docker run -it --privileged --rm --dns=8.8.8.8 --env SERVER=de -p 1080:1080 nordvpn-proxy
```

Test it!

```
curl -x socks5h://127.0.0.1:1080 http://whatismyip.akamai.com
curl -x http://127.0.0.1:3128 http://whatismyip.akamai.com
```

## References

 - [Server recommended by NordVPN](http://nordvpn.com/servers/tools/)
 - [Tutorials on how to set up proxy with NordVPN](https://support.nordvpn.com/Connectivity/Proxy/)
 - [How can I connect to NordVPN using Linux Terminal?](https://support.nordvpn.com/Connectivity/Linux/1047409422/How-can-I-connect-to-NordVPN-using-Linux-Terminal.htm)
 - [Official NordVPN client in a docker container](https://github.com/bubuntux/nordvpn)
