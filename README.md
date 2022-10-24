# Studio Terminal

This repository contains the source for the [dolittle/shell Docker Image](https://hub.docker.com/r/dolittle/shell).
A TTY-server built using [ttyd](https://github.com/tsl0922/ttyd), with some Dolittle-special customisations of commands
and tools to make the shell useful for customers of Dolittle using [Dolittle Studio](https://dolittle.studio).

The bash-shell that is exposed to users with access comes with these tools installed:

 - The __Dolittle CLI__: https://dolittle.io/docs/reference/cli/
 - The __MongoDB Shell__: https://www.mongodb.com/docs/mongodb-shell/ (with some Dolittle customisations)
 - __curl__
 - __vim__ and __nano__
 - __jq__: https://stedolan.github.io/jq/manual/

and a few more built-in tools.

If you would like to see support for other tools or commands, please feel free to create an issue - or even better, a PR -
in this repository. Thanks!
