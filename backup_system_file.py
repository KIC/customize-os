#!/usr/bin/python3
import os
import sys
from shutil import copyfile, copytree

if __name__ == '__main__':
    args = sys.argv[1:-1]
    target = sys.argv[-1]

    for arg in args:
        base_path = os.path.split(arg)[:-1] if os.path.isdir(arg) else os.path.dirname(arg)
        os.makedirs(base_path, exist_ok=True)
        copytree