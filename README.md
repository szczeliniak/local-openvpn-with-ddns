Several scripts to run OpenVPN Server on some machine (in local home network) and expose it to the world to allow for connection from different devices and proxy traffic through home network. To make keep costs low and let it be easy as can be, it runs OpenVPN Server in a docker container, and updates changes of home IP address via cron in Cloudflare (as they propagate changes in DNS immediately). If you have some linux-based machine running all the time - it is even simpler, but if not you need some kind of mini pc with any Linux distribution and low energy consumption.

Requirements:
- Cloudflare account
- Domain management moved to Cloudflare DNS
- Port forwarding enabled for 1194 UDP on your router and binded to UCP 1194 of our machine.
- Any machine with Linux/MacOS with docker, docker-compose, crontab. It should work all the time so should be low-powered (Raspberry Pi or sth).

Environment variables to be set in `.env` file before script execution:
`CLOUDFLARE_A_RECORD_NAME` - it can be your domain or subdomain as well.
`CLOUDFLARE_EMAIL` - email you use to login to Cloudflare.
`CLOUDFLARE_TOKEN` - scoped token with permission to edit DNS.
`CLOUDFLARE_ZONE_ID` - zone id for domain. Can be found in overview for domain in Cloudflare admin panel.

## OpenVPN Server

1. Run setup script with command`./openvpn-setup.sh`.
2. Run OpenVPN Server with command `./openvpn-start.sh`
3. If you wath to stop it, use command `./openvpn-stop.sh`

To generate OpenVPN user use command `./openvpn-new-user.sh <USERNAME>`, where <USERNAME> needs to be replaced by some real username.

To fetch .ovpn file for specific user use command `./openvpn-fetch-ovpn.sh <USERNAME>`, where <USERNAME> needs to be replaced by some existing username. It will be save in file `<USERNAME>.sh`.

## Cloudflare
To update address in Cloudflare DNS use `./cloudflare-update.sh`. It runs script that updates appropriate record in Cloudflare (source project: https://github.com/K0p1-Git/cloudflare-ddns-updater)

Use crontab to execute script in regular interval.
1. Open cron editor: `crontab -e`.
2. Add line `*/1 * * * * /bin/bash <ABSOULTE_PATH_TO_SCRIPT>`, where <ABSOULTE_PATH_TO_SCRIPT> has to point directly to `cloudflare-update.sh`. You can find it by executing `echo $(pwd)/cloudflare-update.sh` in root directory of this repository.