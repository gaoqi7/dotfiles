# https://github.com/ddelange/new-mac-setup#notes
# install homebrew (which installs command-line tools)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap homebrew/cask
# check whether all is good
brew doctor

# and some essentials
brew install \
	vim node tmux htop bat p7zip
#The --no-quarantine option is needed because Alacritty isn’t part of the Apple developer program. 
brew install --cask --no-quarantine alacritty

brew install --cask \
       	bettertouchtool pdf-expert enpass alfred google-chrome vlc authy visual-studio-code transmission adguard forklift flume wechat vmware-fusion goldendict eul
#brew install --cask karabiner-elements
#For app Flume
#codesign --force --deep --sign - /Applications/flume.app   
# Apple Store
#GoodNote


# install oh-my zsh
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
