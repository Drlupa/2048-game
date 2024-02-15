FROM node:16 as build

WORKDIR /app

COPY 2048-game/package.json .

RUN npm install --include=dev 

COPY 2048-game/ .

RUN npm run build

FROM nginx:1.25.3-alpine

WORKDIR /app

COPY --from=build /app /app 

COPY default /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off;"]
