FROM raspbian/stretch

RUN apt-get update 
RUN apt-get install -yq libraspberrypi-bin
RUN apt-get install -y libatomic1
RUN wget https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-armv7l.tar.xz
RUN tar -xf node-v12.18.3-linux-armv7l.tar.xz
# have the && because cd wont follow you on the next RUN command. Each command executed in separate bash
RUN cd node-v12.18.3-linux-armv7l/ \
    && chown -R $(whoami) /usr/local/bin \
    && cp -R * /usr/local/

RUN echo SUBSYSTEM=="vchiq",MODE="0666" > /etc/udev/rules.d/99-camera.rules

RUN echo "export PATH=/opt/vc/bin:${PATH}" >> /root/.bashrc

# Create app directory
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 8080

CMD [ "node", "server.js" ]