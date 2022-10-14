
cat << EOF
Welcome to the Studio Terminal.
Use 'dolittle runtime' command to manage this microservices runtime and display information.
Use 'mongosh' command to connect to this environments MongoDB.
Use 'help' to display information about available commands.
Other common *nix commands are also available.

For more information, check https://github.com/dolittle/studio-terminal
EOF

# sudo apt-get install bash-completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
