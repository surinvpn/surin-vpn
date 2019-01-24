#!/bin/bash
#!/bin/bash
#Menu
clear
if [[ $1 == "" ]]
then
echo -e " "
echo -e "=====[[ สคริปต์ลองรับเฉพาะ Debian7-8 ]]====="
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e "=====[[ พิมพ์คำสั่ง { menu } เปิดให้งานสคริปต์ ]]====="
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e " "
echo -e "\033[1;31m  01  เพิ่มผู้ใช้งาน"
echo -e "\033[1;33m 02 ทดลองบัญชี1วัน"
echo -e "\033[1;34m 03 แก้ไขชื่อผู้ใช้และรหัสผ่าน "
echo -e "\033[1;35m 04 แก้ไขวันใช้งาน "  
echo -e "\033[1;36m 05 ลบผู้ใช้บัญชี"
echo -e "\033[1;32m 06 ลบบัญชีหมดอายุอัตโนมัติ "
echo -e "\033[1;33m 07 ผู้ใช้ทั้งหมดและผู้ใช้งานออนไลน์"
echo -e "\033[1;34m 08 รีสตาร์ตทั้งหมด"
echo -e "\033[1;35m 09 เทสความเร็ว  VPS "
echo -e "\033[1;36m 10 ตรวจสอบแบนวิสการใช้งานวันนี้ "
echo -e "\033[1;31m 11 รายละเอียดการใช้งาน "
echo -e "\033[1;33m 12 ตรวจสอบระบบ "
echo -e "\033[1;34m 13 แบนผู้ใช้งาน "
echo -e "\033[1;35m 14 ปลดแบนผู้ใช้งาน "
echo -e "\033[1;34m 15 ตั้งค่าเวลารีบูตอัตโนมัติ "
echo -e "\033[1;34m 16 สำรองข้อมูลผู้ใช้งาน "
echo -e "\033[1;34m 17 เปลียนรหัสผ่านเซิฟร์เวอร์  "
echo -e "\033[1;34m 18 อัพเดทสคริปต์  "
echo -e "\033[1;32m"
echo -e "=====[[ กรุณาเลือกหมายเลขที่คุณที่จะใช้ฟังชั่นเมนู ]]====="
read -p " เลือก : " opcao
else
opcao=$1
fi
case $opcao in
  1 | 01 )
 #!/bin/bash
echo "================[[เมนูที่ 1 ]]================"
echo "================[[เพิ่มผู้ใช้งาน ]]================"
echo ""
read -p "ชื่อผู้ใช้ : " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
echo ""
	echo -e "\033[1;31m ======ชื่อผู้ใช้มีอยู่แล้ว======"
	echo -e "\033[1;32m"
	exit 1
else
	read -p "รหัสผ่าน : " password
	read -p "วันหมดอายุ : " AKTIF

	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $username
	echo $username:$password | chpasswd
	IP=`dig +short myip.opendns.com @resolver1.opendns.com`
clear
echo "============[[ข้อมูลการใช้งาน]]==========="
echo "     Host: $IP"
echo "     ชื่อผู้ใช้: $username"
echo "     รหัสผ่าน: $password                   "
echo "     พอตใช้งาน HTTP injector : 22,443         "
echo "     พอตใช้งาน OpenVPN : 443,1194        "
echo "     พร็อกซี   : 80,8080,3128      "
echo "-------------------------------------------"
echo "     ใช้ได้ถึ่งวันที่ : $(date -d "$AKTIF days" +"%d-%m-%Y")"
echo ""
echo "========ดาวโหลดไฟล์========"
echo "     "
echo "     http://$IP/TRUEID.ovpn"
echo "     ******************************"
fi

exit
;;
  2 | 02 )
  Login=test`</dev/urandom tr -dc X-Z0-9 | head -c4`
Day="1"
Passwd=4468`</dev/urandom | head -c9`

