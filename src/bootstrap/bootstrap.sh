#!/bin/bash

message () {
	echo ""
	echo "-----------------------------------------------------------"
	echo "$1"
	echo "-----------------------------------------------------------"
	echo ""
}

message "Attempting to stop the create_ap access point (if it's running)..."
sudo systemctl stop create_ap

message "Checking for internet connectivity..."
wget -q --spider http://google.com

if ! [ $? -eq 0 ]; then
	echo ""
    echo "Raspi is not currently connected to the internet." \
	echo "Please connect to the internet and run this script again" \
	echo "Exiting..."  \
	echo ""
	exit
fi

message "Checking for updates..."
sudo apt update
sudo apt upgrade -y

message "Installing drmngr..."
sudo apt install -y \
	dirmngr

message "Adding ros pathes to ~/.bashrc..."
if ! grep "source /opt/ros/melodic/setup.bash" ~/.bashrc
	then echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
fi

if ! grep "source /home/pi/toddthequad/devel/setup.bash" ~/.bashrc
	then echo "source /home/pi/toddthequad/devel/setup.bash" >> ~/.bashrc
fi 

message "Adding ros repositories"
if ! grep "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" /etc/apt/sources.list.d/ros-latest.list
	then sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
fi
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

message "Adding codebuilds key..."
sudo wget -qO - https://packagecloud.io/headmelted/codebuilds/gpgkey | sudo apt-key add -;

message "Checking for updates again after repositories were added..."
sudo apt update
sudo apt upgrade -y

message "Installing ROS dependencies..."
sudo apt install -y \
	python-rosdep \
	python-rosinstall-generator \
	python-wstool \
	python-rosinstall \
	build-essential

message "Running rosdep init and update..."
sudo rm /etc/ros/rosdep/sources.list.d/20-default.list
sudo rosdep init
rosdep update

message "Installing all opencv3 dependencies..."
sudo apt install -y \
	build-essential \
	cmake \
	pkg-config \
	libjpeg-dev \
	libtiff5-dev \
	libjasper-dev \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	libv4l-dev \
	libxvidcore-dev \
	libx264-dev \
	libgtk2.0-dev \
	libgtk-3-dev \
	libatlas-base-dev \
	gfortran \
	python3-dev \
	python3-pip \
	libhdf5-100 \
	libhdf5-serial-dev \
	libhdf5-dev \
	libhdf5-cpp-100 \
	caffe-cpu

message "pip3 install of tensorflow..."
sudo pip3 install numpy scipy tensorflow

# All ROS Melodic Stretch Install Dependencies

message "Installing ROS Melodic Desktop dependencies..."
sudo apt install -y\
	python-opencv \
	python-matplotlib \
	python-sip-dev \
	libeigen3-dev \
	libqt5widgets5 \
	libapr1-dev \
	libaprutil1-dev \
	libtinyxml2-dev \
	qtbase5-dev \
	liblz4-dev \
	sbcl \
	tango-icon-theme \
	libgl1-mesa-dev \
	libglu1-mesa-dev \
	python-nose \
	python-imaging \
	libcurl4-openssl-dev \
	curl \
	libassimp-dev \
	liburdfdom-dev \
	python-yaml \
	libbz2-dev \
	python-lxml \
	cmake \
	uuid-dev \
	python-crypto \
	python-empy \
	python-netifaces \
	liburdfdom-headers-dev \
	libgtest-dev \
	libpython2.7-stdlib \
	python-paramiko \
	python-coverage \
	python-pyqt5.qtopengl \
	google-mock \
	libboost-all-dev \
	liblog4cxx-dev \
	libyaml-cpp-dev \
	qt5-qmake \
	python-mock \
	python-wxtools \
	python-cairo \
	python-dev \
	libssl-dev \
	python-numpy \
	libgtk2.0-dev \
	python-rospkg \
	libopencv-dev \
	libgpgme-dev \
	libogg-dev \
	hddtemp \
	libtinyxml-dev \
	libpoco-dev \
	libconsole-bridge-dev \
	graphviz \
	libqt5opengl5 \
	libqt5opengl5-dev \
	python-gnupg \
	libtheora-dev \
	python-opengl \
	libcppunit-dev \
	python-psutil \
	libogre-1.9-dev \
	python-defusedxml \
	python-pygraphviz \
	python-pydot \
	python-catkin-pkg \
	libqt5gui5 \
	libqt5core5a \
	python-rosdep \
	python-pyqt5.qtwebkit \
	joystick \
	pyqt5-dev \
	python-pyqt5 \
	python-pyqt5.qtsvg \
	python-sip-dev \
	qtbase5-dev \
	pkg-config

message "Installing Samba filesharing tools..."
sudo apt-get install -y \
	samba \
	samba-common-bin \
	smbclient cifs-utils

message "Installing adafruit servokit..."
sudo pip3 install adafruit-circuitpython-servokit

message "Installing gpizero libraries..."
sudo apt install -y \
	python-gpiozero \
	python3-gpiozero

message "Installing precompiled version of tinyxml2..."
#if [ ! -f ./install/tinyxml2.deb]; then
	curl -L -o install/tinyxml2.deb "https://drive.google.com/uc?export=download&id=1gPy43-KhkPrssxgwSfDcRI4xp3iahKsy"
#fi
sudo dpkg -i ./install/tinyxml2.deb

message "Installing precompiled compatible version of opencv3 (raspi 0,1,2 compatible)///"
#if [ ! -f ./install/opencv.deb]; then
	curl -L -o install/opencv.deb "https://drive.google.com/uc?export=download&id=1i8RBgxMXuCMxyIPgjWoHWeX7xmEmuM23"
#fi
sudo dpkg -i ./install/opencv.deb

message "Installing precompiled version of ros melodic desktop + perception + robot + joy(stick)///"
#if [ ! -f ./install/ros_desktop.tar.bz2]; then
	curl -L -o install/ros_desktop.tar.bz2 "https://drive.google.com/uc?export=download&id=1ffIgOm6M6TicZbAcWjK7va_A33rBHrs4"
#fi
sudo tar xjf ./install/ros_desktop.tar.bz2 -C /

message "Installing precompiled version of Visual Studio Code (code-oss)"
# https://code.headmelted.com
# https://github.com/headmelted/codebuilds
#if [ ! -f ./install/code-oss.deb]; then 
	curl -L -o install/code-oss.deb "https://github.com/headmelted/codebuilds/releases/download/20-Feb-19/code-oss_1.32.0-1550644722_armhf.deb"
#fi
sudo dpkg -i ./install/code-oss.deb

message "Increasing swapfile to 1Gb..."
sudo dphys-swapfile swapoff
sudo cp install/dphys-swapfile /etc/dphys-swapfile
sudo dphys-swapfile swapon

message "Configuring Samba filesharing..."
sudo systemctl smbd stop
sudo cp install/smb.conf /etc/samba/smb.conf
echo ""
echo "--------------------------------------------------------------------"
echo " Now, please enter in a samba (windows filesharing) password for use"
echo "--------------------------------------------------------------------"
#sudo smbpasswd -a pi
sudo systemctl smbd start

message "Installing create_ap (Raspi as an access point)..."
# https://github.com/oblique/create_ap
sudo apt install -y \
	util-linux \
	procps \
	hostapd \
	iproute2 \
	haveged \
	dnsmasq \
	iptables

cd install
git clone https://github.com/oblique/create_ap
cd create_ap
sudo make install
sudo create_ap -n wlan0 todd toddthequad
#sudo systemctl enable create_ap
#sudo systemctl start create_ap

message "DONE!!!!"