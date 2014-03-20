
import os
import os.path
import platform
import sys
import time
import shutil
import subprocess
import argparse
import difflib

# ----------------------------------------------------------------------------
# paths
# ----------------------------------------------------------------------------

base_path = os.path.realpath(os.path.join(os.getenv("EIFFEL_SRC"), "framework", "code_analysis", "tests"))
eve_exe = os.path.realpath(os.path.join(os.getenv("EIFFEL_SRC"), "Eiffel", "Ace", "EIFGENs", "bench", "W_code", "ec.exe"))
tests_ecf = os.path.join(base_path, "tests.ecf")
store_output = False

oracle_file = "output_oracle.txt"
test_output_file = "test_output.txt"

# ----------------------------------------------------------------------------
# helper functions: log and printing
# ----------------------------------------------------------------------------

# clear log file
open("log.txt", 'w').close()
# open log file
_log_file = open("log.txt", 'w')

_has_colorama = False
try:
	from colorama import init, Fore, Back, Style
	init()
	_has_colorama = True
except ImportError:
	pass

def _to_logfile(text):
	_log_file.write(time.strftime('%H:%M:%S', time.gmtime(time.clock())))
	_log_file.write("  ---  ")
	_log_file.write(text)
	_log_file.write("\n")
	_log_file.flush()

def _as_info(text, pre=''):
	print(pre + text)
	_to_logfile(pre + text)

def _as_warning(text, pre=''):
	if _has_colorama:
		print(pre + Back.YELLOW + Fore.YELLOW + Style.BRIGHT + text + Style.RESET_ALL)
	else:
		print(pre + text)
	_to_logfile(pre + text)

def _as_error(text, pre=''):
	if _has_colorama:
		print(pre + Back.RED + Fore.RED + Style.BRIGHT + text + Style.RESET_ALL)
	else:
		print(pre + text)
	_to_logfile(pre + text)

def _as_success(text, pre=''):
	if _has_colorama:
		(pre + Back.GREEN + Fore.GREEN + Style.BRIGHT + text + Style.RESET_ALL)
	else:
		print(pre + text)
	_to_logfile(pre + text)


# ----------------------------------------------------------------------------
# helper functions: compiling and running
# ----------------------------------------------------------------------------

def delete_path(path):
	result = False
	if os.path.isdir(path):
		shutil.rmtree(path, ignore_errors=False, onerror=handleRemoveReadonly)
	elif os.path.isfile(path):
		os.remove(path)
	if os.path.exists(path):
		_as_error("Unable to delete '" + path + "'")
	else:
		result = True
	return result

def handleRemoveReadonly(func, path, exc):
	import stat
	excvalue = exc[1]
	if func in (os.rmdir, os.remove) and excvalue.errno == errno.EACCES:
		os.chmod(path, stat.S_IRWXU| stat.S_IRWXG| stat.S_IRWXO) # 0777
		func(path)
	else:
		raise

def execute(program, output_file = None):
	if isinstance(output_file, str):
		pipe = open(output_file, 'a')
	else:
		pipe = output_file
	proc = subprocess.Popen(program, stdin=pipe, stdout=pipe, stderr=pipe)
	proc.communicate()
	if isinstance(output_file, str):
		pipe.close()
	return proc.returncode

def compile_tests():
	global _log_file, base_path, eve_exe, tests_ecf
	_as_info("Compiling tests")
	if os.path.isfile(tests_ecf):
		delete_path(os.path.join(base_path, "EIFGENs", "tests"))
		olddir = os.getcwd()
		os.chdir(os.path.dirname(base_path))
		code = execute([eve_exe, "-config", tests_ecf, "-target", "tests", "-batch"], _log_file)
		os.chdir(olddir)
		if code == 0:
			_as_success("Compilation of tests successful")
		else:
			_as_error("Compilation of tests failed")
	else:
		_as_error("ECF file '" + tests_ecf + "' does not exist")

def is_test_path(path):
	if not os.path.isdir(path):
		return False
	if not os.path.isfile(os.path.join(path, oracle_file)):
		return False
	return True

def find_test(test, directory=None):
	global base_path
	if directory is None:
		directory = base_path
	for name in os.listdir(directory):
		temp = os.path.join(directory, name)
		if name == test and is_test_path(temp):
			return temp
		elif os.path.isdir(temp):
			temp2 = find_test(test, temp)
			if not temp2 is None:
				return temp2
	return None

def run_tests(directory=None):
	global base_path
	if directory is None:
		directory = base_path
	for test_name in os.listdir(directory):
		path = os.path.join(directory, test_name)
		if os.path.isdir(path):
			if is_test_path(path):
				run_test(path, test_name)
			elif not path.endswith("EIFGENs"):
				run_tests(path)

# Run a single test case
def run_test(path, test_name):
	global eve_exe, tests_ecf, store_output
	if not path is None and os.path.isdir(path):
		_as_info("Running test: " + test_name)
		args = [eve_exe, "-config", tests_ecf, "-target", "tests", "-code-analysis", "-cadefaults", "-caclasses"]
		classes = []
		for filename in os.listdir(path):
			if filename.endswith(".e"):
				class_name = os.path.splitext(os.path.basename(filename))[0]
				classes.append(class_name.upper())
			elif filename.endswith("args.txt"):
				_as_info("  command line options: " + open(os.path.join(path, filename)).readline())
				args.extend(open(os.path.join(path, filename)).readline().split(" "))
		args.extend(classes)

		# clear output file
		open(test_output_file, 'w').close()
		execute(args, test_output_file)
		
		output_file = open(test_output_file, 'r')
		output_content = output_file.read()
		output_content = output_content.partition("System Recompiled.\n")[2].strip()
		output_file.close()
		
		if store_output:
			output_file = open(os.path.join(path, oracle_file), 'w')
			output_file.write(output_content)
			output_file.close()
		
		expected_file = open(os.path.join(path, oracle_file), 'r')
		expected_content = expected_file.read().strip()
		expected_file.close()
		
		if output_content == expected_content:
			_as_success(test_name + ": successful")
		else:
			_as_error(test_name + ": failed")
			for line in difflib.unified_diff(output_content.split("\n"), expected_content.split("\n")):
				_as_info(line)
	else:
		_as_error("test '" + test_name + "' does not exist")



# ----------------------------------------------------------------------------
# parse arguments and execute actions
# ----------------------------------------------------------------------------

parser = argparse.ArgumentParser()
parser.add_argument('--clean', '-c', action='store_true')
parser.add_argument('--store', '-s', action='store_true')
parser.add_argument('tests', nargs=argparse.REMAINDER)

arguments = parser.parse_args()

if arguments.clean:
	compile_tests()
if arguments.store:
	store_output = True

if len(arguments.tests) == 0:
	run_tests()
else:
	for t in arguments.tests:
		run_test(find_test(t), t)