useradd -e `date -d "$Day days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Passwd\n$Passwd\n"|passwd $Login &> /dev/null
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
echo "================[[เมนูที่ 2 ]]================"
echo "==[[ชื่อผู้ใช้งานจะกำนนการใช้งานถึงเวลาเที่ยงคืน]]=="
echo -e ""
echo "     Host: $IP"
echo "     ชื่อผู้ใช้: $username"
echo "     รหัสผ่าน: $password                   "
echo "     พอตใช้งาน HTTP injector : 22,443         "
echo "     พอตใช้งาน OpenVPN : 443,1194        "
echo "     พร็อกซี   : 80,8080,3128      "
echo -e "******************************"
exit
;;
  3 | 03 )
  #!/bin/bash
if [[ $1 == "" ]]
then
echo " "
echo "================[[เมนูที่ 3 ]]================"
echo "============[[แก้ไขชื่อผู้ใช้และรหัสผ่าน]]==========="
   {1} แก้ไขชื่อผู้ใช้
   {2} แก้ไขรหัสผ่าน "
   echo -e "\033[01;35m"
read -p " เลือก : " opcao
else
opcao=$1
fi
case $opcao in
 1 | 01 )
 echo " "
 printf " ชื่อผู้ใช้งานใหม่ : "; read user
if getent passwd $user > /dev/null 2>&1;
then
printf ""
else
echo " "
echo -e "\033[01;31m === ไม่พบชื่อผู้ใช้งาน ===  "
echo -e "\033[01;36m "
exit
fi
 clear
 echo " "
 echo "============[[เปลียนชื่อผู้ใช้ใหม่]]==========="
 echo -e "\033[01;35m"
printf " เปลียนชื่อผู้ใช้งานจาก $user เป็น : "; read nome
usermod -l $nome $user 1>/dev/null 2>/dev/null
echo -e "  "
echo " =================================
  ชื่อผู้ใช้งานใหม่ ของ [ $user ] คือ [ $nome ]  เรียบร้อย
 ================================="
echo -e "\033[01;36m"
exit
;;
2 | 02 )
 echo " "
 printf " ผู้ใช้งานใหม่ : "; read user
if getent passwd $user > /dev/null 2>&1;
then
printf ""
else
echo " "
echo -e "\033[01;31m === ไม่พบชื่อผู้ใช้ ===  "
echo -e "\033[01;36m "
exit
fi
clear
  echo " "
  echo "============[[เปลียนรหัสผ่านใหม่]]==========="
  echo -e "\033[01;35m"
read -p " รหัสผ่านใหม่ : " passwd
echo -e "$passwd\n$passwd\n"|passwd $user &> /dev/null
echo "============[[รหัสผ่านใหม่ของ [ $user ] เปลียนเป็น [ $passwd ] เรียบร้อย]]==========="
echo -e "\033[01;36m"
exit
;;
esac
echo ""
  echo -e "\033[01;31m ผิดพลาดในการแก้ไข "
  echo -e "\033[01;33m"

exit
;;
 4 | 04 )
clear
  echo "================[[เมนูที่ 4 ]]================"
  echo "============[[เมนูที่ 4 แก้ไขวันใช้งาน]]==========="
read -p " ชื่อผู้ใช้งาน : " namer
read -p " วันใช้งาน : " date
chage -E $date $namer 2> /dev/null
echo -e "\033[1;36mชื่อผู้ใช้งาน $namer วันใช้งาน: $date\033[0m"
echo -e "\033[1;32m "
exit
;;
5 | 05 )
#!/bin/bash
echo "================[[เมนูที่ 5 ]]================"
echo "===============[[ลบผู้ใช้งาน]]==============="
read -p "SSH user name will be removed : " User

if getent passwd $User > /dev/null 2>&1; then
        userdel $User
        echo -e "User $User Was deleted."
else
        echo -e "Name $User Not Found."
fi

exit
;;
6 | 06 )
#!/bin/bash
echo "================[[เมนูที่ 6 ]]================"
echo "==========[[ลบบัญชีหมดอายุอัตโนมัติ ]]=========="
echo -e "         \033[1;33mกำนนวันชื่อผู้ใช้ที่จะหมด\033[0m"
datahoje=$(date +%s)
for user in $(cat /etc/passwd |grep -v "ไม่พบบัญชีที่หมดอายุ" |awk -F : '$3 > 900 {print $1}')
do
dataexp=$(chage -l $user |grep "บัญชีหมดอายุวันที่" |awk -F : '{print $2}')
if [[ $dataexp == ' never' ]]; then
id > /dev/null 2>/dev/null
else
dataexpn=$(date -d"$dataexp" '+%d/%m/%Y')
dataexpnum=$(date '+%s' -d"$dataexp")
fi
if [[ $dataexpnum < $datahoje ]]; then
printf "\033[1;33m"
printf '%-41s' $user
printf "\033[0m"
printf "\033[1;31m"
echo "ลบวันใช้งานหมดอายุแล้ว"
kill $(ps -u $user |awk '{print $1}') >/dev/null 2>/dev/null ; userdel $user
else
printf "\033[1;36m"
printf '%-41s' $user
printf "\033[0m"
printf "\033[1;32m"
echo $dataexpn
fi
done
echo -e "\033[1;32m"
exit
;;
7 | 07 )
#!/bin/bash
echo "================[[เมนูที่ 7 ]]================"
echo "==========[[ผู้ใช้ทั้งหมดและผู้ใช้งานออนไลน์ ]]=========="
echo -e "\033[1;36m" 
echo "---------------------------------------------"
echo "อันดับ    ชื่อผู้ใช้งาน    สถานะ    วันใช้งาน  "
echo "---------------------------------------------"
C=1
ON=0
OFF=0
while read mumetndase
do
        acout="$(echo $mumetndase | cut -d: -f1)"
        ID="$(echo $mumetndase | grep -v nobody | cut -d: -f3)"
        exp="$(chage -l $acout | grep "หมดอายุ" | awk -F": " '{print $2}')"
        online="$(cat /etc/openvpn/log.log | grep -Eom 1 $acout | grep -Eom 1 $acout)"
        if [[ $ID -ge 500 ]]; then
        if [[ -z $online ]]; then
        printf "%-4s %-15s %-10s %-3s\n" "$C." "$acout" "------" "$exp"
        OFF=$((OFF+1))
        else
        printf "%-4s %-15s %-10s %-3s\n" "$C." "$acout" "online" "$exp"
        ON=$((ON+1))
        fi
        C=$((C+1))
        fi
done < /etc/passwd
echo "---------------------------------------------"
echo " ออนไลน์ : $ON     ออฟไลน์ : $OFF "
echo "---------------------------------------------"
echo -e "\033[1;32m" 
exit
;;
8 | 08 )
#!/bin/bash
echo "================[[เมนูที่ 8 ]]================"
echo "==========[[รีสตาร์ตระบบทั้งหมด ]]=========="
echo -e ""
service dropbear restart
service squid3 restart
service openvpn restart
service ssh restart
exit
;;
09 | 9 )
echo "================[[เมนูที่ 9 ]]================"
echo "==========[[ทดสอบความเร็วอินเตอร์เน็ต Linux ]]=========="
echo -e ""
speedtest

exit
;;
10 )
echo "================[[เมนูที่ 10 ]]================"
echo "==========[[ตรวจสอบแบนวิสงานใช้งานวันนี้  ]]=========="
echo -e ""
	echo -e "การใช้ข้อมูลโดยรวม:"
echo -e "\033[1;31m" 
	myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`
	myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`
	ifconfig $myint | grep "RX bytes" | sed -e 's/ *RX [a-z:0-9]*/Download : /g' | sed -e 's/TX [a-z:0-9]*/\nUpload   : /g'
	echo -e "\033[0m" 
	echo -e "\033[1;32m"
exit
;;
	11 )
echo "================[[เมนูที่ 11 ]]================"
echo "==========[[ตรวจสอบระบบ]]=========="
echo -e ""
	cat /etc/openvpn/log.log
exit
;;
	12 )
	clear
echo "================[[เมนูที่ 12 ]]================"
echo "==========[[ตรวจสอบระบบ]]=========="
echo -e ""
neofetch
exit
;;
13 )
echo "================[[เมนูที่ 13 ]]================"
echo "==========[[แบนผู้ใช้งาน]]=========="
echo -e ""
read -p "ชื่อผู้ใช้งาน : " Login
usermod -L $Login
echo -e ""
echo -e "====รายละเอียดบัญชี===="
echo -e "แบนชื่อผู้ใช้งาน: $Login :แบนผู้ใช้งานเรียบร้อย"
exit
;;
14 )
#!/bin/bash
echo "================[[เมนูที่ 14 ]]================"
echo "==========[[ปลดแบนผู้ใช้งาน]]=========="
echo -e ""
read -p "ชื่อผู้ใช้งาน : " Login
usermod -U $Login
echo -e ""
echo -e "====รายละเอียดบัญชี===="
echo -e "ชื่อผู้ใช้งาน: $Login :ปลดแบนผู้ใช้งานเรียบร้อย"

exit
;;
15 )
if [[ $1 == "" ]]
then
echo -e "\033[1;33m "
   echo "================[[เมนูที่ 15 ]]================"
   echo "==========[[ตั้งค่าเวลารีบูตอัตโนมัติ]]=========="
   echo -e ""
   echo -e "\033[1;32m
   {1} กำหนดเวลารีบูต
   {2} ปิดใช้งานการรีบูต"
   echo " "
read -p " เลือก : " opcao
else
opcao=$1
fi
case $opcao in
  01 | 1 )
  echo " "
  echo "===[ กรุณากำนนเวลานาที ที่จะรีบูต ]==="
read -p " เวลา ( 0,1,23 ) : " Hour
read -p " นาที ( 0,1,59 ) : " Minute
echo "$Minute $Hour * * * root /sbin/reboot" > /etc/cron.d/reboot
service cron restart
echo -e "\033[1;36m "
exit
;;
 02 | 2 )
  echo " "
  echo "===[ ปิดการใช้งานรีบูตเรียบร้อย ]==="
echo " " > /etc/cron.d/reboot
service cron restart
echo -e "\033[1;36m "
exit
;;
esac
echo ""
  echo -e "\033[01;31m ไม่มีตัวเลือกที่คุณพิมพ์ "
  echo -e "\033[01;33m"

exit
;;
16 )
clear
if [[ $1 == "" ]]
then
  echo "================[[เมนูที่ 16 ]]================"
  echo " "
  echo "=====[[สำรองข้อมูลผู้ใช้]]====="
   {1} การสำรองข้อมูลผู้ใช้งาน
   {2} คืนค่าผู้ชื่อใช้งาน"
   echo -e "\033[01;31m"
read -p "เลือก : " opcao
else
opcao=$1
fi
case $opcao in
  1 | 01 )
tar cf /home/vps/public_html/user.tar /etc/passwd /etc/shadow /etc/gshadow /etc/group
exit
;;
 2 | 02 )
 cd /
 read -p "ป้อนไอพีเพื่อเรียกคืนค่า: " IP
wget -q -O user.tar "http://$IP:80/user.tar"
tar xf user.tar
rm user.tar
exit
;;
esac
echo ""
  echo -e "\033[01;31m ไม่มีตัวเลือกที่คุณพิมพ์ "
  echo -e "\033[01;33m"

exit
;;
17 )
clear
  echo " "
  echo "================[[เมนูที่ 17 ]]================"
  echo " "
  echo "=====[[แก้ไขรหัสผ่าน Server]]====="
echo -e "\033[01;35m"
echo " ======================================"
echo "    กำหนดรหัสผ่านสำหรับล็อกอินด้วยชื่อ root  "
echo " ====================================="
echo -e "\033[01;33m"
passwd
cat > /etc/ssh/sshd_config <<-END
Port 22
Port 143
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
UsePrivilegeSeparation yes
KeyRegenerationInterval 3600
ServerKeyBits 768
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
ClientAliveInterval 120
ClientAliveCountMax 2
END
service ssh restart
exit
;;
18 )
  echo ""
  echo -e "\033[01;31m กำลังทำระบบใหม่ "
  echo -e "\033[01;33m"
exit;;
  esac
  echo ""
  echo -e "\033[01;31m ไม่มีตัวเลือกที่คุณพิมพ์ "
  echo -e "\033[01;33m"
