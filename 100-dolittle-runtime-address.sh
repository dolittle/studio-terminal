# Pass the Dolittle Runtime address for this microservice to the Dolittle CLI as an argument

dolittle () {
    /usr/bin/dolittle "$@" --runtime $DOLITTLE_RUNTIME_ADDRESS
}
