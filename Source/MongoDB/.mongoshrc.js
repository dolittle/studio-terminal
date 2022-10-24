// Disable telemetry by default
disableTelemetry()

{
    const global = this;
    const { addShellCommand, createHelp, overrideShellCommand } = require('/etc/mongosh/api.js')(global);
    const { TenantDatabases } = require('/etc/mongosh/TenantDatabases.js');

    const platform = require('/home/studio/.dolittle/platform.json');
    const is_production = /^prod/i.test(platform.environment);
    const production_warning = (message) =>
        is_production && print(`Friendly reminder, this is a \x1B[1;33mPRODUCTION\x1B[0m environment. ${message ?? ''}`);

    const resources = require('/home/studio/.dolittle/resources.json');

    const databases = new TenantDatabases(global, resources);

    // Override the 'use' command to set current tenant and resource by name
    overrideShellCommand({
        name: 'use',
        callback: function (use, ...args) {
            const result = databases.getDatabaseAndHostToUse(...args);
            if (result === undefined) {
                production_warning();
                return use.call(this, args[0]);
            }

            const [db, host] = result;

            try {
                if (!global.db.getMongo()._connectionInfo.connectionString.startsWith(host)) {
                    global.db = global.connect(host);
                }
            } catch {
                global.db = global.connect(host);
            }

            production_warning();
            return use.call(this, db);
        },
        help: (help) => {
            help.help += ' or tenant';
            return help;
        },
        completer: async function (completer, params, args) {
            const suggestions = await completer.call(this, params, args) ?? [];

            if (args[1] === 'tenant') {
                return [...databases.getSuggestedTenants(args[2] ?? ''), ...suggestions].map(_ => `tenant ${_}`);
            }

            const resources = databases.getSuggestedResources(args[1]);
            if ('tenant'.startsWith(args[1])) {
                return ['tenant', ...resources, ...suggestions];
            } else {
                return [...resources, ...suggestions];
            }
        },
    });

    // Add the same info command as in the shell to print current microservice
    addShellCommand({
        name: 'info',
        callback: async (...args) => {
            print(`This MongoDB shell interacts with:`);
            print(`\tApplication: ${platform.applicationName} (${platform.applicationID})`);
            print(`\tEnvironment: ${platform.environment}`);
            print(`\tMicroservice: ${platform.microserviceName} (${platform.microserviceID})`);
            production_warning();
        },
        help: createHelp({
            help: 'Prints the information about which microservice this terminal interacts with',
        }),
    });

    // Customise the prompt
    global.prompt = () => {
        let db = '';
        try { db = global.db.getName() } catch {}

        return `studio@${platform.applicationName}>${platform.environment}>${platform.microserviceName}: ${db}> `;
    }

    // Connect to the first tenant when booting up
    const firstTenant = databases.getSuggestedTenants('')[0];
    if (firstTenant === undefined) {
        console.warn('No tenants configured for this microservice');
    } else {
        global.use('tenant', firstTenant);
    }

    // Override dangerous commands on 'db' if in production
    if (is_production) {
        // Override dropDatabase
        global.db.dropProductionDatabase = global.db.dropDatabase;
        global.db.dropDatabase = function(confirmation, ...args) {
            if (confirmation === 'yes') {
                return this.dropProductionDatabase(...args);
            }
            production_warning('To really drop this database: db.dropDatabase("yes") or db.dropProductionDatabase()')
        };
    }
}

