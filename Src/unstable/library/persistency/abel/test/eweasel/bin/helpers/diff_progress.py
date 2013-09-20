#!/usr/bin/python

import sys
import re
import os
import time;


def get_data (fn, failures, passed, ignored, verbose):
	file = open(fn, "r")
	file_lines = re.split ("\n", file.read())
	file.close()
	nb = 0
	p = re.compile (regexp);
	for line in file_lines:
		result = p.search (line,0)
		if result:
			nb = nb + 1
			k = result.group (2)
			n = result.group (1)
			if result.group(3) == 'passed':
				passed[k] = n
			elif result.group(3) == 'failed':
				if verbose:
					print n + " (" + k + ")" + " failed."
				failures[k] = n
			elif result.group(3) == 'skipped':
				ignored[k] = n
			elif result.group(3) == 'manual':
				ignored[k] = n
			else:
				if verbose:
					print "unknown [" + line + "]"
		else:
			if len(line) > 0:
				if line[0] != ' ' and line[0] != '\t':
					if verbose:
						print "ignored ["+ line +"]"

	if verbose:
		print "\n"
	return nb;

def diff_data (fn, failures, passed, ignored, ref_nb, diff_nb, verbose=False):
	file = open(fn, "r")
	file_lines = re.split ("\n", file.read())
	file.close()
	nb = 0
	p = re.compile (regexp);
	p_in_progress = re.compile (regexp_in_progress);
	for line in file_lines:
		s = None
		result = p.search (line,0)
		if result:
			nb = nb + 1
			if nb > diff_nb:
				k = result.group (2)
				n = result.group (1)
				if result.group(3) == 'passed':
					if passed.has_key (k):
						s = "PASSED (TOO): " + n + " (" + k + ")"
						if not verbose:
							s = None
					elif failures.has_key (k):
						s = "PASSED (NEW) : " + n + " (" + k + ")"
					elif ignored.has_key (k):
						s = "PASSED (...) : " + n + " (" + k + ")"
					else:
						s = "PASSED (???) : " + n + " (" + k + ")"
						if not verbose:
							s = None
				elif result.group(3) == 'failed':
					if passed.has_key (k):
						s = "FAILED (NEW): " + n + " (" + k + ")"
					elif failures.has_key (k):
						s = "FAILED (TOO): " + n + " (" + k + ")"
						if not verbose:
							s = None
					else:
						s = "FAILED (...): " + n + " (" + k + ")"
						if not verbose:
							s = None
				elif result.group(3) == 'skipped':
					s = "SKIPPED: " + n + " (" + k + ")"
				elif result.group(3) == 'manual':
					s = "MANUAL: " + n + " (" + k + ")"
				else:
					s = "Unknown [" + line + "]"
		else:
			if len(line) > 0:
				result = p_in_progress.search (line,0)
				if result:
					s = "In progress ["+ result.group(1) + " (" +result.group(2) + ")" +"]"
					if not verbose:
						s = None
				else:
					if line[0] != ' ' and line[0] != '\t' and line[0] != 'E':
						s = "Ignored ["+ line +"]"
		if s != None:
			print "%4d/%4d: %s" % (nb, ref_nb, s)

	return nb;


ref = sys.argv[1]
new = sys.argv[2]
is_looping = (len(sys.argv) > 3) and sys.argv[3] == "-loop"

eweasel = os.environ['EWEASEL']
regexp = "^Test\s\s*([a-zA-Z0-9_\*-]+)\s*\(([^\)]+)\):\s*([a-z]+)\s*$"
regexp_in_progress = "^Test\s\s*([a-zA-Z0-9_\*-]+)\s*\(([^\)]+)\)\s*$"
failures = {}
passed = {}
ignored = {}
print "Status from: " + ref
nb = get_data (ref, failures, passed, ignored, False)

print "  Diff with: " + new
diff_nb = 0
diff_nb = diff_data (new, failures, passed, ignored, nb, diff_nb, False)
while is_looping:
	diff_nb = diff_data (new, failures, passed, ignored, nb, diff_nb)
	time.sleep(30)

