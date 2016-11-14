#!/bin/bash

# author: Raine Curtis (rcurtis@saltstack.com)
# version: 20161114-1
# description: install salt on a Linux system

# Global variables
SRC_DIR="/vagrant"

# Start of utility functions
function show_header () {
  MSG="${1}"
  echo "-----------------------------------------------------"
  echo " ${MSG}"
  echo "-----------------------------------------------------"
}

# show error message
function echoerror() {  
    printf "${RC} * ERROR${EC}: %s\n" "$@" 1>&2;
}              

# show info message
function echoinfo() { 
    printf "${GC} ########## *  INFO${EC}: %s ########## \n" "$@"; 
}

# show warning message
echowarn() {           
    printf "${YC} *  WARN${EC}: %s\n" "$@";
} 
 
#   DESCRIPTION:  Try to detect color support.
__detect_color_support() { 
    if [ $? -eq 0 ] && [ "$_COLORS" -gt 2 ]; then
        RC="\033[1;31m"   
        GC="\033[1;32m"  
        BC="\033[1;34m" 
        YC="\033[1;33m"
        EC="\033[0m"  
    else             
        RC=""       
        GC=""      
        BC=""   
        YC=""  
        EC="" 
    fi             
}                                                                                                                           
# Function to build Salt master
function build_salt_master () {
  show_header "Installing Salt Master"
  echoinfo "Setting Salt master configuration"
  mkdir -p /etc/salt
  cp -f ${SRC_DIR}/provision/master /etc/salt/master

  echoinfo "Setting Salt minion configuration"
  cp -f ${SRC_DIR}/provision/minion /etc/salt/minion

  echoinfo "Bootstrapping Salt"
  cur_date=`date "+%Y-%m-%d"`
  CUR_BOOTSTRAP="${SRC_DIR}/provision/${cur_date}-bootstrap-salt.sh"
  echoinfo "curl -o ${CUR_BOOTSTRAP} -L http://bootstrap.saltstack.com"
  curl -o ${CUR_BOOTSTRAP} -L http://bootstrap.saltstack.com
  chmod +x  ${CUR_BOOTSTRAP}
  ${CUR_BOOTSTRAP} -M
}

# Additional Salt master options
function add_addition_salt_master_setup () {
  echoinfo "-- Additional Salt Master Setup --"
  mkdir -p /srv/salt
  echoinfo "-- Copy class files -- "
  cp -af /vagrant/provision/class-files /root/
}

# Function to build a Salt minion
function build_salt_minion () {
  show_header "Installing Salt Minion"
  echoinfo "Setting Salt minion configuration"
  mkdir -p /etc/salt
  cp -f ${SRC_DIR}/provision/minion /etc/salt/minion

  echoinfo "Bootstrapping Salt"
  cur_date=`date "+%Y-%m-%d"`
  CUR_BOOTSTRAP="${SRC_DIR}/provision/${cur_date}-bootstrap-salt.sh"
  echoinfo "curl -o ${CUR_BOOTSTRAP} -L http://bootstrap.saltstack.com"
  curl -o ${CUR_BOOTSTRAP} -L http://bootstrap.saltstack.com
  chmod +x  ${CUR_BOOTSTRAP}
  ${CUR_BOOTSTRAP}
}

function add_salt_minion_setup () {
  echo
  #echoinfo "Restarting salt-minion service"
  #service salt-minion stop
  #sleep 5
  #service salt-minion start
}

#--- MAIN start of execution ------
_COLORS=${BS_COLORS:-$(tput colors 2>/dev/null || echo 0)}   
__detect_color_support 

SCRIPT_MODE="${1}"

if [ "${SCRIPT_MODE}" =  "master" ]; then
  echoinfo "Running in master mode"
  build_salt_master 
  add_addition_salt_master_setup
elif [ "${SCRIPT_MODE}" =  "minion" ]; then
  echoinfo "Running in minion mode"
  build_salt_minion
  add_salt_minion_setup
else
  echoinfo "usage: ${0} [master|minion]"
fi
echoinfo "Complete!"



