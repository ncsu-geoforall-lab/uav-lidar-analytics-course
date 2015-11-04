#!/usr/bin/python

import sys
import fileinput
import re

block_start = re.compile(r'^\s*<pre><code>\s*$')
block_end = re.compile(r'^\s*</code></pre>\s*$')
comment = re.compile(r'^\s*#')

in_block = False

for line in fileinput.input():
    if block_start.search(line):
        in_block = True
    if block_end.search(line):
        in_block = False
    if in_block and comment.search(line):
        sys.stdout.write('<span class="comment">{}</span>'.format(line))
    else:
        sys.stdout.write(line)
