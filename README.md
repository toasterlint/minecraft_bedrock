# minecraft_bedrock

Docker image to run the official Minecraft Bedrock server.  Run via:

docker run --name minecraft -it -d -p 19132:19132 -p 19132:19132/udp -v /your/local/dir:/data rthilton/minecraft_bedrock:latest

If using a volume and once deployed, the server.properties, permissions.json, etc files can be modified to your liking and then the server restarted.
