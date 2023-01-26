# Generate build artifacts
FROM node:16-slim as build

WORKDIR /app

COPY ./calculator/package*.json ./
RUN npm install

COPY ./calculator .
RUN npm run build