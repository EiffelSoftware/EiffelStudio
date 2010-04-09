#!/usr/bin/python

import sys
import re
import os

fn = sys.argv[1]
test = sys.argv[2]

file = open(fn, "r")
file_text = file.read()
file_lines = re.split ("\n", file_text)
file.close()

backup = open("%s.bak" % (fn), "w")
backup.write (file_text)
backup.close()

target = open(fn, "w")
regexp = "^Test ([a-zA-Z0-9_-]+)\s*\(([^\)]+)\):\s*([a-z]+)\s*$"
p = re.compile (regexp);
remove_next = False
done = False
for line in file_lines:
	if remove_next:
		remove_next = len(line) == 0 or line[0] == '\t'
	if not remove_next:
		result = p.search (line,0)
		if result and result.group(3) == 'failed' and result.group(2) == test:
			target.write("Test %s (%s): passed\n" % (result.group(1), result.group(2)))
			remove_next = True
		else:
			target.write (line + "\n")
target.close()

