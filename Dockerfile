FROM ogarcia/archlinux:devel

##### PACMAN

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm zsh git vim rbenv libyaml openssh lsof python docker-buildx
RUN pacman -Scc --noconfirm

##### Create user

RUN useradd -m -s /bin/zsh jole
RUN usermod -aG wheel jole && \
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

##### Copy dotfiles

COPY dotfiles /home/jole/dotfiles
RUN chown -R jole:jole /home/jole

##### Docker binary and permission

RUN curl -fsSL https://download.docker.com/linux/static/stable/aarch64/docker-28.4.0.tgz -o docker.tgz && \
    tar -xzf docker.tgz --strip-components=1 -C /usr/local/bin docker/docker && \
    rm docker.tgz
RUN usermod -aG root jole

##### Switch to user

USER jole
WORKDIR /home/jole

##### OhMyZSH, Ruby build, NVM

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

##### Link dotfiles

RUN ln -sf /home/jole/dotfiles/zshrc /home/jole/.zshrc
RUN ln -sf /home/jole/dotfiles/joelcogen.zsh-theme /home/jole/.oh-my-zsh/themes/
RUN ln -sf /home/jole/dotfiles/gitconfig /home/jole/.gitconfig

##### Install rubies and nodes

RUN rbenv install 3.4.6
RUN /bin/bash -c "source ~/.nvm/nvm.sh && nvm install 24 && npm install -g yarn"

RUN rbenv global 3.4.6
RUN eval "$(rbenv init -)" && gem install kamal

##### Opts

CMD ["tail", "-f", "/dev/null"]

