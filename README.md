# DevCon

Development containers, based on Arch btw

## Dockerfile

- Base packages
- Create a user with sudo privilege
- Add dotfiles
- Install some rubies and nodes
- CMD runs in perpetuity

## dotfiles

Copied from my macos dotfiles and adapted, mainly by removing the brew stuff and fixing the nvm path.

## Scripts

`make` (re)builds the container
`start` starts. Not very useful by itself because it's called by the others
`console` starts an interactive console

In the DeeCide version `console` accepts a directory as argument and I have an alias:

    alias ig_console='(CURRENT_DIR=$(basename $(pwd)); cd ~/dev/_devcon/deecide && ./console "/home/jole/dev/$CURRENT_DIR")'

so if I am in `~/dev/deecide/paul` on macos, `ig_console` will take me inside the container in `/home/jole/dev/paul`.

## docker-compose

Used for accessories shared across dev environments.

I know I could add the devcons here but I like my scripts 🤷🏻‍♂️

