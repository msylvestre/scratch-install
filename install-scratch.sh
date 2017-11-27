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
sudo apt-get install curl unzip git


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Node 4.x ++++"
echo "---------------------------------------------------------------------------------------------"

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
nvm install v6


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
sudo apt-get install sublime-text

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
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
sudo apt-get update

# 4. Install Spotify
sudo apt-get install spotify-client



echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Remote Desktop ++++"
echo "---------------------------------------------------------------------------------------------"

sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt-get update
sudo apt-get install remmina remmina-plugin-rdp libfreerdp-plugins-standard



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

sudo apt-get install alien
sudo alien -k skypeforlinux-64.rpm
sudo dpkg -i skypeforlinux-64.deb


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Docker ++++"
echo "---------------------------------------------------------------------------------------------"

wget -qO- https://get.docker.com/ | sh
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
sudo apt-get install heroku


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Cucumber Dev environment ++++"
echo "---------------------------------------------------------------------------------------------"

# Other dependencies for RUBY if things go wrong...
# HINT : Make sure 'apt-get update' don't have any error, otherwise you won't be able to run rvm command successfully (and not even compile ruby 1.9.3)

#sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev


# Other dependencies for RVM if things go wrong...
#sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev

# Get the key (aka licence)
sudo apt-get install gnupg2
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -

# Install RVM
curl -sSL https://get.rvm.io | bash -s stable

# Load the "environement info"
source ~/.rvm/scripts/rvm

# Install openssl package before installing Ruby in order to compile it with openssl
rvm pkg install openssl

# Install Ruby w/ openssl
rvm install 1.9.3-p551 --with-openssl-dir=$HOME/.rvm/usr

# Install the "ruby developer library"
sudo apt-get install ruby-dev

# Update gem and then install bundler (to use 'bundle install' in ruby app to install the dependencies)
sudo gem update --system
sudo gem install bundler

# Install Cucumber
apt-get install cucumber

# Install Chrome Driver
cd ~/wget-download
wget -N http://chromedriver.storage.googleapis.com/2.21/chromedriver_linux64.zip
unzip chromedriver_linux64.zip -d ~/wget-download/chromedriver

# Make Chrome Driver executable for anybody and move it to /usr/local/share/
cd ~/wget-download/chromedriver
chmod +x chromedriver
sudo cp ~/wget-download/chromedriver/chromedriver /usr/local/share/chromedriver

# Create symlink for chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

# Create the Root of the Git Repositories (~/geek)
cd ~/
if [ ! -d ~/geek ]   # Or use quote and $HOME like if [ -d "$HOME/geek" ] cause you can't use sometihng like "~/geek" because of the quote (")
then
	echo ">> ~/geek directory don't exist, let's create it..."
	mkdir ~/geek
	cd ~/geek
else
	echo ">> ~/geek exist, moving in..."
	cd ~/geek
fi

# Clone the repo
git clone https://github.com/venzee/qa.git

# Setup the OS config file
cd ~/geek/qa
cp ci_os.json.template ci_os.json

# Install gem for Cucumber and test it
cd ~/geek/qa/cucumber
bundle install
bundle exec cucumber -t @qa


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Venzee Front-End Dev environment ++++"
echo "---------------------------------------------------------------------------------------------"

sudo apt-get update

# Install Front-End Dependencies inclusing Python
sudo apt-get install gcc g++ pkg-config git graphicsmagick imagemagick libjpeg-dev phantomjs libcairo2-dev python-pip

# Install AWS Command-Line Interface (to deploy easily to S3 bucket)
sudo pip install awscli

# Install node 0.10.36 and npm
cd ~/geek
git clone git://github.com/joyent/node.git
cd node
git checkout tags/v0.10.36
./configure
sudo make install
cd ~/geek
git clone git://github.com/isaacs/npm.git
cd npm
sudo make install

# Install Ruby dependencies
sudo gem install sass

# Install npm package dependencies
sudo npm install -g bower
sudo npm install -g grunt-cli
sudo npm install -g jshint

# Clone the repo
cd ~/geek
git clone https://github.com/venzee/venzee.com.git
#git clone git@github.com:venzee/venzee.com.git
cd venzee.com
sudo npm install
grunt dev

# Add venzee.dev to host file - not sure if it's needed 
# Do '$ subl /etc/hosts' and add '127.0.0.1 venzee.dev'


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Terminator Console ++++"
echo "---------------------------------------------------------------------------------------------"

sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator

# Check apt-get- update after installing Terminator, you may need 
# to clean /etc/apt/sources.list.d/gnome-terminator-ubuntu-ppa-vivid.list and
# /etc/apt/sources.list.d/gnome-terminator-ubuntu-ppa-vivid.list.save if invalid url are introduced


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



echo "---------------------------------------------------------------------------------------------"
echo "++++ Fix audio issue on XPS 13 ++++"
echo "---------------------------------------------------------------------------------------------"

sudo apt-get purge pulseaudio pulseaudio-equalizer
sudo apt-get install pulseaudio
sudo apt-get install pulseaudio-equalizer



echo "============================================================================================"
echo "|                            MAIN INSTALL SCRIPT - THE END !!!                             |"
echo "============================================================================================"
