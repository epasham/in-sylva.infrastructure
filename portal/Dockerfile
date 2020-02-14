# build environment
FROM node:latest as portal

RUN apt-get update && \
    apt-get install -y  git \
    openssh-server

RUN mkdir /var/run/sshd
EXPOSE 22 

ARG SSH_KEY
ARG SSH_KEY_PASSPHRASE
RUN chmod go-w /root

RUN mkdir -p /root/.ssh && \
    chmod 600 /root/.ssh 

RUN echo "$SSH_KEY" >> /root/.ssh/id_rsa && \
    echo "$SSH_KEY_PASSPHRASE" >> /root/.ssh/id_rsa.pub 

RUN chmod -R 600 /root/.ssh/id_rsa && \
    chmod -R 600 /root/.ssh/id_rsa.pub 

RUN ssh-keyscan -Ht rsa forgemia.inra.fr,147.100.164.13 >> ~/.ssh/known_hosts

RUN mkdir /app/ 

WORKDIR /app/

RUN git clone git@forgemia.inra.fr:in-sylva-development/in-sylva.portal.git

RUN cd ./in-sylva.portal && npm install

WORKDIR /app/in-sylva.portal/

ENV PATH /app/in-sylva.portal/node_modules/.bin:$PATH

RUN yarn build

# production environment
FROM nginx:latest

COPY --from=portal /app/in-sylva.portal/build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d

ENV NODE_ENV production
ENV PROCESS_TYPE web
ENV PORT 3000

EXPOSE 3000
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]