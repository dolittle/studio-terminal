# [0.0.5] - 2022-10-24 [PR: #7](https://github.com/dolittle/studio-terminal/pull/7)
## Summary

Fixes a bug where the `DOLITTLE_IS_PRODUCTION` environment variable was not properly unset in non-production environments.

### Fixed

- The production warning was printed in non-production environments because the environment variable was not properly unset.


# [0.0.4] - 2022-10-24 [PR: #6](https://github.com/dolittle/studio-terminal/pull/6)
## Summary

Adds some description of what this repository is in the `README.md` - and the link to the repository back in the `help` command output.

### Added

- A link to this repository in the `help` command output.


# [0.0.3] - 2022-10-24 [PR: #5](https://github.com/dolittle/studio-terminal/pull/5)
## Summary

Create local Kubernetes setup to help test the functionality of the commands, move the files around a little bit and create some customisations for the MongoDB shell.

### Added

- Local Kubernetes setup to allow testing the same configuration and networking setup.
- Parsing of the `.dolittle/*.json` config files for environment information and resource (MongoDB) connection strings.
- A yellow warning whenever a uses enters the shell in an environment matching `/^prod/I`
- Customisations of the `mongosh` REPL - the `use` command can be used to select the right DB for a resource per tenant, and if you try to. `dropDatabase()` in production - you'll get a warning.


# [0.0.2] - 2022-10-14 [PR: #4](https://github.com/dolittle/studio-terminal/pull/4)
## Summary

Adds a welcome text and a `help` command.
Also adds `curl`, `vim` and `nano`.


# [0.0.1] - 2022-10-12 [PR: #3](https://github.com/dolittle/studio-terminal/pull/3)
## Summary

Fix fix the releases


# [0.0.1] - 2022-10-12 [PR: #2](https://github.com/dolittle/studio-terminal/pull/2)
## Summary

Fixes release workflow to not use the (nonexisting) filter output.


