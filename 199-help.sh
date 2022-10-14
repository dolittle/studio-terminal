# Define help function to describe what you can do in this debugger terminal
HELP_TEXT=$(cat <<-END
Welcome to the Studio Terminal.
Use 'dolittle runtime' command to manage this microservices runtime and display information.
Use 'mongosh' command to connect to this environments MongoDB.
Other common *nix commands are also available.

For more information, check https://github.com/dolittle/studio-terminal
END
)

function help {
    echo "$HELP_TEXT"
}
