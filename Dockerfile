FROM rockylinux:9.2

RUN dnf -y upgrade; \
    dnf install -y \
        nginx \
        https://extras.getpagespeed.com/release-latest.rpm; \
    dnf install -y nginx-module-aws-auth

RUN dnf clean all; \
    find /usr/bin -regextype posix-egrep -regex '.*((yum)|(dnf)).*' -delete

ENV LUA_PATH=/etc/nginx/lib/lua/?.lua;;

USER nginx
WORKDIR /etc/nginx

EXPOSE 80
EXPOSE 443
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]