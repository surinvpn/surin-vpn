#!/usr/bin/env bash
rm -f install
clear
cr
echo

# Functions
ok() {
    echo -e '\e[32m'$1'\e[m';
}

die() {
    echo -e '\e[1;35m'$1'\e[m';
}
red() {
    echo -e '\e[1;31m'$1'\e[m';
}

des() {
    echo -e '\e[1;31m'$1'\e[m'; exit 1;
}


#
#<BODY text='ffffff'>

smile="http://smile-vpn.net/scrip/scrip_350"

surin="https://raw.githubusercontent.com/surinvpn/surin-vpn/master"

# wget -q -O ovpn.tar "$smile/install/conf/openvpn.tar"

#OS
if [[ -e /etc/debian_version ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi

if [[ -d /etc/openvpn ]]; then
clear
cr
echo
    die " ❯❯❯ ได้ติดตั้ง openvpn ใว้แล้วก่อนหน้านี้  ."
    die " ❯❯❯  ต้องการติดตั้งทับหรือไม่ ฟังชั่นบางบางอาจไม่ทำงาน "
    read -p " ❯❯❯  y/n : " enter
 if [[ $enter = y || $enter = Y ]]; then
 clear
cr
echo
else
clear
cr
echo
 exit
fi
else
clear
cr
echo
fi

# Install openvpn
die "❯❯❯ apt-get update"
apt-get update -q > /dev/null 2>&1
die "❯❯❯ apt-get install openvpn curl openssl"
apt-get install -qy openvpn curl > /dev/null 2>&1

# IP Address
SERVER_IP=$(wget -qO- ipv4.smile-vpn.net);
if [[ "$SERVER_IP" = "" ]]; then
    SERVER_IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`;
fi

die "❯❯❯ Generating CA Config"
cd /
wget -q -O ovpn.tar "$smile/install/conf/openvpn.tar"
tar xf ovpn.tar
rm ovpn.tar

cat > /etc/openvpn/1194.ovpn <<EOF1
auth-user-pass
client
dev tun
proto tcp
port 1194
connect-retry 1
connect-timeout 120

resolv-retry infinite
route-method exe

nobind
ping 5
ping-restart 30
persist-key
persist-tun
persist-remote-ip
mute-replay-warnings

verb 2

cipher none
comp-lzo
script-security 3
remote $SERVER_IP
http-proxy $SERVER_IP 8080

<key>
$(cat /etc/openvpn/client-key.pem)
</key>
<cert>
$(cat /etc/openvpn/client-cert.pem)
</cert>
<ca>
$(cat /etc/openvpn/ca.pem)
</ca>
EOF1

cat > /etc/openvpn/dtac.ovpn << SMILE
client
dev tun
proto tcp
port 1194
connect-retry 1
connect-timeout 120

resolv-retry infinite
route-method exe

nobind
ping 5
ping-restart 30
persist-key
persist-tun
persist-remote-ip
mute-replay-warnings

verb 3

cipher none
comp-lzo
script-security 3
remote $SERVER_IP
http-proxy $SERVER_IP 8080
SMILE
cp /etc/openvpn/dtac.ovpn /etc/openvpn/true.ovpn 

# Restart Service
ok "❯❯❯ service openvpn restart"
service openvpn restart > /dev/null 2>&1

if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
#install squid3
die "❯❯❯ apt-get install squid3"
apt-get install -qy squid3 > /dev/null 2>&1
cp /etc/squid3/squid.conf /etc/squid3/squid.conf.orig
echo "http_port 8080
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst $SERVER_IP-$SERVER_IP/255.255.255.255                 
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320" > /etc/squid3/squid.conf
ok "❯❯❯ service squid3 restart"
service squid3 restart -q > /dev/null 2>&1

elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
#install squid3
die "❯❯❯ apt-get install squid"
apt-get install -qy squid > /dev/null 2>&1
cp /etc/squid/squid.conf /etc/squid/squid.conf.orig
cat > /etc/squid/squid.conf <<END
http_port 8080
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst $SERVER_IP-$SERVER_IP/255.255.255.255
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
ok "❯❯❯ service squid restart"
service squid restart -q > /dev/null 2>&1
fi

echo news:Smile-1194 | chpasswd

#install Nginx
die "❯❯❯ apt-get install nginx"
apt-get install -qy nginx > /dev/null 2>&1
rm -f /etc/nginx/sites-enabled/default
rm -f /etc/nginx/sites-available/default
wget -q -O /etc/nginx/nginx.conf "$smile/install/conf/nginx.conf"
wget -q -O /etc/nginx/conf.d/vps.conf "$smile/install/conf/vps.conf"
mkdir -p /home/vps/public_html/open-on
wget -q -O /home/vps/public_html/open-on/index.php "$smile/install/conf/api.txt"
wget -q -O /home/vps/public_html/index.html "$smile/install/conf/smile-vpn.txt"
echo "<?php phpinfo( ); ?>" > /home/vps/public_html/info.php
ok "❯❯❯ service nginx restart"
service nginx restart > /dev/null 2>&1

#install php-fpm
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
#debian8
die "❯❯❯ apt-get install php"
apt-get install -qy php5-fpm > /dev/null 2>&1
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
apt-get install -qy php5-curl > /dev/null 2>&1
ok "❯❯❯ service php restart"
service php5-fpm restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' ]]; then
#debian9 Ubuntu16.4
die "❯❯❯ apt-get install php"
apt-get install -qy php7.0-fpm > /dev/null 2>&1
sed -i 's/listen = \/run\/php\/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf
apt-get install -qy php7.0-curl > /dev/null 2>&1
ok "❯❯❯ service php restart"
service php7.0-fpm restart > /dev/null 2>&1
fi


# install dropbear
die "❯❯❯ apt-get install dropbear"
apt-get install -qy dropbear > /dev/null 2>&1
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=3128/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 143"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
ok "❯❯❯ service dropbear restart"
service dropbear restart > /dev/null 2>&1

#detail nama perusahaan
country=ID
state=Thailand
locality=Tebet
organization=surin-vpn
organizationalunit=IT
commonname=surin-vpn.tk
email=bazproz.tk@gmail.com


# install stunnel
die "❯❯❯ apt-get install ssl"
apt-get install -qy stunnel4 > /dev/null 2>&1
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1


[dropbear]
accept = 444
connect = 127.0.0.1:3128

END

#membuat sertifikat
cat /etc/openvpn/client-key.pem /etc/openvpn/client-cert.pem > /etc/stunnel/stunnel.pem

#konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
ok "❯❯❯ service ssl restart"
service stunnel4 restart > /dev/null 2>&1

# install vnstat gui
die "❯❯❯ apt-get install vnstat"
apt-get install -qy vnstat > /dev/null 2>&1
chown -R vnstat:vnstat /var/lib/vnstat
cd /home/vps/public_html
wget -q http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 bandwidth
cd bandwidth
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php

if [ -e '/var/lib/vnstat/eth0' ]; then
	vnstat -u -i eth0
else
sed -i "s/eth0/ens3/g" /home/vps/public_html/bandwidth/config.php
vnstat -u -i ens3
fi

ok "❯❯❯ service vnstat restart"
service vnstat restart -q > /dev/null 2>&1

# Iptables
die "❯❯❯ apt-get install iptables"
apt-get install -qy iptables > /dev/null 2>&1
if [ -e '/var/lib/vnstat/eth0' ]; then
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
else
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o ens3 -j MASQUERADE
fi
iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
 iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source $SERVER_IP

iptables-save > /etc/iptables.conf

cat > /etc/network/if-up.d/iptables <<EOF
#!/bin/sh
iptables-restore < /etc/iptables.conf
EOF

chmod +x /etc/network/if-up.d/iptables

# Enable net.ipv4.ip_forward
sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|' /etc/sysctl.conf
echo 1 > /proc/sys/net/ipv4/ip_forward

# setting time
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart


ok "❯❯❯ ติดตั้งตำสั่งเมนูต่างๆ " 
# download script

# wget -q -O ovpn.tar "$smile/install/conf/openvpn.tar"

cd /usr/bin
wget -q -O .surin-vpn "$surin/menu.sh"
wget -q -O chek "$surin/lock.sh"
wget -q -O m "$surin/menu.sh"
wget -q -O speedtest "$smile/speedtest.py"
wget -q -O b-user "$smile/b-user.sh"



echo "30 3 * * * root /sbin/reboot" > /etc/cron.d/reboot
chmod +x .surin-vpn
chmod +x speedtest
chmod +x b-user
chmod +x chek
chmod +x m

service cron restart -q > /dev/null 2>&1

#install webmin
ok "❯❯❯ ต้องการติดตั้ง webmin หรือไม่ y/n " 
read -p " : " selet
if [[ "$selet" = "y" ]]; then
die "❯❯❯ apt-get install webmin"
cd
wget -q -O webmin-current.deb "http://www.webmin.com/download/deb/webmin-current.deb"
dpkg -i --force-all webmin-current.deb;
apt-get -y -f install;
rm /root/webmin-current.deb
ok "❯❯❯ service webmin restart"
service webmin restart -q > /dev/null 2>&1
webmin=http://$SERVER_IP:10000
elif [[ "$selet" = "n" ]]; then
cat > /usr/bin/webmin <<EOF2
rm /usr/bin/webmin
cd
echo "❯❯❯ download webmin "
wget -q -O webmin-current.deb "http://www.webmin.com/download/deb/webmin-current.deb"
dpkg -i --force-all webmin-current.deb;
apt-get -y -f install;
rm /root/webmin-current.deb
echo "❯❯❯ service webmin restart"
service webmin restart -q > /dev/null 2>&1
echo " 
Link-webmin : http://$SERVER_IP:10000
 "
EOF2
chmod +x /usr/bin/webmin
webmin=" ยังไม่ได้ติดตั้ง สั่ง ( webmin ) เพื่อติดตั้งภายหลัง   "
fi

die "❯❯❯ apt-get update"
apt-get update -q > /dev/null 2>&1
service openvpn restart -q > /dev/null 2>&1

echo "ติดตั้งสำเร็จ" > /usr/bin/350_fulle
mv /etc/openvpn/1194.ovpn /home/vps/public_html/1194.ovpn

if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
ok ""
ok " Link Web"
ok ""
ok " ❯❯❯ UserOn  :  http://$SERVER_IP/open-on "
ok ""
ok " ❯❯❯ webmin  :  $webmin "
ok ""
ok " ❯❯❯ vnstat    :   http://$SERVER_IP/bandwidth/"
ok ""
ok " ❯❯❯ user-pass  :  http://$SERVER_IP/1194.ovpn"
ok ""

elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
ok ""
ok " Link Web"
ok ""
ok " ❯❯❯ vnstat    :   http://$SERVER_IP/bandwidth/"
ok ""
ok " ❯❯❯ webmin  :  $webmin "
ok ""
ok " ❯❯❯ user-pass  :  http://$SERVER_IP/1194.ovpn"
ok ""
fi
