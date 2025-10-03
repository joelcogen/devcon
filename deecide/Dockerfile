FROM ogarcia/archlinux:devel

##### PACMAN

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm zsh git vim rbenv libyaml postgresql-libs openssh lsof
RUN pacman -Scc --noconfirm

##### Manual install: Mongotools, traefik

RUN curl -O https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-arm64-100.13.0.tgz && \
    tar -xzvf mongodb-database-tools-ubuntu2204-arm64-100.13.0.tgz && \
    cp mongodb-database-tools-ubuntu2204-arm64-100.13.0/bin/* /usr/local/bin/ && \
    rm -rf mongodb-database-tools-*

RUN curl -L https://github.com/traefik/traefik/releases/download/v2.11.0/traefik_v2.11.0_linux_arm64.tar.gz -o traefik.tar.gz && \
    tar -xzvf traefik.tar.gz && \
    mv traefik /usr/local/bin/ && \
    rm traefik.tar.gz

##### Create user

RUN useradd -m -s /bin/zsh jole
RUN usermod -aG wheel jole && \
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

##### Copy dotfiles

COPY dotfiles /home/jole/dotfiles
RUN chown -R jole:jole /home/jole

##### Switch to user

USER jole
WORKDIR /home/jole

##### OhMyZSH, Ruby build, NVM

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

##### Link dotfiles

RUN ln -sf /home/jole/dotfiles/zshrc /home/jole/.zshrc
RUN ln -sf /home/jole/dotfiles/joelcogen.zsh-theme /home/jole/.oh-my-zsh/themes/
RUN ln -sf /home/jole/dotfiles/gitconfig /home/jole/.gitconfig

##### Install rubies and nodes

RUN rbenv install 3.4.4
RUN rbenv install 3.1.2
RUN rbenv install 2.7.6
RUN /bin/bash -c "source ~/.nvm/nvm.sh && nvm install 20.16.0 && npm install -g yarn"
RUN /bin/bash -c "source ~/.nvm/nvm.sh && nvm install 18.17.0 && npm install -g yarn"
RUN /bin/bash -c "source ~/.nvm/nvm.sh && nvm install 18.18 && npm install -g yarn"

##### Opts

CMD ["tail", "-f", "/dev/null"]

