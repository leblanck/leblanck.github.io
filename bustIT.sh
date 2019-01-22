#!/bin/bash
#################################
# Created by @kyleblanc         #
# -Used to setup new macOS      #
#   environment using homebrew. #
#   Cask WishList is located    #
#   below this description.     #
#                               #
#   Last Update: 01/22/19       #
#################################
# Cask WishList/To Do         #
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
  # This will iterate through cask installs, only stopping when a trigger is hit to execute
  # additional commands for that specific installer.
  # To add additional casks, add them into $casks array.
  declare -a casks=("spectacle" "wireshark" "clipy" "atom" "slack" "adobe-creative-cloud" "messenger" "dropbox" "xnviewmp" "fliqlo")
  atomTrigger="atom"
  adobeTrigger="adobe-creative-cloud"

  for i in "${casks[@]}"
  do
    if [ "$i" == "$atomTrigger" ]; then
      #Triggered when current cask = Atom
      echo "`date` Installing" $i"..."
      brew cask install $i
      atomExtras
    elif [ "$i" == "$adobeTrigger" ]; then
      #Triggered when current cask = Adobe CC
      echo "`date ` Installing" $i"..."
      brew cask install $1
      sleep 5
      open -a /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
    else
      #All other casks
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
