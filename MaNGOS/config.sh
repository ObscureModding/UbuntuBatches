#!/bin/bash

# Based on https://github.com/cmangos/issues/wiki/Installation-Instructions


action="$1"

bool=""
proxysv=""
configdir=""
scriptname=$(readlink -f "$0")
scriptpath=$(dirname "$scriptname")
srvname="mangos"
config="$srvname"
projdir="$srvname-git"
nmtitle[0]="Vanilla"
nmtitle[1]="The burning crusade (TBC)"
nmtitle[2]="Wrath of the lich king (WoTLK)"
nmtitle[3]="Cataclysm"
idtitle=""

case "$action" in
  "update")
    echo "Updating package ..."
    cd $scriptpath/$config/$projdir
    sudo make distclean
    git pull
    ./configure
    sudo make
    sudo checkinstall
  ;;
  "install")
    echo "Which title do you want to install:"

    for (( i=0; i<=$(( ${#nmtitle[*]} -1 )); i++ ))
    do
        echo "$i >> ${nmtitle[$i]}"
    done
    read -p "Enter tiltle ID: " idtitle
    
    if [[ -z "${nmtitle[$idtitle]}" ]]
    then
      echo "Wrong title ID: $idtitle"
      exit 0
    fi
    
    echo "Installing package [${nmtitle[$idtitle]}] ..."

    read -p "Install dependancies [y or n] ? " bool
    if test "$bool" == "y"
    then
      sudo apt-get update
      # Dependancies
      sudo apt-get install build-essential
      sudo apt-get install gcc
      sudo apt-get install g++
      sudo apt-get install automake
      sudo apt-get install git-core
      sudo apt-get install autoconf
      sudo apt-get install make
      sudo apt-get install patch
      sudo apt-get install libmysql++-dev
      sudo apt-get install mysql-server
      sudo apt-get install libtool
      sudo apt-get install libssl-dev
      sudo apt-get install grep
      sudo apt-get install binutils
      sudo apt-get install zlibc
      sudo apt-get install libc6
      sudo apt-get install libbz2-dev
      sudo apt-get install cmake
      sudo apt-get install subversion
      sudo apt-get install libboost-all-dev
    fi

    # Set the proxy if any
    echo "Are you using a proxy [no or <proxy:port>]  ?"
    read -r proxysv
    if test "$proxysv" == "no"
    then
      sudo git config --global -l
      sudo git config --global --unset http.proxy
    else
      sudo git config --global http.proxy "$proxysv"
      echo "Proxy set to [$proxysv] !" 
    fi
      
    # Download and compile the source
    sudo rm -fr $config
    mkdir $config
    cd $config
    
    case "$idtitle" in
    "0")
      git clone https://github.com/cmangos/mangos-classic.git $projdir
    ;;
    "1")
      git clone https://github.com/cmangos/mangos-tbc.git $projdir
    ;;
    "2")
      git clone https://github.com/cmangos/mangos-wotlk.git $projdir
    ;;
    "3")
      git clone https://github.com/cmangos/mangos-cata.git $projdir
    ;;
    esac
    
    
    
  ;;
  "remove")
    echo "Removing package ..."
    sudo apt-get remove $srvname
    sudo update-rc.d -f $srvname remove
    sudo rm /etc/init.d/$srvname
    sudo rm -r $scriptpath/$config
  ;;
  "config")
    echo "Opening settings ..."
    sudo gedit $scriptpath/$config/minidlna.conf
  ;;
  "stats")
    echo "Home: $HOME"
    echo "PWDD: $PWD"
    echo "Name: $scriptname"
    echo "Path: $scriptpath"
    echo "SRVN: $srvname"
    echo "Conf: $config"
    echo "Proj: $projdir"
  ;;
  *)
    echo "Usage: $0 { update | install | remove | config | stats }"
  ;;
esac

exit 0
