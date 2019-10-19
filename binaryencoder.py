import morse_talk as mtalk
import sys

string = sys.argv[2]

if sys.argv[1] == "-e":
	string = mtalk.encode(string, encoding_type='binary')
	print(string)

if sys.argv[1] == "-d":
	string = mtalk.decode(string, encoding_type='binary')
	print(string)

sys.exit(0)
