# Generate build artifacts
FROM node:16-slim as build

WORKDIR /app

COPY ./package*.json ./
RUN npm install

COPY . .
RUN npm run build


# Serve build files
FROM nginx:latest

COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/

RUN chgrp -R root /var/cache/nginx /run /var/log/nginx && \
    chmod -R 770 /var/cache/nginx /run /var/log/nginx

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]