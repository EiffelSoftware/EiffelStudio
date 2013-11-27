#!/usr/local/bin/python

import sys;
import os;
from subprocess import call

def module_exists(module_name):
    try:
        __import__(module_name)
    except ImportError:
        return False
    else:
        return True

def get_ise_libraries(basedir, v):
	d = os.path.join (basedir, v, "library")
	op = "checkout"
	if os.path.exists (d):
		op = "update"
	call(["svn", op, "https://svn.eiffel.com/eiffelstudio/branches/Eiffel_%s/Src/library" % (v), d ])

	d = os.path.join (v, "contrib")
	op = "checkout"
	if os.path.exists (d):
		op = "update"
	call(["svn", op, "https://svn.eiffel.com/eiffelstudio/branches/Eiffel_%s/Src/contrib" % (v), d ])

def process_package (fn,u,p,repo):
	import re;
	f = open (fn, 'r')
	l_lines = re.split ('\n', f.read())
	f.close()
	dict={}
	for line in l_lines:
		d = line.split ('=', 1)
		if len(d) == 2:
			if d[0] == 'maps':
				tb = []
				if dict.has_key ('maps'):
					tb = dict['maps']
				if tb == None:
					tb = []
				tb.append (d[1])
				dict['maps'] = tb
			else:
				dict[d[0]] = d[1]
	if len (dict['name']) > 0:
		p_name = dict['name']
		if len (dict['description']) > 0:
			p_description = dict['description']
		if len (dict['source']) > 0:
			p_source = dict['source']

		if len(p_description) > 0:
			call(['iron', 'share', 'create', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name, '--package-description', p_description], shell=True)
		else:
			call(['iron', 'share', 'create', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name], shell=True)

		if len (p_source) > 0:
			l_src = fn
			for seg in p_source.split('/'):
				l_src = os.path.join (l_src, seg)
			l_src = os.path.normpath (l_src)
			call(['iron', 'share', 'update', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name, '--package-archive-source', l_src], shell=True)

		if dict.has_key ('maps'):
			p_maps = dict['maps']
			if len(p_maps) > 0:
				for m in p_maps:
					call(['iron', 'share', 'update', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name, '--index', m], shell=True)

def main():
	try:
		import credential;
	except ImportError:
		print "missing 'credential.py'"
		sys.exit()
	
	try:
		import repository_cfg;
	except ImportError:
		print "missing 'repository_cfg.py'"
		sys.exit()
	
	l_login = credential.login()
	l_password = credential.password()
	repo = "%s/%s" % (repository_cfg.repository(), repository_cfg.version())
	print "user [%s] on repository [%s]" % (l_login, repo)
	l_base_dir = os.path.normpath(os.path.abspath (os.path.join ("VERSIONS", repository_cfg.version())))
	get_ise_libraries(l_base_dir, repository_cfg.version())

	l_packages_path = os.path.join (l_base_dir, "packages")
	l_files = os.listdir (l_packages_path)
	for f in l_files:
		if not os.path.isdir(f):
			if f.endswith('.info'):
				process_package (os.path.join (l_packages_path, f), l_login, l_password, repo)

if __name__ == '__main__':
	main()
	sys.exit()
