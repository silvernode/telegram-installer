#!/bin/bash

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

PKGNAME="tsetup"
VERSION="0.8.55"
URL="https://updates.tdesktop.com/tlinux/${PKGNAME}.${VERSION}.tar.xz"
FILE="${PKGNAME}.${VERSION}.tar.xz"
OUTDIR="${HOME}/.telegram/bin"

#check and create directories
checkDir(){

  if [ ! -d ${OUTDIR} ];then
    mkdir -v -p ${OUTDIR}
    if [ ! -d ${OUTDIR} ];then
      echo "The directory '${OUTDIR}' could not be created"
      return false
    fi
  else
    return true
  fi
}


askOpen(){

  echo -n "Do you want to run telegram now?[y/n]"
  read runNow
  
  if [ "${runNow}" = "y" ];then
    ${OUTDIR}/Telegram/Telegram
  else
    exit 0;
  fi
}

#Pull everything together
main(){
  checkDir
  if [ ! checkDir ];then
    echo "Looks like something went wrong creating the directory"
    
  else
    
    if [ ! -f /tmp/${FILE} ];then
      wget ${URL} -P /tmp
      tar xvf /tmp/${FILE} -C ${OUTDIR}
      echo
      askOpen
    elif [ -f /tmp/${FILE} ];then
      tar xvf /tmp/${FILE} -C ${OUTDIR}
      echo
      askOpen
      
    else
      echo "Looks like the file does not exist"
      echo "Check your internet connection and system permissions"
      return false
    fi
  fi
  
    
}

main



