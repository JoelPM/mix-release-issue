FROM elixir:1.10.3-alpine

ARG USER=ex
ENV HOME /home/$USER

# A basic set of tools
RUN apk update && \
    apk add \
        bash \
        build-base \
        curl \
        git \
        mc \
        neovim \
        openssh \
        pcre \
        pcre-dev \
        perl \
        python3 \
        py3-crcmod \
        sudo \
        tar \
        tmux \
        tree \
        zsh 

# Thrift
RUN wget -qO- http://mirrors.ibiblio.org/apache/thrift/0.13.0/thrift-0.13.0.tar.gz | tar xvzf - && \
    cd thrift-0.13.0 && ./configure && make && make install && \
    cd ../ && rm -fr thrift-0.13.0

# Helm...
RUN wget -qO- https://get.helm.sh/helm-v2.15.2-linux-amd64.tar.gz | tar Oxvzf - linux-amd64/helm > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# add new user
RUN adduser -D --home /home/ex --shell /bin/bash --uid 1000 $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME

# gcloud
RUN curl https://sdk.cloud.google.com | bash
RUN ~/google-cloud-sdk/bin/gcloud components update

RUN echo "source /home/ex/google-cloud-sdk/path.bash.inc" >> /home/ex/.bashrc && \
    echo "source /home/ex/google-cloud-sdk/path.bash.inc" >> /home/ex/.bashrc

# Setup local mix and rebar
RUN mix local.hex --force && mix local.rebar --force


ENTRYPOINT ["/bin/bash"]
