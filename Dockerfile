FROM node:lts-alpine as builder

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN yarn install --frozen-lockfile

COPY ./public ./public
COPY ./src ./src

RUN yarn run build 

FROM nginx:1.19-alpine
COPY --from=builder /app/build/ /usr/share/nginx/html