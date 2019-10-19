import morse_talk as mtalk
import sys

string = sys.argv[2]

if sys.argv[1] == "-e":
	string = mtalk.encode(string)
	print(string)

if sys.argv[1] == "-d":
	string = mtalk.decode(string)
	print(string)

sys.exit(0)
