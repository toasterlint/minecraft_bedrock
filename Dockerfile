FROM ubuntu:20.04
ARG BDS_Version=latest

ENV VERSION=$BDS_Version

# Install dependencies
RUN apt-get update && \
    apt-get install -y unzip curl libcurl4 libssl1.1 && \
    rm -rf /var/lib/apt/lists/*

# Download and extract the bedrock server
RUN if [ "$VERSION" = "latest" ] ; then \
        LATEST_VERSION=$( \
            curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:105.0) Gecko/20100101 Firefox/105.0" -v --silent -L https://www.minecraft.net/en-us/download/server/bedrock/ 2>&1 | \
            grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' | \
            sed 's#.*/bedrock-server-##' | sed 's/.zip//') && \
        export VERSION=$LATEST_VERSION && \
        echo "Setting VERSION to $LATEST_VERSION" ; \
    else echo "Using VERSION of $VERSION"; \
    fi && \
    curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:105.0) Gecko/20100101 Firefox/105.0" https://minecraft.azureedge.net/bin-linux/bedrock-server-${VERSION}.zip --output bedrock-server.zip && \
    cat bedrock-server.zip && \
    unzip bedrock-server.zip -d bedrock-server && \
    chmod +x bedrock-server/bedrock_server && \
    rm bedrock-server.zip

# Create a separate folder for configurations move the original files there and create links for the files
RUN mkdir /bedrock-server/config && \
    mv /bedrock-server/server.properties /bedrock-server/config && \
    mv /bedrock-server/permissions.json /bedrock-server/config && \
    mv /bedrock-server/whitelist.json /bedrock-server/config && \
    ln -s /bedrock-server/config/server.properties /bedrock-server/server.properties && \
    ln -s /bedrock-server/config/permissions.json /bedrock-server/permissions.json && \
    ln -s /bedrock-server/config/whitelist.json /bedrock-server/whitelist.json

EXPOSE 19132/udp

VOLUME /bedrock-server/worlds /bedrock-server/config

WORKDIR /bedrock-server
ENV LD_LIBRARY_PATH=.
CMD ./bedrock_server
