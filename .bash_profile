# Make the prompt show the current microservice

PS1='\[\e]0;\u@$DOLITTLE_MICROSERVICE: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$DOLITTLE_MICROSERVICE\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
