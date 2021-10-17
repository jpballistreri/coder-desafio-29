FROM keymetrics/pm2:latest-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
RUN apk add --update nodejs npm

RUN npm i pm2 -g

RUN npm install
RUN pm2 init
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

RUN npm run transpile

VOLUME /usr/src/app


#CMD ["npm","run","prod","&& tail -f /dev/null"]

CMD pm2-docker start ecosystem.config.js

EXPOSE 8080

#CMD pm2 start process.yml && tail -f /dev/null
