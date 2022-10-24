#!/bin/bash
# Prints a warning message if the shell is attached to a production environment

function production_warning() {
    if ! [[ -z "$DOLITTLE_IS_PRODUCTION" ]]; then
        echo ""
        echo -e "Friendly reminder, this is a \e[1;33mPRODUCTION\e[0m environment."
        echo ""
    fi
}
