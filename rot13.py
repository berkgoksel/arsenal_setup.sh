import codecs
import sys

string = sys.argv[2]

if sys.argv[1] == "-e":
	string = codecs.encode(string, 'rot13')

if sys.argv[1] == "-d":
	string = codecs.decode(string, 'rot13')


print(string)
#alias rot13encode='python3 /usr/share/arsenal/rot13.py -e'
#alias rot13decode='python3 /usr/share/arsenal/rot13.py -d'
