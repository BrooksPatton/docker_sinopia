FROM node:latest
MAINTAINER Brooks Patton
RUN useradd -d /sinopia -m sinopia
WORKDIR /sinopia
USER sinopia
RUN mkdir storage
RUN npm install sinopia
CMD ["./node_modules/sinopia/bin/sinopia"]
EXPOSE 4873
COPY config.yaml /sinopia
