#!/usr/bin/python
import sys;
import os;
import shutil;
from subprocess import call
from upload_version import upload_version, iron_config;

def get_ise_libraries(basedir, br, v):
	if br == 'trunk':
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
	d = os.path.join (basedir, "C_library")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "%s/Src/C_library" % (branch_dir), d ])
	shutil.rmtree (os.path.join (d, "openssl"))
	shutil.rmtree (os.path.join (d, "curl"))
	os.remove (os.path.join (d, "build.eant"))
	d = os.path.join (basedir, "contrib")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "%s/Src/contrib" % (branch_dir), d ])
	shutil.rmtree (os.path.join (d, "examples"))
	shutil.rmtree (os.path.join (d, "library", "network", "authentication"))
	shutil.rmtree (os.path.join (d, "library", "web", "framework", "ewf", "obsolete"))

            # Do not include sub packages.
	os.remove (os.path.join (d, "library", "web", "framework", "ewf", "libfcgi", "package.iron"))
	os.remove (os.path.join (d, "library", "web", "framework", "ewf", "text", "encoder", "package.iron"))
	os.remove (os.path.join (d, "library", "web", "framework", "ewf", "wsf_html", "package.iron"))
	os.remove (os.path.join (d, "library", "web", "framework", "ewf", "ewsgi", "package.iron"))
	os.remove (os.path.join (d, "library", "web", "framework", "ewf", "wsf", "package.iron"))

	d = os.path.join (basedir, "unstable")
	if os.path.exists (d):
		call(["svn", "update", d ])
	else:
		call(["svn", "checkout", "%s/Src/unstable" % (branch_dir), d ])
	alter_folder_with (basedir, os.path.join (basedir, "..", "..", "alter"))
	alter_folder_with (basedir, os.path.join (basedir, "..", "alter"))

def alter_folder_with (a_source, a_alter):
	print "Altering %s with %s." % (a_source, a_alter)
	if os.path.exists (a_alter):
		if os.path.exists (a_source):
			names = os.listdir(a_alter)
			for name in names:
				srcname = os.path.join (a_alter, name)
				if name.endswith(".ecf.tpl") or name.endswith(".e.tpl"):
					dstname = os.path.join (a_source, name[:-3])
				else:
					dstname = os.path.join (a_source, name)
				if os.path.isdir(srcname):
					alter_folder_with (dstname, srcname)
				else:
					shutil.copy2(srcname, dstname)
		else:
			shutil.copytree (a_alter, a_source)

				
def main():
	if len(sys.argv) > 1:
		cfg_location = sys.argv[1]
	else:
		cfg_location = "iron.cfg"

	config = iron_config (cfg_location)
	l_version = config['version']
	l_branch = config['branch']
	l_base_dir = os.path.normpath(os.path.abspath (os.path.join ("VERSIONS", l_version)))
	l_sources_dir = os.path.join (l_base_dir, "sources")
	#l_packages_dir = os.path.join (l_base_dir, "packages")
	if not os.path.exists (l_sources_dir):
		os.makedirs(l_sources_dir)
	get_ise_libraries(l_sources_dir, l_branch, l_version)

	print "Upload ISE packages ..."
	upload_version(l_sources_dir, cfg_location)

if __name__ == '__main__':
	main()
	sys.exit()
