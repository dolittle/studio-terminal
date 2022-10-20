module.exports = (shell) => {
    const shellApi = shell.config._instanceState.shellApi;
    const Help = shell.help.constructor;
    
    const helpCommandAttr = Object.getPrototypeOf(shell.help).attr;
    
    const createHelp = (properties) => {
        const help = new Help(
            properties,
            {
                translate: _ => _,
            },
        );
    
        const callable = () => help;
        Object.setPrototypeOf(callable, help);
        
        return callable;
    };
    
    const addCommandToShell = ({ name, callback, help, completer }) => {
        const command = (...args) => callback(...args);
        command.isDirectShellCommand = true;
        command.acceptsRawInput = false;
        command.returnsPromise = true;
    
        command.serverVersions = [ '0.0.0', '999.999.999' ];
        command.apiVersions = [ 0, Infinity ];
        command.topologies = [ 'ReplSet', 'Sharded', 'LoadBalanced', 'Standalone' ];
        command.returnType = { type: 'unknown', attributes: {} };
        command.platforms = [ 'Compass', 'Browser', 'CLI' ];
        command.deprecated = false;
    
    
        if (completer !== undefined) {
            command.shellCommandCompleter = completer;
        }
    
        const func = (...args) => callback(...args);
    
        if (help !== undefined) {
            command.help = help;
            func.help = help;
    
            helpCommandAttr.push({
                name,
                description: help.help,
            });
        }
    
        shellApi[name] = command;
        shell[name] = func;
    };
    
    return {
        addCommandToShell,
        createHelp,
        shellApi,
        Help,
    };
}

