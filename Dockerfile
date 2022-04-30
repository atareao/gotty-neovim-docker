FROM alpine:edge

ENV TZ=Europe/Madrid
ENV PS1 "\n\n> \W \$ "
ENV TERM=linux

ENV GOTTY_VERSION 1.0.1

RUN apk add --update \
            --no-cache \
            tini \
            bash  \
            tzdata \
            font-jetbrains-mono-nerd \
            neovim \
            git \
            gzip \
            wget \
            python3 \
            py3-pip \
            npm \
            nodejs \
            gcc \
            musl-dev \
            build-base \
            curl \
            && \
    rm -rf /var/cache/apk && \
    addgroup -g 1000 -S dockerus && \
    adduser -u 1000 -S dockerus -G dockerus -h /home -s bash && \
    mkdir /app

ADD https://github.com/yudai/gotty/releases/download/v${GOTTY_VERSION}/gotty_linux_386.tar.gz /tmp/

RUN tar xvzf /tmp/gotty_linux_386.tar.gz -C /app && \
    rm -rf /tmp/gotty_linux_386.tar.gz

COPY ./gotty /home/.gotty
COPY ./config /home/.config
COPY ./start.sh /app/
RUN chown -R dockerus:dockerus /app /home
USER dockerus
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

WORKDIR /home
RUN python3 -m pip install --user neovim
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

ENTRYPOINT ["tini", "--"]
CMD ["/bin/bash", "/app/start.sh"]

