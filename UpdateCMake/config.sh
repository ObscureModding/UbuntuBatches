#!/bin/bash

action="$1"
option="$2"
vcmake=""
pcmake=""
bool=""
url=""
owget=""
nfile=""


scriptname=$(readlink -f "$0")
scriptpath=$(dirname "$scriptname")

case "$action" in
  "install")
    if test "$option" != ""
    then
      nfile="cmake-$option.tar.gz"
      url="https://github.com/Kitware/CMake/releases/download/v$option/$nfile"
      owget=$(wget -O $nfile $url) # Save the same file name on second run
      if [ $? -ne 0 ]; then
        echo "Version mismatch: $option"
      else
        tar -zxvf cmake-$option.tar.gz
        cd $scriptpath/cmake-$option
        ./bootstrap
        make
        make install
        
        vcmake=$(cmake --version | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}')
        pcmake=$(which cmake)
        
        echo "Congratolations installing CMake!"
        echo "Version : $vcmake"
        echo "Location: $pcmake"

        read -p "Delete downloaded files [y/N] ? " bool
        if test "$bool" == "y"
        then
          cd $scriptpath
          rm -f $scriptpath/$nfile
          rm -rf $scriptpath/cmake-$option
        fi
      fi
    else
      echo "Provide desired version to be installed!"
    fi
  ;;
  "remove")
    echo "This will delete the CMake from the system !!!"
    read -p "Continue with this process [y/N] ? " bool
    if test "$bool" == "y"
    then
      sudo apt purge cmake
    fi
  ;;
  "paths")
    echo "Home: $HOME"
    echo "PWDD: $PWD"
    echo "Name: $scriptname"
    echo "Path: $scriptpath"
  ;;
  *)
    echo "Please use some of the options in the list below for [./config.sh]."
    echo "install <ver> --> Installed the user specified version."
    echo "remove        --> Purges the packet from the system."
    echo "paths         --> Displays the paths used by the installation."
  ;;
esac

exit 0
