#!/usr/local/bin/python

import sys;
import os;
from subprocess import call

def trim(s):
	return s.strip()

def module_exists(module_name):
    try:
        __import__(module_name)
    except ImportError:
        return False
    else:
        return True

def cmd_call (cmd):
	print "CMD=%s" % (cmd)
	call(cmd, shell=True, stdout=sys.stdout)

def get_package_id (a_name):
	lines = os.popen ('iron info ' + a_name).readlines ()
	for line in lines:
		s = trim(line)
		if s.startswith("id:"):
			s = s[3:]
			return trim(s)

def get_ise_libraries(basedir, v):
	d = os.path.join (basedir, "library")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "https://svn.eiffel.com/eiffelstudio/branches/Eiffel_%s/Src/library" % (v), d ])

	d = os.path.join (basedir, "contrib")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "https://svn.eiffel.com/eiffelstudio/branches/Eiffel_%s/Src/contrib" % (v), d ])

def process_package (fn,u,p,repo,v):
	import re;
	f = open (fn, 'r')
	l_lines = re.split ('\n', f.read())
	f.close()
	dict={}
	for line in l_lines:
		d = line.split ('=', 1)
		if len(d) == 2:
			l_key = trim (d[0])
			l_value = trim (d[1])
			if l_key == 'maps':
				tb = []
				if dict.has_key ('maps'):
					tb = dict['maps']
				if tb == None:
					tb = []
				tb.append (trim(l_value))
				dict['maps'] = tb
			else:
				dict[trim(l_key)] = trim(l_value)
	p_name = None
	p_description = None
	p_source = None
	if dict.has_key('name'):
		p_name = trim(dict['name'])
		iron_create_cmd = "iron share create -u %s -p %s --repository %s --batch --package-name %s" % (u, p, repo, p_name)
		iron_update_cmd = "iron share update -u %s -p %s --repository %s --batch --package-name %s" % (u, p, repo, p_name)
		if dict.has_key ('description'):
			p_description = trim(dict['description'])
			if len(p_description) == 0:
				p_description = None
		if len (dict['source']) > 0:
			p_source = trim(dict['source'])
			if len(p_source) == 0:
				p_source = None

		cmd = "%s" % (iron_create_cmd)
		if p_description != None:
			cmd = "%s --package-description \"%s\" " % (cmd, p_description)
			#call(['iron', 'share', 'create', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name, '--package-description', p_description], shell=True, stdout=sys.stdout)
		#else:
			#call(['iron', 'share', 'create', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name], shell=True, stdout=sys.stdout)
		cmd_call (cmd)

		if p_source != None:
			l_src = os.path.dirname(fn)
			for seg in p_source.split('/'):
				l_src = os.path.join (l_src, seg)
			l_src = os.path.normpath (l_src)
			
			is_process_local_archive = False
			if is_process_local_archive:
				l_id = get_package_id (p_name)
				if l_id == None:
					print "No id for %s" % (p_name)
				else:
					if len (l_id) > 0:
						l_folder =  os.path.join (os.path.abspath('archive'), v, "items", l_id)
						if not os.path.exists (l_folder):
							os.makedirs(l_folder)
						cmd_call ("./iron/spec/unix/bin/iron_build_archive  %s %s %s" % (l_src, l_folder, "archive")
			else:
				cmd = "%s --package-archive-source \"%s\" " % (iron_update_cmd, l_src)
				cmd_call (cmd)
				#call(['iron', 'share', 'update', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name, '--package-archive-source', l_src], shell=True)

		if dict.has_key ('maps'):
			p_maps = dict['maps']
			if len(p_maps) > 0:
				for m in p_maps:
					cmd = "%s --index \"%s\" " % (iron_update_cmd, m)
					cmd_call (cmd)
					#call(['iron', 'share', 'update', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name, '--index', m], shell=True)


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
	
	l_login = trim(credential.login())
	l_password = trim(credential.password())
	repo = "%s/%s" % (repository_cfg.repository(), repository_cfg.version())
	print "user [%s] on repository [%s]" % (l_login, repo)
	l_base_dir = os.path.normpath(os.path.abspath (os.path.join ("VERSIONS", repository_cfg.version())))
	get_ise_libraries(l_base_dir, repository_cfg.version())

	l_packages_path = os.path.join (l_base_dir, "packages")
	l_files = os.listdir (l_packages_path)
	for f in l_files:
		if not os.path.isdir(f):
			if f.endswith('.info'):
				process_package (os.path.join (l_packages_path, f), l_login, l_password, repo, repository_cfg.version())

if __name__ == '__main__':
	main()
	sys.exit()
