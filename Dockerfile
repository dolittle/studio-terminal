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

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libicu66 \
        jq \
        lynx \
    && rm -rf /var/lib/apt/lists/*

RUN useradd studio \
    --user-group \
    --create-home --home-dir /home/studio \
    --shell /usr/bin/bash

COPY 100-dolittle-runtime-address.sh /etc/profile.d/100-dolittle-runtime-address.sh
COPY 101-mongosh-no-connect.sh /etc/profile.d/101-mongosh-no-connect.sh

COPY .bash_profile /home/studio/.bash_profile
COPY .mongoshrc.js /home/studio/.mongoshrc.js

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["ttyd", "su", "--whitelist-environment=DOLITTLE_MICROSERVICE,DOLITTLE_RUNTIME_ADDRESS,DOLITTLE_MONGODB_ADDRESS", "-", "studio"]
