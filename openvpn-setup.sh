docker volume create openvpn-volume
docker run -v openvpn-volume:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://$CLOUDFLARE_A_RECORD_NAME
docker run -v openvpn-volume:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki