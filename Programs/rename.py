#!/usr/bin/python


import os

files = os.listdir()

for file in files:
    if file.startswith("p"):
        os.rename(file,"mp"+file[9:])

print("done")
