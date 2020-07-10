#!/usr/bin/env python3

import os
import requests
import socket
import sys
import time


def host_query():
    try:
        domain = input("Enter domain name (format: domain.com): ")
        ip_address = socket.gethostbyname(domain)
        print(f"{domain}'s IP address is: {ip_address}")

        robots(domain)

    except:
        print("You may have typed a non-existent domain. If not, check your internet connection")
        host_query()


def robots(domainName):
    try:
        print(f"Searching for 'robots.txt' file on {domainName}")
        user_agent = "Mozilla/5.0"
        custom_headers = {"User-Agent": user_agent}
        url = f"http://{domainName}/robots.txt"
        request = requests.get(url, headers=custom_headers)
        status_code = request.status_code
        response = request.text
        html = response.split("\n")

        if status_code == int(200):
            print("Processing 'robots.txt'")
            # os.system(f"firefox --new-tab {domainName} & ")
            # time.sleep(2)

            x = 0
            for line in html:
                if x == int(10):
                    user_input = input("Press (y) to continue...")

                    if user_input == str("y"):
                        x = 0

                    else:
                        break

                if "Disallow" in line:
                    directory = line.split(": ")[1]
                    command = f"firefox --new-tab {domainName}{directory}"
                    os.system(command)

                elif "Allow" in line:
                    print(line)

            print("Finished processing 'robots.txt'")

        else:
            sys.exit("Unable to find 'robots.txt'")

    except:
        sys.exit("Check your internet connection")
        host_query()


if __name__ == "__main__":
    host_query()
