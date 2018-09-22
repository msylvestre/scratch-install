#!/bin/bash
echo "============================================================================================"
echo "|                                  MAIN INSTALL SCRIPT                                     |"
echo "============================================================================================"

# TODO
# ----------------------------------------------------------------------------------
# - Add all the PPA at the beginning of the script and do one 'sudo apt-get update'
# - Use Chrominum instead of Google Chrome since it's opensource and part of a PPA
# - Get Node pre-compiled here : http://www.ubuntuupdates.org/ppa/chris_lea_nodejs



echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Basic Dependencies ++++"
echo "---------------------------------------------------------------------------------------------"

# Create a directory for 'wget'
mkdir ~/wget-download
cd ~/wget-download

# Always start by updating apt-get
sudo apt-get update

# Basic tools
sudo apt-get install -y curl unzip git gcc g++ \
     software-properties-common build-essential libtool \
     apt-transport-https ca-certificates \
     gnupg2 
     



echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Node 8.12 (LTS as of sep-18) ++++"
echo "---------------------------------------------------------------------------------------------"

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
nvm install v8


echo "---------------------------------------------------------------------------------------------"
echo "++++ Update Npm ++++"
echo "---------------------------------------------------------------------------------------------"

npm install npm@latest -g


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Chrome ++++"
echo "---------------------------------------------------------------------------------------------"

cd ~/wget-download
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome*.deb
sudo apt-get install -f



echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Sublime ++++"
echo "---------------------------------------------------------------------------------------------"

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text

echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Postgres & PG Admin ++++"
echo "---------------------------------------------------------------------------------------------"

sudo apt-get install -y postgresql postgresql-contrib
sudo apt-get install -y pgadmin3 

# Basic Server Setup
# To start off, we need to set the password of the PostgreSQL user (role) called \"postgres\"; we will not be able to access the server externally otherwise. As the local “postgres” Linux user, we are allowed to connect and manipulate the server using the psql command.

# In a terminal, type:

sudo -u postgres psql postgres

# this connects as a role with same name as the local user, i.e. \"postgres\", to the database called \"postgres\" (1st argument to psql).
# Set a password for the \"postgres\" database role using the command:

\password postgres
# and give your password when prompted. The password text will be hidden from the console for security purposes.
# Type Control+D or \q to exit the posgreSQL prompt.

# Create database
# To create the first database, which we will call \"mydb\", simply type:

sudo -u postgres createdb mydb
 


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Spotify ++++"
echo "---------------------------------------------------------------------------------------------"

# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
sudo apt-get update

# 4. Install Spotify
sudo apt-get install -y spotify-client



echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Remote Desktop ++++"
echo "---------------------------------------------------------------------------------------------"

sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt-get update
sudo apt-get install -y remmina remmina-plugin-rdp libfreerdp-plugins-standard



echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Google Drive (aka OverGrive) ++++"
echo "---------------------------------------------------------------------------------------------"

cd ~/wget-download
wget https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive_3.1.2_all.deb
sudo apt-get install gdebi gdebi-core gir1.2-vte-2.90
sudo gdebi overgrive_3.1.2_all.deb


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Dropbox ++++"
echo "---------------------------------------------------------------------------------------------"

sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo apt-get update
sudo apt-get install nautilus-dropbox


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Zoom ++++"
echo "---------------------------------------------------------------------------------------------"

cd ~/wget-download
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get install libxcb-xtest0
sudo dpkg -i zoom_amd64.deb
sudo apt-get -f install


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Skype ++++"
echo "---------------------------------------------------------------------------------------------"

# Download the .rpm package on skype.com

curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
echo "deb https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list
sudo apt update
sudo apt install skypeforlinux


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Docker ++++"
echo "---------------------------------------------------------------------------------------------"

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

sudo apt update
sudo apt install docker-ce

sudo usermod -aG docker fuel
# Need a re-login to use docker withoout sudo :)

echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Virtual Box ++++"
echo "---------------------------------------------------------------------------------------------"

sudo apt-get install virtualbox 


echo "---------------------------------------------------------------------------------------------"
echo "++++ Heroku Dev environment ++++"
echo "---------------------------------------------------------------------------------------------"

sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y heroku


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Terminator Console ++++"
echo "---------------------------------------------------------------------------------------------"

sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get -y install terminator


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install AWS CLI & AWS EB CLI ++++"
echo "---------------------------------------------------------------------------------------------"

# Install PIP
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

#Install AWS CLI
sudo pip install awscli --upgrade

#Install EB
sudo pip install awsebcli --upgrade

echo "---------------------------------------------------------------------------------------------"
echo "++++ Create and install ssh key for Git ++++"
echo "---------------------------------------------------------------------------------------------"

ssh-keygen -t rsa -b 4096 -C "marco@venzee.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub

echo "Copy the ssh key store in your clipboard to your git account to enable git wo/ login"
echo "run '$ ssh -T git@github.com' to validate the key installation"
echo "You can run 'xclip -sel clip < ~/.ssh/id_rsa.pub' to re-copy the key to your clipboard" 





echo "============================================================================================"
echo "|                            MAIN INSTALL SCRIPT - THE END !!!                             |"
echo "============================================================================================"
