#!/usr/local/bin/python

import sys;
import os;
import shutil;
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

def iron_command_name():
	return "iron"

def get_package_id (a_name):
	lines = os.popen (iron_command_name() + ' info ' + a_name).readlines ()
	for line in lines:
		s = trim(line)
		if s.startswith("id:"):
			s = s[3:]
			return trim(s)

def package_name_from_iron_package_file (pf):
	import re
	pf_name = None

	# import info data from `fn' if exists
	if os.path.exists (pf):
		f = open (pf, 'r')
		txt = f.read()
		f.close()
		regexp = r"\bpackage\s*([a-zA-Z][a-zA-Z0-9_+-]+)\b"
		p = re.compile (regexp);
		result = p.search (txt,0)
		if result:
			pf_name = result.group(1)
	return pf_name

def get_ise_libraries(basedir, v):
	if v == 'trunk':
		branch_dir="https://svn.eiffel.com/eiffelstudio/trunk"
	else:
		branch_dir="https://svn.eiffel.com/eiffelstudio/branches/Eiffel_%s" % (v)

	print "Getting source code from %s ..." % (branch_dir)

	d = os.path.join (basedir, "library")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "%s/Src/library" % (branch_dir), d ])

	shutil.rmtree (os.path.join (d, "obsolete"))
	shutil.rmtree (os.path.join (d, "wizard"))
	shutil.rmtree (os.path.join (d, "base", "test"))
	shutil.rmtree (os.path.join (d, "base", "testing"))
	alter_folder_with (os.path.join (d, "library", "vision2"), os.path.join (basedir, "..", "alter", "library", "vision2"))

	d = os.path.join (basedir, "C_library")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "%s/Src/C_library" % (branch_dir), d ])
	shutil.rmtree (os.path.join (d, "openssl"))
	shutil.rmtree (os.path.join (d, "curl"))
	os.remove (os.path.join (d, "build.eant"))
	alter_folder_with (d, os.path.join (basedir, "..", "alter", "C_library"))

	d = os.path.join (basedir, "contrib")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "%s/Src/contrib" % (branch_dir), d ])

	d = os.path.join (basedir, "unstable")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "%s/Src/unstable" % (branch_dir), d ])

def alter_folder_with (a_source, a_alter):
	print "Altering %s with %s." % (a_source, a_alter)
	if os.path.exists (a_alter):
		if os.path.exists (a_source):
			names = os.listdir(a_alter)
			for name in names:
				srcname = os.path.join (a_alter, name)
				dstname = os.path.join (a_source, name)
				if os.path.isdir(srcname):
					alter_folder_with (dstname, srcname)
				else:
					shutil.copy2(srcname, dstname)
		else:
			shutil.copytree (a_alter, a_source)

def process_iron_package (ipfn, a_sources_dir, a_packages_dir, u,p,repo,v):
	import re;

	print "----"

	dict={}
	p_name = None
	p_description = None
	p_source = None

	# Guess info fn from `ipfn'
	fn = "%s.info" % (os.path.join (a_packages_dir, os.path.basename (os.path.dirname (ipfn))))

	# import info data from `fn' if exists
	if os.path.exists (fn):
		f = open (fn, 'r')
		l_lines = re.split ('\n', f.read())
		f.close()
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
	else:
		p_name = package_name_from_iron_package_file (ipfn)
		if p_name == None:
			print "Unable to find package name from associated data file from: [%s] or [%s]" % (fn, ipfn)
			return
		else:
			print "[Warning]: Package [%s] no associated info [%s] for [%s]" % (p_name, fn, ipfn)

	if dict.has_key('name'):
		p_name = trim(dict['name'])

	if dict.has_key ('description'):
		p_description = trim(dict['description'])
		if len(p_description) == 0:
			p_description = None

#	if dict.has_key ('source'):
#		p_source = trim(dict['source'])
#		if len(p_source) == 0:
#			p_source = None

	p_source = os.path.normpath(os.path.dirname(ipfn))


	iron_create_cmd = "%s share create -u %s -p %s --repository %s --batch --package %s " % (iron_command_name(), u, p, repo, ipfn)
	iron_update_cmd = "%s share update -u %s -p %s --repository %s --batch --package %s " % (iron_command_name(), u, p, repo, ipfn)

	cmd = "%s" % (iron_create_cmd)
	if p_description != None:
		cmd = "%s --package-description \"%s\" " % (cmd, p_description)
		#call([iron_command_name(), 'share', 'create', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name, '--package-description', p_description], shell=True, stdout=sys.stdout)
	#else:
		#call([iron_command_name(), 'share', 'create', '-u', u, '-p', p, '--repository', repo, '--batch', '--package-name', p_name], shell=True, stdout=sys.stdout)
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
					cmd_call ("./iron/spec/unix/bin/iron_build_archive  %s %s %s" % (l_src, l_folder, "archive"))
					print ""
		else:
			cmd = "%s --force --package-archive-source \"%s\" " % (iron_update_cmd, l_src)
			cmd_call (cmd)
			print ""

	if not dict.has_key ('maps'):
		if p_source != None:
			p_sources_dir = os.path.normpath(a_sources_dir)
			if p_source.startswith (p_sources_dir):
				p_source = p_source[len(p_sources_dir) + 1:]
			m = p_source.replace ('\\', '/')
			m = "/com.eiffel/%s" % (m)
			print m
			dict['maps'] = [m]
	if dict.has_key ('maps'):
		p_maps = dict['maps']
		if len(p_maps) > 0:
			for m in p_maps:
				cmd = "%s --index \"%s\" " % (iron_update_cmd, m)
				cmd_call (cmd)
				print ""
				
def process_iron_package_files(a_dir, a_sources_dir, a_packages_dir, a_login, a_password, a_repo, a_version):
	l_nodes = os.listdir (a_dir)
	l_iron_package_found=False
	l_dirs=[]
	#print (a_dir)
	for f in l_nodes:
		ff = os.path.join (a_dir, f)
		if os.path.isdir(ff):
			if not f.startswith('.'):
				l_dirs.append (ff)
		else:
			if f == 'package.iron':
				l_iron_package_found = True
				process_iron_package (ff, a_sources_dir, a_packages_dir, a_login, a_password, a_repo, a_version)
				break
			
	if not l_iron_package_found:
		for d in l_dirs:
			process_iron_package_files(d, a_sources_dir, a_packages_dir, a_login, a_password, a_repo, a_version)

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

	l_sources_dir = os.path.join (l_base_dir, "sources")
	l_packages_dir = os.path.join (l_base_dir, "packages")
	if not os.path.exists (l_sources_dir):
		os.makedirs(l_sources_dir)

	get_ise_libraries(l_sources_dir, repository_cfg.version())
	print "Updating the ecf files for iron packaging ..."
	call([iron_command_name(), "update_ecf", "--save", "-D", "ISE_LIBRARY=%s" % (l_sources_dir), l_sources_dir])

	process_iron_package_files (os.path.join (l_sources_dir, "library"), l_sources_dir, l_packages_dir, l_login, l_password, repo, repository_cfg.version())
	process_iron_package_files (os.path.join (l_sources_dir, "unstable", "library"), l_sources_dir, l_packages_dir, l_login, l_password, repo, repository_cfg.version())
	process_iron_package_files (os.path.join (l_sources_dir, "contrib", "library"), l_sources_dir, l_packages_dir, l_login, l_password, repo, repository_cfg.version())

if __name__ == '__main__':
	main()
	sys.exit()
