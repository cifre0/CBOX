FROM ubuntu:latest

USER root

# update and install package
RUN apt-get update
RUN apt-get install -y curl

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# copy .kube/config
RUN mkdir /root/.kube
ADD $HOME/.kube/config /root/.kube/config

# patch_postfix
#RUN kubectl -n cryptobox patch cm postfix-conf --type merge -p '{"data":{"main.cf":"smtpd_banner = cryptobox.com\nbiff = no\nappend_dot_mydomain = no\nmyhostname = mail.cryptobox.com\nalias_maps = hash:/etc/aliases\nalias_database = hash:/etc/aliases\nmyorigin = cryptobox.com\nmailbox_size_limit = 0\nrecipient_delimiter = +\ninet_interfaces = all\nsmtpd_use_tls = yes\nsmtpd_sasl_local_domain =\nsmtpd_sasl_auth_enable = yes\nsmtpd_sasl_security_options = noanonymous\nbroken_sasl_auth_clients = yes\nsmtpd_recipient_restrictions = permit_sasl_authenticated,permit_mynetworks,reject_unauth_destination\nsmtpd_tls_key_file = /etc/postfix/ssl/smtpd.key \nsmtpd_tls_cert_file = /etc/postfix/ssl/smtpd.crt\nsmtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd\n\nrelayhost = ssl0.ovh.net:465\nsmtp_sasl_auth_enable = yes\nsmtp_sasl_security_options = \nsmtp_use_tls = no\nsmtp_tls_security_level = encrypt\nsmtp_tls_note_starttls_offer = yes\nsmtp_tls_wrappermode = yes\n"}}'
#RUN kubectl -n cryptobox delete $(pod kubectl get pod -n cryptobox | grep postfix | awk -F' ' '{print $1}')


# modify /etc/hosts
#RUN echo '172.26.30.160 rke.rpi.ercom.training' >> /etc/hosts
