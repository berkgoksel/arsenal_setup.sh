read -r -p "Is this a clean Kali installation? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        #Change default kali SSH Keys
	mkdir /etc/ssh/default_kali_keys
	mv /etc/ssh/ssh_host_* /etc/ssh/default_kali_keys/
	dpkg-reconfigure openssh-server
	echo "Verify if the SSH keys have changed or not!"
	echo
	echo New keys:
	md5sum /etc/ssh/ssh_host_*
	echo 
	echo Old keys:
	md5sum /etc/ssh/default_kali_keys/*
	echo
	read -n 1 -s -r -p "Press any key to continue"
        ;;
    *)
        continue
        ;;
esac

mkdir /usr/share/arsenal
git clone https://github.com/berkgoksel/Elayv.git /usr/share/arsenal/elayv
git clone https://github.com/longld/peda.git /usr/share/arsenal/PEDA
git clone https://github.com/JonathanSalwan/ROPgadget.git /usr/share/arsenal/ROPgadget
git clone https://github.com/hugsy/gef.git /usr/share/arsenal/GEF
#git clone https://github.com/berkgoksel/guacamole /usr/share/arsenal/guacamole #Source code not yet disclosed
git clone https://github.com/berkgoksel/opener.git /usr/share/arsenal/opener

apt-get install -y python3-pip
apt-get install -y gobuster
apt-get install -y python-pip


pip3 install netaddr
pip install capstone
pip install pwntools


echo "
alias elayv='python3 /usr/share/arsenal/elayv/elayv.py'
alias guacamole='/usr/share/arsenal/guacamole/guacamole.sh'
alias pattern_offset='/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb'
alias pattern_create='/usr/share/metasploit-framework/tools/exploit/pattern_create.rb'
alias ropgadget='python /usr/share/arsenal/ROPgadget/ROPgadget.py'
alias bustit='gobuster -w /usr/share/dirbuster/wordlists/directory-list-2.3-small.txt -u '
alias opener='python /usr/share/arsenal/opener/opener.py'
" >> /root/.bashrc

#Uniq duplicate alias(?) entries - UNTESTED
#cat /root/.bashrc | nl|sort -k 2|uniq -f 1|sort -n|cut -f 2 > /root/.bashrc2
