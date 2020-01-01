# Create the container from the alpine linux image
FROM alpine:3.7

# Add nginx and nodejs
RUN apk add --update nginx nodejs \
    && mkdir -p /tmp/nginx/vue-element-admin \
    && mkdir -p /var/log/nginx \
    && mkdir -p /var/www/html

COPY nginx_config/nginx.conf /etc/nginx/nginx.conf
COPY nginx_config/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /tmp/nginx/vue-element-admin
COPY . .

RUN npm install --save && npm run build:prod

RUN cp -r dist/* /var/www/html \
    && chown nginx:nginx /var/www/html \
    && rm -rf node_modules

CMD ["nginx", "-g", "daemon off;"]
