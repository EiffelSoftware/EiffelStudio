from problems import *

problems = ["randmat", "thresh", "winnow", "outer", "product"]
# problems = ["randmat", "thresh", "winnow", "outer", "product", "chain"]
threads = [1, 2, 4, 8, 16, 32]
output_dir = "output"


inputs = [
    #ProblemInput(20000, 20000, 666, 1, 1),
    #ProblemInput(20000, 20000, 666, 1, 10000),
    ProblemInput(32, 80, 6, 1, 10),
  ]

class Config:
  def __init__ (self):
    self.problems = problems
    self.inputs = inputs
    self.threads = threads
    self.output_dir = output_dir

cfg = Config ()

def get_problems_with_variations():
  for problem in sorted(cfg.problems):
    yield problem

def get_all():
  for problem in get_problems_with_variations():
    yield problem
