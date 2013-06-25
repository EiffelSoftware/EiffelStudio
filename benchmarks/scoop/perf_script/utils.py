import os

def system(cmd, timeout=False):
  ret = os.system(cmd)
  if ret != 0 and not timeout:
    print cmd
    assert(False)

def write_to_file(output, content):
  f = open(output, 'w')
  f.write(content)
  f.close()

def read_from_file(file_name):
  f = open(file_name, 'r')
  content = f.read()
  f.close()
  return content

def read_file_values(file_name):
  result = []
  f = open(file_name, 'r')
  for line in f:
    try:
      value = float(line)
      result.append(value)
    except ValueError:
      f.close()
      return []
  f.close()
  return result

def get_directory(problem):
  directory = "../scoop_%s" % (problem);
  return directory

def is_sequential (variation):
  return  variation.find('seq') >= 0

def is_parallel (variation):
  return  variation.find('par') >= 0

def get_time_output(problem, i, nthreads):
  return "time-%s-%d-%d.out" % (problem, i, nthreads)

def get_mem_output(problem):
  return "mem-%s.out" % (problem)
