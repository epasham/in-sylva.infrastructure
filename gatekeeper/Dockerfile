FROM node:latest

RUN apt-get update && \
    apt-get install -y  git \
    openssh-server

RUN mkdir /var/run/sshd
EXPOSE 22 

ARG SSH_KEY
ARG SSH_KEY_PASSPHRASE
RUN chmod go-w /root
# 1. Create the SSH directory.
# 2. Set the required permissions.
RUN mkdir -p /root/.ssh && \
    chmod 600 /root/.ssh 

# 1. Populate the private key file.
# 2. Set the required permissions.
RUN echo "$SSH_KEY" >> /root/.ssh/id_rsa && \
    echo "$SSH_KEY_PASSPHRASE" >> /root/.ssh/id_rsa.pub 

RUN chmod -R 600 /root/.ssh/id_rsa && \
    chmod -R 600 /root/.ssh/id_rsa.pub 

# 1. Add github to our list of known hosts for ssh.
RUN ssh-keyscan -Ht rsa forgemia.inra.fr,147.100.164.13 >> ~/.ssh/known_hosts

RUN mkdir /home/app/ 

WORKDIR /home/app/

RUN git clone git@forgemia.inra.fr:in-sylva-development/in-sylva.gatekeeper.git

RUN cd ./in-sylva.gatekeeper && npm install

ENV NODE_ENV production
ENV PROCESS_TYPE web
ENV PORT 3000

EXPOSE 5000


CMD ["npm", "run", "start:prod"]