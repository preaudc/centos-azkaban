# podman build --tag centos:azkaban -f ./Containerfile
# podman run -dit -p 8081:8081 --rm centos:azkaban
# podman run -p 8081:8081 --rm centos:azkaban
FROM docker.io/library/centos:latest
RUN dnf -y --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos
RUN dnf -y distro-sync
RUN dnf -y install jq python3-pyyaml python3-requests java-devel openssh-clients openssh-server iproute logrotate vim zip python3 libyaml tree unzip passwd
RUN dnf clean all
RUN useradd azkaban
ADD azkaban-solo-server.tar.gz /home/azkaban
COPY shutdown-solo.sh /home/azkaban/shutdown-solo.sh
COPY start-solo.sh /home/azkaban/start-solo.sh
RUN chown -R azkaban: /home/azkaban
RUN chmod +x /home/azkaban/start-solo.sh
RUN chmod +x /home/azkaban/shutdown-solo.sh
EXPOSE 8081
USER azkaban
ENTRYPOINT /home/azkaban/start-solo.sh
