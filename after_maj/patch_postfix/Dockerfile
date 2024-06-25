From alpine:latest

# update
RUN RUN apt-get update

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# copy .kube/config
RUN mkdir.kube
# COPY .kube/config .kube/

# modify /etc/hosts
# RUN echo "<IP> <FQDN>" >> /etc/hosts

# test
#RUN kubectl -n cryptobox ge pod
