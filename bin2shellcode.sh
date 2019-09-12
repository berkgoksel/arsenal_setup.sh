#!/bin/bash

objdump -D $1 -M intel | cut -d' ' -f2-5 | cut -d':' -f2 | tr -d '\t\n ' | sed -r 's/(.{2})/\\x\1/g'
