#!/usr/bin/python

import sys
import re
import os

results = sys.argv[1]
new_catalog = sys.argv[2]
eweasel = os.environ['EWEASEL']

file = open(results, "r")
file_lines = re.split ("\n", file.read())
file.close()
#regexp = "^Test ([a-zA-Z0-9_-]+)\s*\(([a-z0-9]+])\): [a-z]+\s*$"
regexp = "^Test\s\s*([a-zA-Z0-9_\*-]+)\s*\(([^\)]+)\):\s*([a-z]+)\s*$"
failures = {}
passed = {}
p = re.compile (regexp);
for line in file_lines:
	result = p.search (line,0)
	if result:
		if result.group(3) == 'passed':
			passed[result.group(2)] = result.group(1)
		elif result.group(3) == 'failed':
			print result.group(1) + "(" + result.group (2) + ")" + " failed."
			failures[result.group(2)] = result.group(1)
		elif result.group(3) == 'skipped':
			failures[result.group(2)] = result.group(1)
		elif result.group(3) == 'manual':
			failures[result.group(2)] = result.group(1)
		else:
			print "unknown [" + line + "]"
	else:
		if len(line) > 0:
			if line[0] != ' ' and line[0] != '\t':
				print "ignored ["+ line +"]"


file = open(os.path.join(eweasel, 'control', 'catalog'), "r")
file_lines = re.split ("\n", file.read())
file.close()
regexp = "^(if not DOTNET )*test\s*([a-zA-Z0-9\*_-]+)\s*([a-zA-Z0-9_-]+)\s*.*$"
p = re.compile (regexp);
print_empty_line = True

#target = open(os.path.join(eweasel, 'control', "catalog-%s" % (new_catalog)), "w")
target = open(new_catalog, "w")
for line in file_lines:
	l = None
	line.lstrip()
	if len(line) == 0:
		if print_empty_line:
			l = line
		print_empty_line = False
	else:
		if line[0:2] == "--":
			l = line
			print_empty_line = False
		elif line[0:6] == "source":
			l = line
			print_empty_line = True
		else:
			result = p.search (line,0)
			if result:
				t = result.group(3)
#				if failures.has_key(t):
				if not passed.has_key(t):
					l = line
					print_empty_line = True
	if l != None:
		target.write ("%s\n" % (l))

target.close()
