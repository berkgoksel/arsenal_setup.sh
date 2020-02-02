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
#git clone https://github.com/berkgoksel/guacamole /usr/share/arsenal/guacamole
git clone https://github.com/berkgoksel/opener.git /usr/share/arsenal/opener
git clone https://github.com/Ganapati/RsaCtfTool.git /usr/share/arsenal/RsaCtfTool
git clone https://github.com/Nekmo/dirhunt.git /usr/share/arsenal/dirhunt
git clone https://github.com/pwndbg/pwndbg /usr/share/arsenal/pwndbg

apt update
apt-get install -y gcc ruby-dev
apt-get install -y libgmp-dev libmpfr-dev libmpc-dev
pip3 install -r /usr/share/arsenal/RsaCtfTool/requirements.txt

gem install seccomp-tools

apt install -y gdb
apt install -y python3-pip
apt install -y gobuster exiftool
#apt install -y nasm build-essential
apt install -y ltrace strace
apt install -y python2 python-pip

pip install pwntools
pip install z3-solver

pip3 install netaddr
pip3 install ropper
pip3 install frida-tools

#For GEF:
pip3 install ropper capstone unicorn keystone-engine

#Lets set the disassembly flavor to Intel.
echo "set disassembly-flavor intel" >> ~/.gdbinit

mkdir /usr/share/arsenal/misc
chmod +x link32.sh
chmod +x link64.sh
chmod +x bin2shellcode.sh
mv link32.sh /usr/share/arsenal/misc/
mv link64.sh /usr/share/arsenal/misc/
mv bin2shellcode.sh /usr/share/arsenal/misc
mv rot13.py /usr/share/arsenal/misc/
mv morse.py /usr/share/arsenal/misc/
mv binaryencoder.py /usr/share/arsenal/misc/

pip3 install morse-talk 



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
alias link32='/usr/share/arsenal/misc/link32.sh'
alias bin2shellcode='/usr/share/arsenal/misc/bin2shellcode.sh'
alias rot13encode='python3 /usr/share/arsenal/misc/rot13.py -e'
alias rot13decode='python3 /usr/share/arsenal/misc/rot13.py -d'
alias morseencode='python3 /usr/share/arsenal/misc/morse.py -e'
alias morsedecode='python3 /usr/share/arsenal/misc/morse.py -d'
alias binaryencode='python3 /usr/share/arsenal/misc/binaryencoder.py -e'
alias binarydecode='python3 /usr/share/arsenal/misc/binaryencoder.py -d'


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
	#sha1_sum=$(sha1sum /usr/share/arsenal/idafree70_linux.run | cut -d " " -f 1)
	#idafree70sha1=85984147fea9625fa149484eae2ef6d0c2739856

	#if [ "$sha1_sum" != "$idafree70sha1" ]

	#then
        #	echo "WARNING: Checksums don't match!\n"
        #	echo "What you downloaded:"
        #	echo $sha1_sum
        #	echo "What it should be:"
        #	echo $idafree70sha1"\n"
        #	read -r -p "Do you want to continue? [y/N]" response2
        #	case "$response2" in
        #	[yY][eE][sS]|[yY])
        #	echo "Downloading dependencies."
        #	;;
    	#*)
        #	echo "Skipping"
        #	;;
	#esac
	#fi




	dpkg --add-architecture i386
	apt-get update
	apt-get install -y libpcre3:i386 libxdmcp6:i386 libc6:i386 libffi6:i386 libxcb1:i386 libgcc1:i386 libxau6:i386 zlib1g:i386 libx11-6:i386
	echo "Installing IDA Freeware"
	chmod +x /usr/share/arsenal/idafree70_linux.run && /usr/share/arsenal/idafree70_linux.run
        ;;
    *)
	echo "Alright! You can install it later manually."
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
	rm -rf sasm_3.6.0_amd64.deb
	read -n 1 -s -r -p "Press any key to continue\n"
        ;;
    *)
        ;;
esac


#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#git clone https://github.com/powerline/fonts.git /use/share/arsenal/
#bash /use/share/arsenal/fonts/install.sh
#chsh -s $(which zsh)

read -r -p "Will you be mounting VHD files on remote systems? :D [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
    	apt-get install -y libguestfs-tools
	sudo apt-get -y install cifs-utils
	
	read -n 1 -s -r -p "Press any key to continue\n"
        ;;
    *)
        ;;
esac


