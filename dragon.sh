#!/bin/bash
#set -x

export PATH=$PATH:/usr/sbin

createssh(){
    username=$1
    password=$2
    dias=$3
    sshlimiter=$4
    removessh $username
    php /opt/DragonCore/menu.php deleteData $username
    dias=$(($dias+1))
    final=$(date "+%Y-%m-%d" -d "+$dias days")
    gui=$(date "+%d/%m/%Y" -d "+$dias days")
    pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
    useradd -e $final -M -s /bin/false -p $pass $username
    php /opt/DragonCore/menu.php insertData $username $password $sshlimiter
    PIDS=$(ps aux | grep "sleep" | grep "$username" | grep -v "$current_pid" | awk '{print $2}')
    if [ -n "$PIDS" ]; then
        #kill -9 $PID22
        echo "Killed sleep process with PID: $PIDS"
        rm /etc/DragonPanel/*_${username}.sh
    else
        echo "No sleep process found for 'teste'."
    fi
    
    echo "CRIADOCOMSUCESSO"
}

createsshteste(){
    folder_path="/etc/DragonPanel"
    pass=$(perl -e 'print crypt($ARGV[0], "password")' $2)
    final=$(date "+%Y-%m-%d" -d "+2 days")
    useradd -e $final -M -s /bin/false -p $pass $1
    username="$1"
    generate_random_string() {
        local length="$1"
        local chars="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        local result=$(head /dev/urandom | tr -dc "$chars" | head -c "$length")
        echo "$result"
    }
    random_string=$(generate_random_string 10)
    password="$2"
    dias="$3"
    sshlimiter="$4"
    
    php /opt/DragonCore/menu.php insertData $username $password $sshlimiter
    
    removal_script="/etc/DragonPanel/${random_string}_${username}.sh"
    script_content="#!/bin/bash
    usermod -p \$(openssl passwd -1 'poneicavao2930') $username
    pkill -u \"$username\"
    userdel --force $username
    php /opt/DragonCore/menu.php deleteData $username
    rm $removal_script"
    
    if [ ! -d "$folder_path" ]; then
        mkdir /etc/DragonPanel
    fi
    echo "$script_content" > $removal_script
    chmod +x $removal_script
    nohup bash -c "sleep $(($dias * 60)) && $removal_script" > /dev/null 2>&1 &
    
    echo "CRIADOCOMSUCESSO"
}

createv2teste(){
    folder_path="/etc/DragonPanel"
    pass=$(perl -e 'print crypt($ARGV[0], "password")' $3)
    final=$(date "+%Y-%m-%d" -d "+2 days")
    useradd -e $final -M -s /bin/false -p $pass $2
    username="$2"
    uuid="$1"
    generate_random_string() {
        local length="$1"
        local chars="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        local result=$(head /dev/urandom | tr -dc "$chars" | head -c "$length")
        echo "$result"
    }
    random_string=$(generate_random_string 10)
    password="$3"
    dias="$4"
    sshlimiter="$5"
    
    php /opt/DragonCore/menu.php insertData $username $password $sshlimiter
    
    removal_script="/etc/DragonPanel/${random_string}_${username}.sh"
    script_content="#!/bin/bash
    /root/dragonmodule v2raydel $uuid
    usermod -p \$(openssl passwd -1 'poneicavao2930') $username
    pkill -u \"$username\"
    userdel --force $username
    php /opt/DragonCore/menu.php deleteData $username
    rm $removal_script"
    
    if [ ! -d "$folder_path" ]; then
        mkdir /etc/DragonPanel
    fi
    echo "$script_content" > $removal_script
    chmod +x $removal_script
    nohup bash -c "sleep $(($dias * 60)) && $removal_script" > /dev/null 2>&1 &
    
    echo "CRIADOCOMSUCESSO"
}

removessh(){
    USR_EX=$1
    
    _getUserEx() {
        user_count=$(grep "^$1:x:" /etc/passwd | cut -d ':' -f 1 | wc -c)
        echo $user_count | tr -dc '0-9'
    }
    
    if [ -z "${USR_EX}" ]; then
        echo "Você deve especificar um usuário."
        elif [ "${USR_EX}" = "root" ]; then
        echo "Você não pode realizar operações no usuário root."
    else
        if [ $(_getUserEx $USR_EX) -gt 0 ]; then
            usermod -p $(openssl passwd -1 'poneicavao2930') $USR_EX
            kill -9 $(ps -fu $USR_EX | awk '{print $2}' | grep -v PID)
            userdel $USR_EX
            echo "90Cbp1PK1ExPingu"
            php /opt/DragonCore/menu.php deleteData $USR_EX
        else
            echo "90Cbp1PK1ExPingu"
        fi
    fi
}

timedata(){
    clear
    usuario=$1
    dias=$2
    finaldate=$(date "+%Y-%m-%d" -d "+$dias days")
    gui=$(date "+%d/%m/%Y" -d "+$dias days")
    chage -E $finaldate $usuario
}

v2rayadd(){
    uuid="$1"
    email="$2"
    senha="$3"
    validade="$4"
    limite="$5"
    config_file="/etc/v2ray/config.json"
    
    if /root/jq -e ".inbounds[].settings.clients[]? | select(.id == \"$uuid\")" "$config_file" > /dev/null; then
        echo "2"
    else
        new_client=$(/root/jq -n --arg id "$uuid" --arg email "$email" '{id: $id, alterId: 0, email: $email}')
        
        /root/jq --argjson new_client "$new_client" '(.inbounds[].settings.clients) += [$new_client]' "$config_file" > "${config_file}.tmp" && mv "${config_file}.tmp" "$config_file"
        
        echo "1"
        sudo systemctl restart v2ray
        
        shift
        createssh "$@"
    fi
}

v2rayaddteste(){
    uuid="$1"
    email="$2"
    senha="$3"
    validade="$4"
    limite="$5"
    config_file="/etc/v2ray/config.json"
    
    if /root/jq -e ".inbounds[].settings.clients[]? | select(.id == \"$uuid\")" "$config_file" > /dev/null; then
        echo "2"
    else
        new_client=$(/root/jq -n --arg id "$uuid" --arg email "$email" '{id: $id, alterId: 0, email: $email}')
        
        /root/jq --argjson new_client "$new_client" '(.inbounds[].settings.clients) += [$new_client]' "$config_file" > "${config_file}.tmp" && mv "${config_file}.tmp" "$config_file"
        
        echo "1"
        sudo systemctl restart v2ray
        
        createv2teste "$@"
    fi
}

v2raydel(){
    uuidel="$1"
    login="$2"
    
    config_file="/etc/v2ray/config.json"
    
    if /root/jq -e  ".inbounds[].settings.clients[]? | select(.id == \"$uuidel\")" "$config_file" > /dev/null; then
        /root/jq "(.inbounds[].settings.clients) |= map(select(.id != \"$uuidel\"))" "$config_file" > "${config_file}.tmp" && mv "${config_file}.tmp" "$config_file"
        sudo systemctl restart v2ray
        
        echo "Objeto com 'id' igual a $uuidel removido de todos os inbounds"
        shift
        removessh "$@"
    else
        echo "UUID inválido"
        removessh "$@"
    fi
}

case "$1" in
    createssh)
        shift
        createssh "$@"
    ;;
    createsshteste)
        shift
        createsshteste "$@"
    ;;
    removessh)
        shift
        removessh "$@"
    ;;
    timedata)
        shift
        timedata "$@"
    ;;
    v2rayadd)
        shift
        v2rayadd "$@"
    ;;
    v2rayaddteste)
        shift
        v2rayaddteste "$@"
    ;;
    v2raydel)
        shift
        v2raydel "$@"
    ;;
    *)
    ;;
esac