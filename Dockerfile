FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        tini \
        wget \
        gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn apt-key add - \
    && echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-6.0.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        mongodb-mongosh \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/tsl0922/ttyd/releases/download/1.7.1/ttyd.x86_64 /usr/bin/ttyd
RUN chmod u+rx /usr/bin/ttyd

ADD https://github.com/dolittle/Runtime/releases/latest/download/dolittle-linux-x64 /usr/bin/dolittle
RUN chmod a+rx /usr/bin/dolittle

RUN wget -qO /bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
RUN chmod a+rx /bin/yq
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libicu66 \
        jq \
        lynx \
        curl \
        vim \
        nano \
    && rm -rf /var/lib/apt/lists/*

RUN useradd studio \
    --user-group \
    --create-home --home-dir /home/studio \
    --shell /usr/bin/bash

COPY Source/Configuration/parse-microservice-config.sh /etc/profile.d/100-parse-microservice-configuration.sh

COPY Source/Bash/production-warning.sh /etc/profile.d/200-production-warning.sh
COPY Source/Bash/info.sh /etc/profile.d/201-info.sh
COPY Source/Bash/help.sh /etc/profile.d/202-help.sh

COPY Source/CLI/runtime-address-override.sh /etc/profile.d/300-runtime-address-override.sh

COPY Source/MongoDB/mongosh-connect-override.sh /etc/profile.d/400-mongosh-connect-override.sh
COPY Source/MongoDB/api.js /etc/mongosh/api.js
COPY Source/MongoDB/TenantDatabases.js /etc/mongosh/TenantDatabases.js

COPY Source/Bash/.bash_profile /home/studio/.bash_profile
COPY Source/MongoDB/.mongoshrc.js /home/studio/.mongoshrc.js

RUN mkdir /home/studio/.dolittle
RUN chmod a+rwx /home/studio/.dolittle/

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["ttyd", "su", "-", "studio"]
