import socket
import urllib2
import sys
import os
import time
#import subprocess



def host_query():

    domain1 = str(raw_input("Please enter Domain name (format: domain.com:\n"))
    try:
        IP_RR = socket.gethostbyname(domain1)
        print(str(domain1) + "'s IP adress is " +str(IP_RR))
        return domain1
    except:
        print("You may have typed a non-existent domain. If not, check your internet connection")




def la( domainName):

    try:

        print("\nSearching for robots.txt file on " + str(domainName))
        RR_user_agent = 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'
        RR_headers = {'User-Agent': RR_user_agent}
    # data = urllib.urlencode(values)
        RR_url = "http://" + str(socket.gethostbyname(domainName)) + "/robots.txt"
        RR_req = urllib2.Request(RR_url, None, RR_headers)
        RR_response = urllib2.urlopen(RR_req)
        RR_rcode = RR_response.getcode()
        html = RR_response.read().split('\n')
        #print html --debug

        if RR_rcode == int(200):
            print("Processing robots.txt file")
            os.system('firefox --new-tab http://www.berkgoksel.com & ')
            time.sleep(2)

            x = 0
            for RR_line in html:
                if x == int(10):

                    p2 = raw_input("Press (y) to continue...")
                    if p2 == str('y'):
                        x = 0
                    else:
                        break

                if str("Disallow") in RR_line:
                    RR_dir = RR_line.split(': ')[1]
                    RR_command = "firefox --new-tab " + domainName + RR_dir
                    os.system(RR_command)
                    #subprocess.call([RR_command], shell=True)
                    time.sleep(0.5)
                    x = x + 1
                    #If no disallowed pages are found + print error.


                        #os.system('firefox -new-tab' + domainName + '/' + RR_line)
                        #time.sleep(0.5)

               # else:
                    #print "a"

                #RR_File = open("temp_file", 'r')
                #disallowed = RR_File.read().split('\n')
                #print disallowed



        else:
            sys.exit("Unable to find robots.txt")

    except urllib2.URLError:
        sys.exit("Check your internet connection")


#checks if could get robots.txt
la(host_query())
