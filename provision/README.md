
# Sequel Pro

FIRST:

   $ vagrant ssh
   $ ssh vagrant@tapioca.dev

if already use, remove key from `~/.ssh/known_hosts`

then use

name: Tapioca DEV
mySQL host: 127.0.0.1
username: vagrant
password: vagrant
sshHost: tapioca.dev
ssh user: vagrant
ssh key: .vagrant/machines/default/virtualbox/private_key

# Test Mongo

    $ mongo
    $ use sandbox
    $ db.stuff.insert( { item: "card", qty: 15 } )

