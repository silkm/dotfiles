#!/bin/sh

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 25
defaults write com.apple.dock largesize -int 128
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock wvous-br-corner -int 14   # bottom-right hot corner: Quick Note
defaults write com.apple.dock wvous-br-modifier -int 0
killall Dock

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"  # default to list view
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder FXICloudDriveDesktop -bool false
defaults write com.apple.finder FXICloudDriveDocuments -bool false
killall Finder

# Appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -bool true

# Trackpad & mouse
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 14
defaults write NSGlobalDomain "com.apple.trackpad.forceClick" -bool true
defaults write NSGlobalDomain "com.apple.mouse.scaling" -float 3
defaults write NSGlobalDomain "com.apple.scrollwheel.scaling" -float 0.75
defaults write NSGlobalDomain "com.apple.swipescrolldirection" -bool true

# Sound
defaults write NSGlobalDomain "com.apple.sound.beep.sound" -string "/System/Library/Sounds/Frog.aiff"
defaults write NSGlobalDomain "com.apple.sound.uiaudio.enabled" -bool false

# Wallpaper
osascript -e 'tell application "Finder" to set desktop picture to POSIX file (POSIX path of (path to home folder) & "img/IMG_5750.JPG")'

# Screenshots
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
