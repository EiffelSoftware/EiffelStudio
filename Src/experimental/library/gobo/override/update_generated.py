#!/usr/local/bin/python
"""
	This script is to copy generated (unversioned) Eiffel file into generated folder.
	maintainer: Jocelyn (jfiat@eiffel.com)
"""

import sys;
import os;

def get_output (a_cmd):
#	sys.stderr.write ("Execute: %s\s \n" %(a_cmd))
	r = os.popen (a_cmd, 'r').read ()
	return r

def regexp_escape (a_string):
	import string;
	r = a_string
	r = string.replace (r, '\\', '\\\\')
	r = string.replace (r, '/', '\\/')
	r = string.replace (r, '.', '\\.')
	return r

def copyfile(source, dest, buffer_size=1024*1024):
	"""    
	Copy a file from source to dest. source and dest    
	can either be strings or any object with a read or    
	write method, like StringIO for example.    
	"""    
	if not hasattr(source, 'read'):        
		source = open(source, 'rb')    
	if not hasattr(dest, 'write'):        
		dest = open(dest, 'wb')    
	while 1:        
		copy_buffer = source.read(buffer_size)        
		if copy_buffer:            
			dest.write(copy_buffer)        
		else:           
			break    
	source.close()    
	dest.close()

def makedirs(a_dir):
	if not os.path.exists (a_dir):
		os.makedirs (a_dir)

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

def update_node (a_src, a_target, a_dir, a_name):
	import shutil

	makedirs (os.path.join (a_target, a_dir))
	shutil.copy2 (os.path.join (a_src, a_dir, a_name), os.path.join (a_target, a_dir, a_name))
#	copyfile (os.path.join (a_src, a_dir, a_name), os.path.join (a_target, a_name))
	print "  + %s"% (os.path.join (a_dir, a_name))


def main(a_src, a_tgt):
	import re;
	import string;

	sys.stderr.write ("Update override folder\n")
	sys.stderr.write ("* svn status on \"%s\" ...\n" % (a_src))
	l_dir = a_src
	l_target = a_tgt
	e_file_p = re.compile ("^(\?|I).*%s(.*)\.e\s*$" % (regexp_escape(l_dir)));
	dir_p = re.compile ("^(\?|I).*%s([^\.]*)\s*$" % (regexp_escape(l_dir)));
	spec_pat = "spec" + os.sep
	spec_ise_pat = os.path.join ("spec", "ise")

	lines = re.split ("\n", get_output ("svn status %s --no-ignore" % (l_dir)))
	sys.stderr.write ("* clean current files from \"%s\" ...\n" % (a_tgt))
	clean_folder (a_tgt)
	sys.stderr.write ("* copy files to \"%s\" ...\n" % (a_tgt))
	nb = 0
	for l in lines:
		if len(l) > 0 and (l[0] == '?' or l[0] == 'I'):
			result = e_file_p.search (l, 0)
			if result:
				node = "%s.e" % (result.group (2)[1:])
				sp = os.path.split (node)
				update_node (l_dir, l_target, sp[0], sp[1])
				nb = nb + 1
			else:
				result = dir_p.search (l, 0)
				if result:
					lst = nodes_in_folder (os.path.join (l_dir, result.group (2)[1:]), "^.*\.e$")
					for i in lst:
						d = i['dir']
						d = d[1+len(l_dir):]
						if string.rfind (d, spec_pat) > 0:
							if string.rfind (d, spec_ise_pat) > 0:
								update_node (l_dir, l_target, d, i['file'])
								nb = nb + 1
						else:
							update_node (l_dir, l_target, d, i['file'])
							nb = nb + 1
	sys.stderr.write ("* completed - %d file(s) copied - \n" % (nb))


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

	main(src,tgt)
	sys.exit()

