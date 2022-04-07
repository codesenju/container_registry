FROM openresty/openresty:alpine-fat
 
RUN mkdir /var/log/nginx
 
RUN apk add --no-cache openssl-dev
RUN apk add --no-cache git
RUN apk add --no-cache gcc
RUN luarocks install lua-resty-openidc
RUN luarocks install lua-resty-jwt
RUN luarocks install lua-resty-http
RUN luarocks install lua-resty-session
ENTRYPOINT ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]
EXPOSE 80