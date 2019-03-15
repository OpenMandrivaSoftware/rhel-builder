FROM rosalab/rels7:latest

RUN rm -f /etc/localtime \
 && ln -s /usr/share/zoneinfo/UTC /etc/localtime \
 && yum install -y mock git curl sudo yum-utils rpmdevtools builder-c \
 && sed -i 's!file-store!abf-n-file-store!g' /etc/builder-c/filestore_upload.sh \
 && sed -i 's!openmandriva.org!rosalinux.ru!g' /etc/builder-c/filestore_upload.sh \
 && sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers \
 && echo "%mock ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && adduser omv \
 && usermod -a -G mock omv \
 && rm -rf /var/cache/yum/* \
 && rm -rf /usr/share/man/ /usr/share/cracklib /usr/share/doc

COPY builder.conf /etc/builder-c/
ENTRYPOINT ["/usr/bin/builder"]
