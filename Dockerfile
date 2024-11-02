FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive

# configure ssh and git
# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-get update && apt-get install -y software-properties-common git openssh-server curl
EXPOSE 22
COPY ./authorized_keys ./.ssh/authorized_keys
COPY ./sshd_config /etc/ssh/sshd_config
RUN chmod 600 .ssh
COPY ./init.sh ./init.sh
RUN chmod +x ./init.sh

# configure sdk man
RUN apt install zip unzip -y
RUN curl -s "https://get.sdkman.io" | bash
RUN sdk version;sleep 5



ENTRYPOINT ["/root/init.sh"]
