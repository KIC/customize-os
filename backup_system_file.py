#!/usr/bin/python3
import os
import sys
from shutil import copytree, copyfile

if __name__ == '__main__':
    if len(sys.argv) < 2:
        raise ValueError("provide source dest files")

    args = sys.argv[1:-1]
    target = os.path.realpath(sys.argv[-1])
    print(f'copy from {args} to {target}')

    for arg in args:
        base_path = os.path.join(*os.path.split(arg)[:-1]) if os.path.isdir(arg) else os.path.dirname(arg)
        target_path = os.path.join(target, base_path[1:])

        print(f'mkdir {target_path}')
        os.makedirs(target_path, exist_ok=True)

        target_file = os.path.join(target, arg[1:])
        print(f'copy {arg} to {target_file}')
        if os.path.isdir(arg):
            copytree(arg, target_file, dirs_exist_ok=True)
        else:
            copyfile(arg, target_file)

"""
backup_system_file.py /etc/aliases /etc/apt /etc/cron* /etc/environment* /etc/fstab /etc/hosts /etc/ly /etc/profile* \
 /etc/ranger /etc/default/grub* /etc/default/grub backup
"""
