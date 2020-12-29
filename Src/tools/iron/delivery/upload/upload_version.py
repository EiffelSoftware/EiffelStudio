#!/usr/bin/python

import sys;
import os;
import shutil;
from subprocess import call

def debug():
	return True;

def trim(s):
	return s.strip()

def pause(m):
	try:
	    input(m)
	except SyntaxError:
	    pass

def module_exists(module_name):
    try:
        __import__(module_name)
    except ImportError:
        return False
    else:
        return True

def cmd_call (cmd):
	print("CMD=%s" % (cmd))
	call(cmd, shell=True, stdout=sys.stdout)

def iron_command_name():
	cmd = 'iron'
	if 'IRON_BIN' in os.environ:
		cmd = os.path.join (os.environ['IRON_BIN'], 'iron')
		if not os.path.exists (cmd):
			cmd = "%s.exe" % (cmd) # For Windows
			if not os.path.exists (cmd):
				cmd = 'iron'
	return cmd

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

	# import info data from `pf' if exists
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

def process_iron_package (ipfn, a_sources_dir, a_cfg_location, u,p,repo,v):
	import re;

	print("----")

	dict={}
	p_name = None
	p_description = None
	p_source = None

	p_name = package_name_from_iron_package_file (ipfn)
	if p_name == None:
		print("Unable to find package name from associated data file from: [%s]" % (ipfn))
		return

	if 'name' in dict:
		p_name = trim(dict['name'])

	if 'description' in dict:
		p_description = trim(dict['description'])
		if len(p_description) == 0:
			p_description = None

#	if 'source' in dict:
#		p_source = trim(dict['source'])
#		if len(p_source) == 0:
#			p_source = None

	p_source = os.path.normpath(os.path.dirname(ipfn))
	iron_opts = " --config %s --batch " % (a_cfg_location)
	#iron_opts = " --config %s -u %s -p \"%s\" --repository %s --batch " % (a_cfg_location, u, p, repo)

	iron_create_cmd = "%s share create %s --package %s " % (iron_command_name(), iron_opts, ipfn)

	iron_update_cmd = "%s share update %s --package %s " % (iron_command_name(), iron_opts, ipfn)

	cmd = "%s" % (iron_create_cmd)
	if p_description != None:
		cmd = "%s --package-description \"%s\" " % (cmd, p_description)
	cmd_call (cmd)

	if p_source != None:
		l_src = os.path.dirname(a_sources_dir)
		for seg in p_source.split('/'):
			l_src = os.path.join (l_src, seg)
		l_src = os.path.normpath (l_src)

		is_process_local_archive = False
		if is_process_local_archive:
			l_id = get_package_id (p_name)
			if l_id == None:
				print("No id for %s" % (p_name))
			else:
				if len (l_id) > 0:
					l_folder =  os.path.join (os.path.abspath('archive'), v, "items", l_id)
					if not os.path.exists (l_folder):
						os.makedirs(l_folder)
					cmd_call ("./iron/spec/unix/bin/iron_build_archive  %s %s %s" % (l_src, l_folder, "archive"))
					print("")
		else:
			cmd = "%s --force --package-archive-source \"%s\" " % (iron_update_cmd, l_src)
			cmd_call (cmd)
			print("")

	if not 'maps' in dict:
		if p_source != None:
			p_sources_dir = os.path.normpath(a_sources_dir)
			if p_source.startswith (p_sources_dir):
				p_source = p_source[len(p_sources_dir) + 1:]
			m = p_source.replace ('\\', '/')
			m = "/com.eiffel/%s" % (m)
			print(m)
			dict['maps'] = [m]
	if 'maps' in dict:
		p_maps = dict['maps']
		if len(p_maps) > 0:
			for m in p_maps:
				cmd = "%s --index \"%s\" " % (iron_update_cmd, m)
				cmd_call (cmd)
				print("")

def process_iron_package_files(a_dir, a_sources_dir, a_cfg_location, a_login, a_password, a_repo, a_version):
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
				process_iron_package (ff, a_sources_dir, a_cfg_location, a_login, a_password, a_repo, a_version)
				break
			
	if not l_iron_package_found:
		for d in l_dirs:
			process_iron_package_files(d, a_sources_dir, a_cfg_location, a_login, a_password, a_repo, a_version)

def iron_config(a_cfg_location):
	import re;
	f = open (a_cfg_location, 'r');
	l_lines = re.split ("\n", f.read())
	f.close ();
	d = {}
	for li in l_lines:
		i = li.find('=')
		if i > 0:
			k = trim(li[:i])
			v = trim(li[i+1:])
			if len(k) > 0 and k[1] != '#':
				d[k]=v

	if 'version' in d:
		l_version = d['version']
	elif 'branch' in d:
		l_version = d['branch']
		d['version'] = l_version
	elif 'repository' in d:
		l_repo = d['repository']
		i = l_repo.rfind('/')
		if i > 0:
			l_version = l_repo[i+1:]
			d['version'] = l_version
	if not 'branch' in d:
		d['branch'] = l_version
	return d

def upload_version(a_sources_dir, a_cfg_location):
	config = iron_config (a_cfg_location)
	l_login = config['username']
	l_password = config['password']
	repo = config['repository']
	l_version = config['version']
	if l_version:
		print("user [%s] on repository [%s]" % (l_login, repo))
		if not os.path.exists (a_sources_dir):
			print("source directory \"%s\" does not exist" % (a_sources_dir))
			sys.exit()

		print("Set IRON_PATH variable")
		l_iron_path = os.path.join (a_sources_dir, ".iron-%s" % (l_version))
		os.environ['IRON_PATH'] = l_iron_path
		if os.path.exists (l_iron_path):
			shutil.rmtree (l_iron_path)

		cmd = "%s repository --add %s" % (iron_command_name(), repo)
		#cmd = "%s repository --remove %s" % (iron_command_name(), repo)
		cmd_call (cmd)

		if debug():
			pause ("Press [ENTER] to start updating ecf files..,")
		print("Updating the ecf files for iron packaging ...")
		cmd = "%s update_ecf --save -D ISE_LIBRARY=%s %s" % (iron_command_name(), a_sources_dir, a_sources_dir)
		cmd_call (cmd)
		#call([iron_command_name(), "update_ecf", "--save", "-D", "ISE_LIBRARY=%s" % (a_sources_dir), a_sources_dir])

		if debug():
			pause ("Press [ENTER] to start uploading..,")
		process_iron_package_files (a_sources_dir, a_sources_dir, a_cfg_location, l_login, l_password, repo, l_version)

	else:
		print("Invalid iron repository url!")


def main():
	if len(sys.argv) > 1:
		l_sources_dir = sys.argv[1]
		if len(sys.argv) > 2:
			cfg_location = sys.argv[2]
		else:
			cfg_location = "iron.cfg"
		upload_version(l_sources_dir, cfg_location)
	else:
		print("Usage: prog source_dir {config_filename}")
		sys.exit()

if __name__ == '__main__':
	main()
	sys.exit()
