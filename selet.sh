#!/bin/bash
rm -f a_smile
if [[ $(id -g) != "0" ]] ; then
    echo ""
    echo "❯❯❯ สั่งรูทคำสั่ง [ sudo -i ] ก่อนรันสคริปนี้  "
    echo ""
    exit
fi
smile=$2

if [[  ! -e /dev/net/tun ]] ; then
    echo "❯❯❯ TUN/TAP device is not available."
fi
cd
if [[ -e /etc/debian_version ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi
if [[ -e /etc/yum ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi
IP=$(wget -qO- ipv4.icanhazip.com);

surin="https://raw.githubusercontent.com/surinvpn/surin-vpn/master"

# wget -q -O ovpn.tar "$smile/install/conf/openvpn.tar"

scrip="http://smile-vpn.net/scrip/scrip_350/install"
if [[ $smile == "" ]]
then
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ เลือกระบบที่จะติดตั้ง Scrip      "
echo "    ╰━━━┳━━━━━━━━━━━┳━━━╯"
echo "    ╭━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┃ ใส่ตัวเลขแล้วกด enter"
echo "    ┣━━━━━━━━━━━━━━━━━╯"
echo "    ┣ 1. OpenVPN Debian7-8-9 & Ubuntu14.4-16.4     "
echo "    ┣ 2. Pritunl Debian7-8-9 & Ubuntu14.4-16.4       "
echo "    ┣ 3. L2TP ได้ทุก OS     "
echo "    ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
read -p "    ╰━━ Namber : " opcao
else
opcao=$smile
fi
case $opcao in
 1 | 01 )
 if [[ "$smile" = "" ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ แน่ใจคุณต้องการรันระบบ OpenVPN    
        ┣━━━━━━━━━━━━━━━━━━━━━━━╯   "
    read -p "        ╰━━ ( Y/n ) : " Confirn
    if [[ "$Confirn" = "y" || "$Confirn" = "Y" ]]; then
    clear
    else
 bash selet.sh
exit 0
    fi
fi
 if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
  cd

wget -q -O install "$surin/open-smile.sh"
bash install
exit
fi
echo ""
echo " openvpn รันได้แค่ OS debian7-8-9 & ubuntu14.4-16.4 เท่านั้น  "
echo ""
exit;;
 2 | 02 )
 if [[ "$smile" = "" ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ แน่ใจคุณต้องการรันระบบ Pritunl    
        ┣━━━━━━━━━━━━━━━━━━━━━╯ "
    read -p "        ╰━━ ( Y/n ) : " Confirn
    if [[ "$Confirn" = "y" || "$Confirn" = "Y" ]]; then
    clear
    else
 bash selet.sh
exit 0
    fi
fi
 #centos7
 if [[ "$VERSION_ID" = 'VERSION_ID="7"' ]]; then
 if [[ -e /etc/debian_version ]]; then
 cd
wget -q -O install "$surin/debian/debian7/install"
bash install
exit
fi
   cd
wget -q -O install "$surin/debian/CentOS7/install"
bash install
exit

#debian8
elif [[ "$VERSION_ID" = 'VERSION_ID="8"' ]]; then
cd
wget -q -O install "$surin/debian/debian8/install"
bash install
exit

#debian9
elif [[ "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
cd
wget -q -O install "$surin/debian/debian9/install"
bash install
exit
# Ubuntu 14.04
elif [[ "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
cd
wget -q -O install "$surin/debian/ubuntu14.4/install"
bash install
exit

# Ubuntu 16.04-17.4
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' ]]; then
cd
wget -q -O install "$surin/debian/ubuntu16.4/install"
bash install
exit
fi
echo ""
echo " pritunl รันได้แค่ OS Centos7 & debian 7-8-9 & ubuntu14.4-16.4 เท่านั้น  "
echo ""
exit
;;
3 )
if [[ "$smile" = "" ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ แน่ใจคุณต้องการรันระบบ L2TP    
        ┣━━━━━━━━━━━━━━━━━━━━━╯    "
    read -p "        ╰━━ ( Y/n ) : " Confirn
    if [[ "$Confirn" = "y" || "$Confirn" = "Y" ]]; then
    clear
    else
wget -q -O selet.sh "$surin/selet.sh"
bash selet.sh
exit 0
    fi
fi

echo " กำลังแก้ไข" 
# wget -q -O smile http://smile-vpn.net/scrip/scrip_350/install/L2TP/l2tp.sh
# bash smile
exit 0
;;
$opcao )
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━╮ 
        ┣ โปรดพิมพ์คำสั่งให้ถูกต้อง
        ╰━━━━━━━━━━━━━━━━━━━╯
 "
exit 0
;;
 esac
 


