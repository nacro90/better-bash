# Better Bash

My custom bash configuration that I find it worth to share.

## Features

 - Vibrant colors with symbolic unicode sugar, minimal footprint and time

   ![Minimal start](README.assets/start.png)

 - Git support

   ![Current working directory has a clean git repo](README.assets/git-clean.png)

   ![Current working directory has a modified git repo](README.assets/git-modif.png)

 - Background jobs indicator

   ![Background job support](README.assets/jobs.png)

 - Virtual environment support

   ![Virtual environment support](README.assets/venv.png)

 - Return value indicator

   ![Return value support](README.assets/return.png)

 - Custom PS2

   ![Custom PS2](README.assets/ps2.png)

 - Empty directory

   ![Current working directory is empty](README.assets/empty.png)

 - Custom `ls` colors

   ![Custom ls colors](README.assets/ls.png)

## Installation

For fresh install run:

```sh
mkdir ~/.betterbash
cd ~/.betterbash
git clone https://github.com/orcantiryaki/better-bash.git
./install
```

Your existing `.bashrc` and `.bash_aliases` files will be backed up to `.bashrc.bak`
and `.bash_aliases.bak`.
