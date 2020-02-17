import os
import time
import sys


usage = (
"Visits a list of  IP adresses or domain names in different tabs using firefox.\n\n"
"--limit           limits the maximum number of tabs be"
"fore promting for continuation.\n-h, --help        prints this help page.\n"
"\nExample Usage: visitpages.py file.txt --limit 20"
)


def opener():

            try:
                opener_ip_list = sys.argv[1]
                print("Starting Firefox")
                time.sleep(0.5)
                os.system('firefox --new-tab github.com/berkgoksel & ')
                time.sleep(2)
                opener_z = open(opener_ip_list, "r")
                opener_a = opener_z.read().split('\n')

                x = 0
                limit = 10

                for i in range(len(sys.argv)):
                    if sys.argv[i] == "--limit":
                        limit = sys.argv[i + 1]
                        break

                for opener_line in opener_a:
                    if x == int(limit):

                        p2 = raw_input("Enter any key to continue, n to exit:  ")
                        if p2 == str('n'):
                            break
                        else:
                            x = 0


                    opener_command = "firefox --new-tab " + opener_line
                    os.system(opener_command)
                    time.sleep(0.5)
                    x = x + 1

            except IndexError:
                sys.exit(usage + "\n\n\nYou did not specify an input file.\n")



def start():

    if "-h" in sys.argv or "--help" in sys.argv:
        sys.exit(usage)

    opener()

start()
