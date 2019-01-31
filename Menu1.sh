#!/bin/bash

clear
GROUPNAME=nogroup
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
CHECKSYSTEM=$(tail -n +2 /etc/openvpn/server.conf | grep "^username-as-common-name")

IP=$(wget -4qO- "http://whatismyip.akamai.com/")

# ===== แม่แบบสี =====
สีเทา='\033[1;33m'
สีเขียว='\033[0;32m'
NC='\033[0m'
# =================

# ===== Manu =====
echo ""
echo " ========================="
echo "===== Manu : ยินดีตอนรับ====="
echo " ========================="
echo ""
	echo -e "ฟังชั่นการใช้งาน${NC}"
	echo ""
	echo -e "1${NC} : เพิ่มบัญชีผู้ใช้ OpenVPN"
	echo -e "2${NC} : เพิ่มบัญชีผู้ใช้ SSH (HTTP)"
	echo -e "3${NC} : ลบบัญชีผู้ใช้"
	echo -e "4${NC} : ตรวจสอบบัญชีผู้ใช้ทั้งหมด"
	echo -e "5${NC} : เปลี่ยนรหัสผ่านบัญชีผู้ใช้"
	echo -e "6${NC} : เปลี่ยนวันหมดอายุบัญชีผู้ใช้"
	echo -e "7${NC} : ทดสอบความเร็วอินเตอร์เน็ต"
	echo -e "8${NC} : ตรวจสอบแบนด์วิดท์"
	echo -e "9${NC} : ตรวจสอบแบนด์วิดท์แบบรายชั่วโมง"
	echo -e "10${NC} : ตรวจสอบแบนด์วิดท์ต่อบัญชี"
	echo -e "11${NC} : ปรับเปลี่ยนระบบของเซิฟเวอร์"
	echo ""
	echo -e "UP${NC} : อัพเดตสคริปท์"
echo ""

read -p "เลือกหัวข้อเมนูที่ต้องการใช้งาน : " Mu
# =================

case $Mu in

	1)
          echo ""
		echo "กำลังแก้ไข"
		echo ""
		read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU
		if [[ "$TOMENU" = 'Y' ]]; then
			Mu
			exit
		elif [[ "$TOMENU" = 'N' ]]; then
               Mu
			exit
		fi
	;;

esac