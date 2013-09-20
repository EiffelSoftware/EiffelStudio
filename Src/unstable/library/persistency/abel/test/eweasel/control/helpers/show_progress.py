#!/usr/bin/python

import sys
import re
import os

results = sys.argv[1]
if len(sys.argv) > 2:
	catalog = sys.argv[2]
else:
	eweasel = os.environ['EWEASEL']
	catalog = os.path.join(eweasel, 'control', 'catalog')

file = open(catalog, "r")
file_lines = re.split ("\n", file.read())
file.close()
catalog_regexp = "^(if not DOTNET )*test\s*([a-zA-Z0-9\*_-]+)\s*([a-zA-Z0-9_-]+)\s*.*$"
catalog_p = re.compile (catalog_regexp);
nb = 0
for line in file_lines:
	l = None
	line.lstrip()
	if len(line) > 0:
#		print line
		res = catalog_p.search (line,0)
		if res:
			nb = nb + 1
			t = res.group(3)

file = open(results, "r")
file_lines = re.split ("\n", file.read())
file.close()
tests_regexp = "^Test\s*([a-zA-Z0-9\*_-]+)\s*\(([a-zA-Z0-9_-]+)\):\s*(.*)$"
tests_p = re.compile (tests_regexp);
tests_nb = 0
failed_nb = 0
passed_nb = 0
failed = {}

m = 0
for line in file_lines:
	l = None
	line.lstrip()
	if len(line) > 0:
#		print line
		res = tests_p.search (line,0)
		if res:
			tests_nb = tests_nb + 1
			t = res.group(2)
			s = res.group(3)
			#print "%s : %s" % (t, s)
			if s == "failed":
				failed_nb = failed_nb + 1
				d = res.group(1)
				failed[t] = d
				m = max(m, len(d)) 
			elif s == "passed":
				passed_nb = passed_nb + 1
			else:
				print "Unknown status: %s" % (s)

print "Progress: %d/%d (passed=%d failed=%d)" % (tests_nb, nb, passed_nb, failed_nb)
for t in failed:
	print "  [failed] %-50s %s \t" % (failed[t], t)
print "Progress: %d/%d (passed=%d failed=%d)" % (tests_nb, nb, passed_nb, failed_nb)
