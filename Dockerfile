FROM alpine:edge
MAINTAINER leo.lou@gov.bc.ca

RUN apk update \
  && apk add alpine-sdk nodejs python libffi libffi-dev \
  && git config --global url.https://github.com/.insteadOf git://github.com/ 

RUN mkdir -p /app
    
WORKDIR /app
ADD . /app
RUN npm install

RUN adduser -S app
RUN chown -R app:0 /app && chmod -R 770 /app
RUN apk del --purge alpine-sdk python libffi libffi-dev  

USER app
EXPOSE 3000
CMD node server.js --configPath=config.json
