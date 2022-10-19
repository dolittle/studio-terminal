#!/bin/bash
# Adds a command to show the help text

function help() {
    echo -e "Welcome to the Dolittle Studio Terminal."
    echo -e "\tUse the \e[1minfo\e[0m command to print the information about which microservice this terminal interacts with"
    echo -e "\tUse the \e[1mdolittle\e[0m command to manage and interact with the Runtime for this microservice"
    echo -e "\tUse the \e[1mmongosh\e[0m command to connect to with the MongoDB for this microservice"
    echo -e "\tUse the \e[1mhelp\e[0m command to print this message again"
    echo -e "Other common *nix commands are also available"
}
