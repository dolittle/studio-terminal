#!/bin/bash

# Print a pretty logo as a welcome message
cat <<-END
        / \        
       /   \       
   __  \    \       ___   ___  _    ___ _____ _____ _    ___ 
  /  \  \    \     |   \ / _ \| |  |_ _|_   _|_   _| |  | __|
  \__/  /    /     | |) | (_) | |__ | |  | |   | | | |__| _| 
  _____/    /      |___/ \___/|____|___| |_|   |_| |____|___|
 /         /       
/_________/        
END

# Make the prompt show the current microservice
PS1_HOST="$DOLITTLE_APPLICATION_NAME>$DOLITTLE_ENVIRONMENT>$DOLITTLE_MICROSERVICE_NAME"
PS1='\[\e]0;\u@$PS1_HOST: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$PS1_HOST\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

echo ""
help
echo ""
info
