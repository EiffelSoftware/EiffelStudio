#!/usr/local/bin/python
"""
	This script is to copy generated (unversioned) Eiffel file into generated folder.
	maintainer: Jocelyn (jfiat@eiffel.com)
"""

import sys;
import os;

def nodes_in_folder (a_dir, a_pattern="^.*\.e$", rec=True):
	import re;
	if len(a_pattern) > 0:
		p = re.compile (a_pattern)
	else:
		p = None

	nodes = os.listdir (a_dir)
	r = []
	for n in nodes:
		fn = os.path.join (a_dir, n)
		if os.path.isdir (fn) and rec:
			sr = nodes_in_folder (fn, a_pattern, rec)
			for i in sr:
				r.append ({'dir':i['dir'], 'file':i['file']})
		else:
			if p != None:
				result = p.search(n,0)
				if result:
					r.append ({'dir':a_dir, 'file':n})
			else:
				r.append ({'dir':a_dir, 'file':n})
	return r

def clean_folder (a_target):
	lst = nodes_in_folder (a_target, "^.*\.e$")
	nb = 0
	for i in lst:
		fn = os.path.join (i['dir'], i['file'])
#		print ("Clean: %s" % (fn))
		print "  - %s"% (fn)
		os.remove (fn)
		nb = nb + 1
	print ("*    cleaning completed - %d files removed -" % (nb))

def main(a_src,a_tgt):
	import re;
	import string;

	sys.stderr.write ("Clean override folder\n")
	clean_folder (a_tgt)


if __name__ == "__main__":
	src = os.path.join ("..","svn")
	tgt = os.path.join ("generated")
#	src = os.path.join ("..","svn","library")
#	tgt = os.path.join ("generated","library")
	if len (sys.argv) == 1:
		sys.stderr.write ("Using default configuration\n")
		# Keep default values
	elif len (sys.argv) == 3:
		src = sys.argv[1]
		tgt = sys.argv[2]
	else:
		sys.stderr.write ("Usage: src_dir target_dir\n")
		sys.stderr.write (" - src_dir   : by default %s\n" % (src))
		sys.stderr.write (" - target_dir: by default %s\n" % (tgt))
		sys.exit ()

	main(src, tgt)
	sys.exit()

