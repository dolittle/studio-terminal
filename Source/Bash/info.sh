#!/bin/bash
# Adds a command to show the current microservice info

function info() {
    echo -e "This terminal interacts with:"
    echo -e "\tApplication: $DOLITTLE_APPLICATION_NAME ($DOLITTLE_APPLICATION_ID)"
    echo -e "\tEnvironment: $DOLITTLE_ENVIRONMENT"
    echo -e "\tMicroservice: $DOLITTLE_MICROSERVICE_NAME ($DOLITTLE_MICROSERVICE_ID)"
    production_warning
}
