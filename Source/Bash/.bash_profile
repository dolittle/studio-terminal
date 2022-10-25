#!/bin/bash

COLOR=$(echo -ne "\e[38;2;255;75;0m")
RESET=$(echo -ne "\e[0m")

# Print a pretty logo as a welcome message
cat <<-END
$COLOR        / \        $RESET
$COLOR       /   \       $RESET
$COLOR   __  \    \      $RESET ___   ___  _    ___ _____ _____ _    ___ 
$COLOR  /  \  \    \     $RESET|   \ / _ \| |  |_ _|_   _|_   _| |  | __|
$COLOR  \__/  /    /     $RESET| |) | (_) | |__ | |  | |   | | | |__| _| 
$COLOR  _____/    /      $RESET|___/ \___/|____|___| |_|   |_| |____|___|
$COLOR /         /       $RESET
$COLOR/_________/        $RESET
END

# Make the prompt show the current microservice
PS1_HOST="$DOLITTLE_APPLICATION_NAME>$DOLITTLE_ENVIRONMENT>$DOLITTLE_MICROSERVICE_NAME"
PS1='\[\e]0;\u@$PS1_HOST: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$PS1_HOST\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

echo ""
help
echo ""
info
