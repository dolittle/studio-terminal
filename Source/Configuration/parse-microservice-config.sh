#!/bin/bash
# Parses the configuration files provided by the Dolittle platform to setup the shell

ENDPOINTS="$HOME/.dolittle/endpoints.json"
PLATFORM="$HOME/.dolittle/platform.json"
RUNTIME="$HOME/.dolittle/runtime.yml"

if [ -f "$RUNTIME" ]; then
    export DOLITTLE_RUNTIME_ADDRESS="localhost:51052"

    export DOLITTLE_CUSTOMER_ID=$(yq '.platform.customerID' "$RUNTIME")
    export DOLITTLE_CUSTOMER_NAME=$(yq '.platform.customerName' "$RUNTIME")
    export DOLITTLE_APPLICATION_ID=$(yq '.platform.applicationID' "$RUNTIME")
    export DOLITTLE_APPLICATION_NAME=$(yq '.platform.applicationName' "$RUNTIME")
    export DOLITTLE_ENVIRONMENT=$(yq '.platform.environment' "$RUNTIME")
    export DOLITTLE_MICROSERVICE_ID=$(yq '.platform.microserviceID' "$RUNTIME")
    export DOLITTLE_MICROSERVICE_NAME=$(yq '.platform.microserviceName' "$RUNTIME")
    yq -o=json '.tenants | map({key: .resources}) | .[] as $item | $item | to_entries | .[] as $item ireduce ({}; .[$item | .key] = ($item | .value) )' "$RUNTIME" > $HOME/.dolittle/resources.json
else 
    export DOLITTLE_RUNTIME_ADDRESS=$(jq -r '"localhost:" + (.management.port | tostring)' "$ENDPOINTS")

    export DOLITTLE_CUSTOMER_ID=$(jq -r '.customerID' "$PLATFORM")
    export DOLITTLE_CUSTOMER_NAME=$(jq -r '.customerName' "$PLATFORM")
    export DOLITTLE_APPLICATION_ID=$(jq -r '.applicationID' "$PLATFORM")
    export DOLITTLE_APPLICATION_NAME=$(jq -r '.applicationName' "$PLATFORM")
    export DOLITTLE_ENVIRONMENT=$(jq -r '.environment' "$PLATFORM")
    export DOLITTLE_MICROSERVICE_ID=$(jq -r '.microserviceID' "$PLATFORM")
    export DOLITTLE_MICROSERVICE_NAME=$(jq -r '.microserviceName' "$PLATFORM")

fi

shopt -s nocasematch
export DOLITTLE_IS_PRODUCTION="TRUE"
if ! [[ "$DOLITTLE_ENVIRONMENT" =~ "^prod" ]]; then
    export -n DOLITTLE_IS_PRODUCTION
    unset DOLITTLE_IS_PRODUCTION
fi
shopt -u nocasematch
