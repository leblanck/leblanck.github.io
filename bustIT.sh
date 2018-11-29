#!/bin/bash
#################################
# Created by @kyleblanc         #
# -Used to setup new macOS      #
#   environment using homebrew. #
#   Cask WishList is located    #
#   below this description.     #
#                               #
#   Last Update: 11/29/18       #
#################################
# Cask WishList               #
#                             #
#                             #
#  Cask list available using: #
#     brew search --casks     #
###############################

#@@@@@@@@@@@@ MAIN @@@@@@@@@@@@

# LOG ##########################################
LogFile="/Library/Logs/bustIT.log"
if [[ ! -e $LogFile ]]; then
    sudo touch $LogFile && exec >> $LogFile
    echo "`date` ========== Log File Created"
else
    sudo exec >> $LogFile
fi
###############################################

caskInstaller() {
  declare -a casks=("spectacle" "wireshark" "clipy" "atom" "slack" "adobe-creative-cloud" "messenger")
  atomTrigger="atom"
  adobeTrigger="adobe-creative-cloud"

  for i in "${casks[@]}"
  do
    if [ "$i" == "$atomTrigger" ]; then
      echo "`date` Installing from trigger" $i"..."
      brew cask install $i
      atomExtras
    elif [ "$i" == "$adobeTrigger" ]; then
      echo "`date ` Installing from trigger2" $i"..."
      brew cask install $1
      sleep 5
      open -a /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
    else
      echo "`date` Installing" $i"..."
      brew cask install $i
    fi
  done
}

atomExtras() {
  #Install Atom Themes
  echo "`date` Installing Atom themes.."
  apm install apple-wwdc-2016-syntax
  apm install firewatch-syntax
  apm install halcyon-syntax

  #Install Atom Packages
  echo "`date` Installing Atom packages..."
  apm install file-icons
  apm install minimap
  apm install pigments

  #CLI Tools
  echo "`date` Installing Atom CLI Tools..."
  ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom
}

homebrewInstall() {
  echo "`date` Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sleep 5
  echo "`date` Tapping Cask..."
  brew tap homebrew/cask
  sleep 5
  echo "`date` Installing Apps..."
  caskInstaller
  sleep 5
  echo "`date` Done!"
}

homebrewInstall
