## base image
FROM node:11.12.0-alpine

## set working directory
WORKDIR /usr/src/app

## add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

## install and cache app dependencies
COPY package.json /usr/src/app/package.json
COPY package-lock.json /usr/src/app/package-lock.json
RUN npm install react-scripts@3.0.1 -g --silent
RUN chown -R node:node .
USER node
RUN npm ci

## start app
CMD ["npm", "start"]
