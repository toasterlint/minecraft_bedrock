# minecraft_bedrock

Docker image to run the official Minecraft Bedrock server.  Run via:

docker run --name minecraft -it -d -p 19132:19132 -p 19132:19132/udp -v /your/local/dir:/data toasterlint/minecraft_bedrock:latest
