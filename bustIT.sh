#################################
# Created by @kyleblanc         #
# -Used to setup new macOS      #
#   environment using homebrew. #
#   App WishList is located     #
#   below this description.     #
#                               #
#   Last Update: 11/26/18       #
#################################
# Cask WishList               #
#   -Clipy                    #
#   -Messenger                #
#   -WireShark                #
#   -Adobe CC                 #
#  Cask list available using: #
#     brew search --casks     #
###############################

#@@@@@@@@@@@@ MAIN @@@@@@@@@@@@

###########
# Logging #
###########
LogFile="/Library/Logs/bustIT.log"
if [[ ! -e $LogFile ]]; then
    sudo touch $LogFile && exec >> $LogFile
    echo "`date` ========== Log File Created"
else
    sudo exec >> $LogFile
fi

atomInstall() {
  ATOM=/Applications/Atom.app/

  echo "`date` Installing Atom..."
  brew cask install atom
  sleep 5
  if [ ! -d "$ATOM" ]; then
    echo "`date` " $ATOM "was not installed succesfully!"
  else
    echo "`date` "  $ATOM "installed!"
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
  fi
}

spectacleInstall() {
  SPECTACLE=/Applications/Spectacle.app/

  echo "`date` Installing Spectacle..."
  brew cask install spectacle

  if [ ! -d "$SPECTACLE" ]; then
    echo "`date` " $SPECTACLE "was not installed succesfully!"
  else
    echo "`date` "  $SPECTACLE "installed!"
  fi
}

slackInstall() {
  SLACK=/Applications/Slack.app/

  echo "`date` Installing Slack..."
  brew cask install slack

  if [ ! -d "$SLACK" ]; then
    echo "`date` " $SLACK "was not installed succesfully!"
  else
    echo "`date` "  $SLACK "installed!"
  fi
}

homebrewInstall() {
  echo "`date` Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sleep 5
  echo "`date` Tapping Cask..."
  brew tap homebrew/cask
  sleep 5
  echo "`date` Installing Apps..."
  slackInstall
  sleep 5
  spectacleInstall
  sleep 5
  atomInstall
  echo "`date` Done!"
}

homebrewInstall
