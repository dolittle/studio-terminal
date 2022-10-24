module.exports.TenantDatabases = class TenantDatabases {
    constructor(global, resources) {
        this.global = global;
        this.resources = resources;

        this.currentTenant = undefined;
        this.currentResource = undefined;
    }

    getSuggestedTenants(arg) {
        const tenants = Object.keys(this.resources);
        return tenants.filter(_ => _.startsWith(arg));
    }

    getSuggestedResources(arg) {
        let resources = [];
        if (this.currentTenant !== undefined) {
            resources = Object.keys(this.resources[this.currentTenant]).map(_ => _.toLowerCase());
        } else {
            const all = Object.values(this.resources).flatMap(_ => Object.keys(_)).map(_ => _.toLowerCase())
            resources = [... new Set(all).values()];
        }
        return resources.filter(_ => _.startsWith(arg));
    }

    getDatabaseAndHostToUse(...args) {
        if (args[0] === 'tenant') {
            if (args[1] in this.resources) {
                this.currentTenant = args[1];
                return this.getDatabaseAndHostToUseForCurrentTenant();
            }

            throw new Error(`${args[1]} is not a configured tenant`);
        }

        return this.getDatabaseAndHostToUseForCurrentTenant(args[0]);
    }

    getDatabaseAndHostToUseForCurrentTenant(requestedResource) {
        if (this.currentTenant === undefined) {
            return;
        }

        const suggestedResource = requestedResource ?? this.currentResource ?? 'eventstore';

        for (const [resource, config] of Object.entries(this.resources[this.currentTenant])) {
            if (suggestedResource.toLowerCase() === resource.toLowerCase()) {
                this.currentResource = resource.toLowerCase();
                console.log(`Switching to ${this.currentResource} for tenant ${this.currentTenant}`);
                return this.databaseAndHostFor(config);
            }
        }

        const firstConfiguredResource = Object.entries(this.resources[this.currentTenant])[0];
        if (requestedResource !== undefined || firstConfiguredResource === undefined) {
            return;
        }

        const [resource, config] = firstConfiguredResource;
        this.currentResource = resource.toLowerCase();
        console.log(`Switching to ${this.currentResource} for tenant ${this.currentTenant}`);
        return this.databaseAndHostFor(config);
    }

    databaseAndHostFor(config) {
        const db = config.database;
        const host = config.host ?? `mongodb://${config.servers[0]}:27017`;
        return [db, host];
    }
};
