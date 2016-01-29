#!/bin/bash

# Global variables
SRC_DIR="/vagrant"

# Start of utility functions

function show_header () {
  MSG="${1}"
  echo "-----------------------------------------------------"
  echo " ${MSG}"
  echo "-----------------------------------------------------"
}

function echoerror() {  
    printf "${RC} * ERROR${EC}: %s\n" "$@" 1>&2;
}                                                                                                                           
function echoinfo() { 
    printf "${GC} ########## *  INFO${EC}: %s ########## \n" "$@"; 
}                                                                                                                           
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

function add_addition_salt_master_setup () {
  #echoinfo "-- Additional Salt Master Setup --"
  #echoinfo "Installing Additional Salt packages"
  #yum -y install salt*

  echoinfo "Copying setup files"
  mkdir -p /srv/salt
  cp -avf ${SRC_DIR}/provision/srv  /

  #echoinfo "Extracting instructor files"
  #tar xzvf ${SRC_DIR}/provision/instr_srv.tgz -C /

  echoinfo "Extracting class-files"
  tar xzvf ${SRC_DIR}/provision/class-files.tgz -C /srv/salt/
  #tar xzvf ${SRC_DIR}/provision/class-files.tgz -C /root/

  echoinfo "Copying cloud files to state tree"
  cp -avf ${SRC_DIR}/provision/cloud-ec2  /srv/salt/class-files/

  #echoinfo "Placing roster file"
  #cp -f ${SRC_DIR}/provision/roster /etc/salt/roster

  echoinfo "Performing Salt Highstate..."
  salt \* state.highstate
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
  echoinfo "Copying class files"
  tar xzvf ${SRC_DIR}/provision/class-files.tgz -C /root/
}

#--- MAIN ------
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



