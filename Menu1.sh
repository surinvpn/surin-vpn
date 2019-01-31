#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo ""
	echo "กรุณาเข้าสู่ระบบผู้ใช้ root ก่อนทำการใช้งานสคริปท์"
	echo "คำสั่งเข้าสู่ระบบผู้ใช้ root คือ sudo su"
	echo ""
	exit
fi

# ===== แม่แบบสี =====
NC='\033[0m'
# =================

# ===== Manu =====
echo ""
echo " ========================="
echo "===== Manu : ยินดีตอนรับ====="
echo " ========================="
echo ""
	echo "============================="
     echo "===== Manu : ฟังชั่นงานใช้งาน ====="
     echo "============================="
echo ""
	echo -e "1 : เพิ่มบัญชีผู้ใช้งาน"
	echo -e "2 : ลบบัญชีผู้ใช้งาน"
	echo -e "3 : ตรวจสอบบัญชีผู้ใช้งานทั้งหมด"
	echo -e "4 : แก้ไขรหัสผ่านผู้ใช้งาน"
	echo -e "5 : แก้ไขวันหมดอายุ"
	echo -e "6 : ทดสอบความเร็วอินเตอร์เน็ต"
echo ""
	echo -e "0 : อัพเดตสคริปท์"
echo ""

read -p "เลือกลำดับการใช้งาน : " Mu
# =================

case $Mu in

	1)

      if [[ $CHECKSYSTEM ]]; then
	echo ""
	     read -p "ชื่อผู้ใช้งาน : " -e CLIENT
	if [ $? -eq 0 ]; then
		read -p "รหัสผ่าน : " -e PASSWORD
		echo ""
		read -p "วันใช้งาน : " -e TimeActive

PROXY=$(grep '^http_port ' /etc/squid/squid.conf | cut -d " " -f 2)
PROXY=$(grep '^http_port ' /etc/squid3/squid.conf | cut -d " " -f 2)
useradd -e `date -d "$TimeActive days" +"%Y-%m-%d"` -s /bin/false -M $CLIENT
EXP="$(chage -l $CLIENT | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$PASSWORD\n$PASSWORD\n"|passwd $CLIENT &> /dev/null

		clear
          echo ""
          echo "========================"
          echo "===== ข้อมูลการใช้งาน ====="
          echo "ไอพีโฮส : $IP"
          echo "ชื่อผู้ใช้งาน : $CLIENT"
		echo "รหัสผ่าน : $PASSWORD"
		echo "วันหมดอายุ : $EXP"
		echo "พอต : 1194"
		echo "พร็อกซี : $PROXY"
          echo "========================"
		exit
	else
		echo ""
		echo "ชื่อบัญชีที่ระบุอยู่ในระบบแล้ว"
		echo ""
		read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU
		if [[ "$TOMENU" = 'Y' ]]; then
			Mu
			exit
		elif [[ "$TOMENU" = 'N' ]]; then
			exit
		fi
	fi

	;;

esac