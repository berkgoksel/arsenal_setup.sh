read -r -p "Is this a clean Kali installation? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        #Change default kali SSH Keys
	mkdir /etc/ssh/default_kali_keys
	mv /etc/ssh/ssh_host_* /etc/ssh/default_kali_keys/
	dpkg-reconfigure openssh-server
	echo "You might want to verify if the SSH keys have changed(!)"
	echo
	echo New keys:
	md5sum /etc/ssh/ssh_host_*
	echo 
	echo Old keys:
	md5sum /etc/ssh/default_kali_keys/*
	echo
	read -n 1 -s -r -p "Press any key to continue\n"
        ;;
    *)
        ;;
esac

mkdir /usr/share/arsenal
git clone https://github.com/berkgoksel/Elayv.git /usr/share/arsenal/elayv
git clone https://github.com/longld/peda.git /usr/share/arsenal/PEDA
git clone https://github.com/JonathanSalwan/ROPgadget.git /usr/share/arsenal/ROPgadget
git clone https://github.com/hugsy/gef.git /usr/share/arsenal/GEF
#git clone https://github.com/berkgoksel/guacamole /usr/share/arsenal/guacamole #Source code not yet disclosed
git clone https://github.com/berkgoksel/opener.git /usr/share/arsenal/opener
git clone https://github.com/Ganapati/RsaCtfTool.git /usr/share/arsenal/RsaCtfTool
git clone https://github.com/Nekmo/dirhunt.git /usr/share/arsenal/dirhunt
git clone https://github.com/pwndbg/pwndbg /usr/share/arsenal/pwndbg


apt-get install -y python3-pip
apt-get install -y gobuster
apt-get install -y python-pip
apt-get install -y nasm build-essential
apt-get install -y ltrace
apt-get install -y strace


pip3 install netaddr
pip install capstone
pip install pwntools
pip install ropper
pip install unicorn
pip install frida-tools

#For GEF:
pip3 install ropper
pip3 install capstone
pip3 install unicorn
pip3 install keystone-engine

#Lets set the disassembly flavor to Intel.
echo "set disassembly-flavor intel" >> ~/.gdbinit

echo "
alias elayv='python3 /usr/share/arsenal/elayv/elayv.py'
alias guacamole='/usr/share/arsenal/guacamole/guacamole.sh'
alias pattern_offset='/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb'
alias pattern_create='/usr/share/metasploit-framework/tools/exploit/pattern_create.rb'
alias ropgadget='python /usr/share/arsenal/ROPgadget/ROPgadget.py'
alias bustit='gobuster dir -w /usr/share/dirbuster/wordlists/directory-list-2.3-small.txt -u '
alias opener='python /usr/share/arsenal/opener/opener.py'
alias msfelfscan='python /usr/share/framework2/msfelfscan'
alias msfpescan='python /usr/share/framework2/msfpescan'

" >> /root/.bashrc

source /root/.bashrc


#Uniq duplicate alias(?) entries - UNTESTED
#cat /root/.bashrc | nl|sort -k 2|uniq -f 1|sort -n|cut -f 2 > /root/.bashrc2

#Some more useful scripts and code
wget http://www.trapkit.de/tools/checkrelro.sh -P /usr/share/arsenal/

read -r -p "Want to use GEF? [y/N]" response4
case "$response4" in
    [yY][eE][sS]|[yY])

	echo 'source /usr/share/arsenal/GEF/gef.py' >> ~/.gdbinit
	esac



read -r -p "Do you want to install IDA Freeware? [y/N]" response3
case "$response3" in
    [yY][eE][sS]|[yY])

	echo "Installing IDA"

	#Get IDA Freeware
	wget https://out7.hex-rays.com/files/idafree70_linux.run -P /usr/share/arsenal/
	sha1_sum=$(sha1sum /usr/share/arsenal/idafree70_linux.run | cut -d " " -f 1)
	idafree70sha1=85984147fea9625fa149484eae2ef6d0c2739856

	if [ "$sha1_sum" != "$idafree70sha1" ]

	then
        	echo "WARNING: Checksums don't match!\n"
        	echo "What you downloaded:"
        	echo $sha1_sum
        	echo "What it should be:"
        	echo $idafree70sha1"\n"
        	read -r -p "Do you want to continue? [y/N]" response2
        	case "$response2" in
        	[yY][eE][sS]|[yY])
        	echo "Downloading dependencies."
        	;;
    	*)
        	echo "Exiting..."
        	exit 1;
        	;;
	esac
	fi




	dpkg --add-architecture i386
	apt-get update
	apt-get install -y libpcre3:i386 libxdmcp6:i386 libc6:i386 libffi6:i386 libxcb1:i386 libgcc1:i386 libxau6:i386 zlib1g:i386 libx11-6:i386
	echo "Installing IDA Freeware"
	chmod +x /usr/share/arsenal/idafree70_linux.run && /usr/share/arsenal/idafree70_linux.run
        ;;
    *)
	echo "Alright! You can install it later manually."
	exit 1;
        ;;
esac



read -r -p "Will you be using Golang? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
	wget https://dl.google.com/go/go1.12.2.linux-amd64.tar.gz
	tar -xvf go1.12.2.linux-amd64.tar.gz
	sudo mv go /usr/local
	echo export GOROOT=/usr/local/go >> /root/.bashrc
	mkdir /root/go_projects/
	mkdir /root/go_projects/proj1
	echo export GOPATH=$HOME/go_projects/proj1 >> /root/.bashrc
	echo export GOBIN=/usr/local/go/bin >> /root/.bashrc
	echo export PATH=$GOPATH/bin:$GOROOT/bin:$PATH >> /root/.bashrc
	echo export PATH=$PATH:/usr/local/go/bin >> /root/.bashrc
	read -n 1 -s -r -p "Press any key to continue\n"
        ;;
    *)
        ;;
esac


read -r -p "Will you be using SASM? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
	sudo apt-get update
	sudo apt-get -f install
	sudo apt-get install nasm
	#sudo apt-get install gcc-multilib
	wget http://download.opensuse.org/repositories/home:/Dman95/Debian_9.0/amd64/sasm_3.10.1_amd64.deb
	sudo dpkg -i asm_3.6.0_amd64.deb
	sudo apt-get install -f
	rm -rf asm_3.6.0_amd64.deb
	read -n 1 -s -r -p "Press any key to continue\n"
        ;;
    *)
        ;;
esac
