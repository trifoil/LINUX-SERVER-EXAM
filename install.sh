#!/bin/bash

clear

RED='\033[0;31m' #Red
BLUE='\e[38;5;33m' #Red
NC='\033[0m' # No Color

updatedb
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload
dnf -y install nfs-utils samba bind chrony fail2ban vsftpd rsync clamav clamd clamav-update bind-utils httpd php php-mysqlnd mariadb-server phpmyadmin  

chmod +x -R scripts

clear

# Function to display the menu
display_menu() {
    echo ""
    echo "|----------------------------------------------------------------------|"
    echo -e "|                 ${BLUE}Welcome to the server assistant ${NC}                     |"
    echo "|              Please select the tool you want to use                  |"
    echo "|----------------------------------------------------------------------|"
    echo "| 0. Set server hostname                                               |"
    echo "| 1. RAID Configuration                                                |"
    echo "| 2. SSH Connection                                                    |"
    echo "| 3. NFS/SAMBA Shared Directory (no auth)                              |"
    echo "| 4. Users Management Menu                                             |"
    echo "| 5. NTP Time Server                                                   |"
    echo "| 6. Security Settings                                                 |"
    echo "| 7. Backup                                                            |"
    echo "| 8. Consult Logs Dashboard                                            |"
    echo "|----------------------------------------------------------------------|"
    echo "| q. Quit                                                              |"
    echo "|----------------------------------------------------------------------|"
    echo ""
}

set_hostname(){
    sh scripts/0_hostname.sh
}

raid(){
    sh scripts/1_raid.sh
}

ssh(){
    sh scripts/2_ssh.sh
}

unauthshare(){
    sh scripts/3_unauth_share.sh
}

usersmanagement(){
    sh scripts/4_user_management.sh
}

ntp(){
    sh scripts/5_ntp_server.sh
}

security(){
    sh scripts/6_security.sh
}

backup(){
    sh scripts/7_backup.sh
}

logs(){
    sh scripts/8_logs.sh
}

# Main function
main() {
    while true; do
        display_menu
        read -p "Enter your choice: " choice
        case $choice in
            0) set_hostname ;;
            1) raid ;;
            2) ssh ;;
            3) unauthshare ;;
            4) usersmanagement ;;
            5) ntp ;;
            6) security ;;
            7) backup ;;
            8) logs ;;
            q|Q) clear && echo "Exiting the web server configuration wizard." && exit ;;
            *) clear && echo "Invalid choice. Please enter a valid option." ;;
        esac
    done
}

main