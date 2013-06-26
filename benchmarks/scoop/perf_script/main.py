#!/usr/bin/env python
import os
import math
import time
import csv

from subprocess import Popen, call, PIPE

from problems import *
from utils import *
from config import *

def make_all():
  for problem in get_all():
    directory = get_directory(problem)
    cmd = "cd %s && make main" % directory
    print cmd
    system(cmd)

def create_inputs():
  for i in range(len(problem_classes)):
    problem = problem_classes[i]
    for j in range(len(inputs)):
      cur = inputs[j]
      file_name = problem.input_file_name(cur)
      write_to_file(file_name, problem.get_input(cur))

def run_one(params, nthreads, problem):
  cmd = ""
  env = ""

  cmd += "taskset "
  if nthreads == 1:
    cmd += "-c 0 "
  else:
    cmd += "-c 0-%d " % (nthreads - 1)
          
  directory = get_directory(problem)

  cmd += directory + '/' + "main -bench -i"
  cmd += " " + problem_map[problem].input_file_name(params)

  cmd = env + '/usr/bin/time -f "%M" ' + cmd

  # print cmd

  t1 = time.time ()

  proc = Popen (cmd, stdout=PIPE, stderr=PIPE, shell=True)
  (out, mem_usage) = proc.communicate ()

  t2 = time.time ()
  tdiff = t2 - t1

  # divide GNU time memory measurement by 4 if it's GNU time V1.7
  result = (tdiff, float (mem_usage.strip()) / 4)

  print ("Problem: " + problem + " Cores: " + str(nthreads) + \
    " Time: " + str(tdiff))

  return result

def run_all(csv_writer, params, redirect_output=True):
  for problem in get_all():
    for nthreads in threads:
      (time, mem_usage) = run_one(params, nthreads, problem)
      csv_writer.writerow([problem, nthreads, time, mem_usage])


TOTAL_EXECUTIONS = 3

def svn_version():
  p = Popen('svnversion -n', shell=True, stdout=PIPE, stderr=PIPE)
  (stdout, stderr) = p.communicate()
  if stdout.find("Unversioned") >= 0:
    stdout = "unversioned"

  return stdout

def param_file_str(param):
  return "_".join([str(param.nrows),
                   str(param.ncols),
                   str(param.seed),
                   str(param.percent),
                   str(param.nelts)
                 ])

def main():
  print "Building all programs"
  make_all()
  print "Creating inputs"
  create_inputs()
  print "Running tests"

  revision = svn_version()
  d = "rev_" + str(revision)

  if not os.path.exists(d):
    os.makedirs(d)

  for param in inputs:
    csv_file = "result_" + param_file_str(param) + ".csv"

    csv_path = os.path.join(d, csv_file)
  
    with open(csv_path, 'w') as csv_file:
      csv_writer = csv.writer(csv_file)
      for _ in range(TOTAL_EXECUTIONS):
        run_all(csv_writer, param, redirect_output=False)  # TODO: remove outputs

if __name__ == '__main__':
  main()
