#!/bin/bash

# Name : telegram-installer.sh
############################################################################
##    This program is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program.  If not, see <http://www.gnu.org/licenses/>.
############################################################################

URL="https://tdesktop.com/linux"
FILE="tsetup.tar.xz"
OUTDIR="${HOME}/.telegram/bin"
SYMDIR="/usr/bin"

#check and create directories
checkDir(){

  if [ ! -d ${OUTDIR} ];then
    mkdir -v -p ${OUTDIR}
    if [ ! -d ${OUTDIR} ];then
      echo "The directory '${OUTDIR}' could not be created"
      return false
    fi
  else
    return 0
  fi
}


askOpen(){

  echo -n "Do you want to run telegram now?[y/n]"
  read runNow

  if [ "${runNow}" = "y" ];then
    ${OUTDIR}/Telegram/Telegram
  else
    return 1
  fi
}

createSym(){
  echo -n "Do you want to create a symlink to ${SYMDIR}?[y/n](requires root): "
  read symchoice

  if [ ${symchoice} = "n" ];then
    return 1
  else
    sudo ln -s -v ${OUTDIR}/Telegram/Telegram ${SYMDIR}/telegram
  fi
}
chkInstall(){

  if [ -d ~/.telegram ];then
    echo
    echo -n "Telegram is already installed, would you like to uninstall it?[y/n]: "
    read choice

    if [ "${choice}" = "y" ];then
      echo
      echo "Removing symlink from ${SYNDIR}..."
      sudo rm /usr/bin/telegram
      echo
      echo "Removing ${OUTDIR}..."
      echo
      rm -r -v ~/.telegram
      if [ ! -d ~/.telegram ];then
        echo
        echo "Telegram is uninstalled"
        exit 0;
      else
        echo
        echo "Telegram is still installed, please remove it manually"
      fi
    else
      echo
      echo "Skipping removal"
      exit 0;
    fi
  else
    echo
    echo "Telegram is not installed"
  fi
}

#Pull everything together
main(){
  chkInstall
  checkDir
  if [ ! checkDir ];then
    echo "Looks like something went wrong creating the directory"

  else

    if [ ! -f /tmp/${FILE} ];then
      wget -O /tmp/${FILE} ${URL}
      tar xvf /tmp/${FILE} -C ${OUTDIR}
      echo
      askOpen
      createSym
    elif [ -f /tmp/${FILE} ];then
      tar xvf /tmp/${FILE} -C ${OUTDIR}
      echo
      createSym
      askOpen
    else
      echo "Looks like the file does not exist"
      echo "Check your internet connection and system permissions"
      return false
    fi
  fi


}


main
