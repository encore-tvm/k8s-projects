FROM node:alpine
WORKDIR /app
ADD . .
RUN npm install
RUN npm install express
CMD node index.js
