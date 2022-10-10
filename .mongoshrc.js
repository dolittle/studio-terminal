// Disable telemetry by default
disableTelemetry()

// Connect to the configured MongoDB address when starting
db = connect(process.env.DOLITTLE_MONGODB_ADDRESS)

// Customise the prompt
{
    const microservice = process.env.DOLITTLE_MICROSERVICE;

    prompt = function() {
        return `studio@${microservice}>`;
    }
}
