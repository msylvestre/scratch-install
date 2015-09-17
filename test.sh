#!/bin/bash
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
gem install sass

# Install npm package dependencies
sudo npm install -g bower
sudo npm install -g grunt-cli
sudo npm install -g jshint

# Clone the repo
cd ~/geek
git clone git@github.com:venzee/venzee.com.git
cd venzee.com
sudo npm install
grunt dev