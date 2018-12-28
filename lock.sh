#!/bin/bash
rm -f install.sh
cd
smile=$1
smile1=$2

wget -q -O install.sh https://raw.githubusercontent.com/surinvpn/surin-vpn/master/passwd.php
bash install.sh $smile $smile1
exit 0

