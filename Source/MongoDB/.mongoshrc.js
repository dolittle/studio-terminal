// Disable telemetry by default
disableTelemetry()

{
    const { addCommandToShell, createHelp } = require('/etc/mongosh/api.js')(this);

    addCommandToShell({
        name: 'dolittle',
        callback: (...args) =>
        {
            console.log('Hello from dolittle command', ...args);
            return Promise.resolve();
        },
        help: createHelp({
            help: 'The Dolittle command',
            attr: [
                { name: 'tenants', description: 'Lists the configured tenants' },
            ],
        }),
    });


    // const shellSymbols = Object.getOwnPropertySymbols(Object.getPrototypeOf(Object.getPrototypeOf(this.help)));
    // const asPrintable = shellSymbols.find(_ => _.description.includes('asPrintable'));
    // const shellApiType = shellSymbols.find(_ => _.description.includes('shellApiType'));

    // const helpAttr = Object.getPrototypeOf(this.help).attr;

    // const platform = require('/home/studio/.dolittle/platform.json');
    // const resources = require('/home/studio/.dolittle/resources.json');

    // const is_production = /^prod/i.test(platform.environment);
    // const production_warning = (message) => {
    //     if (is_production) {
    //         this.print(`Friendly reminder, this is a \x1B[1;33mPRODUCTION\x1B[0m environment. ${message ?? ''}`)
    //     }
    // };

    // // Setup the platform information
    // {
    //     // Add info command
    //     Object.defineProperty(
    //         this,
    //         'info',
    //         {
    //             value: new (class Info {
    //                 [asPrintable]() {
    //                     return {
    //                         help: 'This terminal interacts with',
    //                         attr: [
    //                             { name: 'Application', description: `${platform.applicationName} (${platform.applicationID})`},
    //                             { name: 'Environment', description: `${platform.environment}`},
    //                             { name: 'Microservice', description: `${platform.microserviceName} (${platform.microserviceID})`},
    //                         ]
    //                     }
    //                 }
        
    //                 get [shellApiType]() { return 'Help' }
    //             })(),
    //             writable: false,
    //         }
    //     )
    //     helpAttr.splice(0, 0, { name: 'info', description: 'Print the information about which microservice this terminal interacts with' });
    
    //     // Customize the prompt
    //     this.prompt = () => {
    //         return `studio@${platform.applicationName}>${platform.environment}>${platform.microserviceName}: > `;
    //     }
    // }
    
    // // Setup the resources
    // {
    //     // Connect to MongoDB of the first tenants event-store address when starting
    //     const firstTenantEventStoreServer = Object.values(resources)[0].eventStore.servers[0];
    //     this.db = connect(`mongodb://${firstTenantEventStoreServer}:27017/?directConnection=true`);

    //     // Remind people when using production
    //     if (is_production) {
    //         const dbProto = Object.getPrototypeOf(this.db);

    //         const originalDrop = dbProto.dropDatabase;
    //         dbProto.dropDatabase = function (confirmation) {
    //             if (confirmation === 'yes') {
    //                 originalDrop.call(this, originalDrop);
    //             } else {
    //                 production_warning('To really drop this database: db.dropDatabase("yes")')
    //             }
    //         }
    //     }
    // }

    // this.print();
    // production_warning();
    // this.print();
}

