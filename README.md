install node in raspbian image
# RUN apt-get update
# RUN apt-get install -y libatomic1
# RUN wget https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-armv7l.tar.xz
# RUN tar -xf node-v12.18.3-linux-armv7l.tar.xz
# # have the && because cd wont follow you on the next RUN command. Each command executed in separate bash
# RUN cd node-v12.18.3-linux-armv7l/ \
#     && chown -R $(whoami) /usr/local/bin \
#     && cp -R * /usr/local/

build on pi
docker build -t riot1 riot1/

run on pi
docker run --device /dev/vchiq --device=/dev/vcsm -v /opt/vc:/opt/vc --env LD_LIBRARY_PATH=/opt/vc/lib --name riot1 -d -p 8081:8080 riot1