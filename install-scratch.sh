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
echo "++++ Install Chrome ++++"
echo "---------------------------------------------------------------------------------------------"

cd ~/wget-download
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome*.deb
sudo apt-get install -f


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Sublime ++++"
echo "---------------------------------------------------------------------------------------------"

sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text


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
wget https://zoom.us/client/latest/ZoomInstaller_i386.deb
sudo dpkg -i Zoom*.deb
sudo apt-get -f install


echo "---------------------------------------------------------------------------------------------"
echo "++++ Install Skype ++++"
echo "---------------------------------------------------------------------------------------------"

# Users of 64-bit Ubuntu, should enable MultiArch if it isn't already enabled by running the command
sudo dpkg --add-architecture i386

sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update
sudo apt-get install skype pulseaudio:i386


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

ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
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
