# DevCon

Development containers, based on Arch btw

## Contents

### Dockerfile

- Base packages
- Docker binary so we can access the host's Docker
- Create a user with sudo privilege
- Add dotfiles
- Install some rubies and nodes
- CMD runs in perpetuity

### dotfiles

Copied from my macos dotfiles and adapted, mainly by removing the brew stuff and fixing the nvm path.

### Scripts

- `make` (re)builds the container, sets volumes (including host Docker socket) and ports
- `start` starts. Not very useful by itself because it's called by the others
- `console` starts an interactive console

In the DeeCide version `console` accepts a directory as argument and I have an alias:

    alias ig_console='(CURRENT_DIR=$(basename $(pwd)); cd ~/dev/_devcon/deecide && ./console "/home/jole/dev/$CURRENT_DIR")'

so if I am in `~/dev/deecide/paul` on macos, `ig_console` will take me inside the container in `/home/jole/dev/paul`.

### docker-compose

Used for accessories shared across dev environments.

I made a custom MongoDB Dockerfile a while back and I'm not sur why. I think I wanted a lightweight image on ARM and it didn't exist.

I know I could add the devcons here but I like my scripts 🤷🏻‍♂️

## Usage

Once you've adapted stuff :)

### Create and start the accessories

    docker compose create
    docker compose start
    docker network list

The network name depends on the current dir or the name given in docker-compose.yml. Make sure you have the right one in `make`.

### Build and start the container

    ./make
    ./console

### Tips

- For Ruby projects, it's a good idea to save the bundle locally, so if you rebuild the container the gems are not lost. `bundle config set --local path 'vendor/bundle'
`
- Kamal does not follow .ssh/config when it comes to remote builders. I had to add
      eval $(ssh-agent -s) > /dev/null
      ssh-add ~/dev/keys/build.pem 2>/dev/null
  to zshrc
