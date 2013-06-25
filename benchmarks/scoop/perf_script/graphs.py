#!/usr/bin/env python
from problems import *
from utils import *
from config import *
import sys
import rpy2.robjects as robjects
robjects.r('library("scales")')
import rpy2.robjects.lib.ggplot2 as ggplot2
ggplot2.theme_set(ggplot2.theme_bw ())
from rpy2.robjects.packages import importr
from rpy2.robjects import FloatVector, StrVector, IntVector, DataFrame

def ggplot2_options ():
  def normal_text():
    return ggplot2.theme_text(family = 'serif', size = 15)
  def bold_text():
    return ggplot2.theme_text(family = 'serif', face = 'bold', size = 15)
  def rotated_text():
    return ggplot2.theme_text(family = 'serif', face = 'bold', 
                              size = 15, angle=90, vjust=0.2)

  return ggplot2.opts (**{'axis.title.x' : ggplot2.theme_blank(),
                          'axis.title.y' : rotated_text(),
                          'axis.text.x' : normal_text(),
                          'axis.text.y' : normal_text(),
                          'legend.title' : bold_text(),
                          'legend.text' : normal_text(),
                          'aspect.ratio' : 0.6180339888,
                          'strip.text.x' : normal_text(),
                          })

#ggplot2.scale_fill_brewer(palette="YlGn")
def ggplot2_colors ():
  return robjects.r('scale_fill_manual(values = c("#ffcb7e", "#1da06b", "#b94646", "#00368a"))')

def pdf_height (): return 3.7
def pdf_width (): return 7

bargraph_dir = os.path.abspath("../time/graph")
pretty_varis = {"seq"      : "Sequential",
                "par"      : "Parallel",
                "expertseq": "Sequential (expert)",
                "expertpar": "Parallel (expert)"
                }
pretty_langs = {"chapel"   : "Chapel",
                "cilk"     : "Cilk",
                "erlang"   : "Erlang",
                "go"       : "Go",
                "scoop"    : "SCOOP",
                "tbb"      : "TBB",
                "ideal"    : "ideal"
                }

def setup():
  importr ('pairwiseCI')
  basis = 'fastest' # p1, seq, fastest
  
  results = get_results()
  return as_dataframe (cfg, results, basis)


def main():
  importr ('pairwiseCI')

  basis = 'fastest' # p1, seq, fastest
  
  results = get_results()
  as_dataframe (cfg, results, basis)

  mww_perf_tests (results)
  bargraph_language (cfg, results[threads[-1]])
  bargraph_variation(cfg, results[threads[-1]])
  bargraph_variation_diff (cfg, results[threads[-1]])
  # speedup_lang_var (cfg, results, basis)
  # speedup_prob_var (cfg, results, basis)
  mem_usage_graph (cfg)
  simple_rank (cfg, results[threads[-1]])
  simple_rank_speedup (cfg, results, basis)
  print_results (results[threads[-1]])
  print_results_speedup (results, basis)
  speedup_diffs (results, basis)

def print_results (values):
  for lang in languages:
    sys.stdout.write ("& " + pretty_langs [lang])
    for prob in ["randmat", "thresh", "winnow", "outer", "product", "chain"]:
      for var in ["seq", "expertseq", "par", "expertpar"]:
        data = FloatVector (values[prob][var][lang][0])
        val = robjects.r['mean'] (data)[0]
        sys.stdout.write (" & " + str (round(val, 1)))
    #for var in ["seq", "expertseq", "par", "expertpar"]:
    #  sum = 0
    #  for prob in ["chain", "outer", "product", "randmat", "thresh", "winnow",]:
    #    data = FloatVector (values[prob][var][lang][0])
    #    val = robjects.r['mean'] (data)[0]
    #    sum = sum + val
    #  sys.stdout.write (" & " + str (round(sum, 1)))
    sys.stdout.write (" \\\\\n")

def speedup_diffs (values, basis):
  r = robjects.r
  speedups = {}
  for var in ['par', 'expertpar']:
    speedups[var] = {}
    for lang in languages:
      speedups[var][lang] = {}
      i = 0
      p1 = 0
      print lang
      for prob in problems:
        i = i + 1
        speedups[var][lang][prob] = []
        base = r.mean (FloatVector (values [cfg.threads[-1]][prob][var.replace ('par','seq')][lang][0]))[0]
        # base with p = 1
        base_p1 = r.mean (FloatVector (values [1][prob][var][lang][0]))[0]
        # use fastest sequential program
        if basis == 'fastest' and base_p1 < base:
          base = base_p1
          p1 = p1 + 1
        elif basis == 'seq':
          pass
        elif basis == 'p1':
          base = base_p1
        
        mn = (r.mean (FloatVector (values[32][prob][var][lang][0])))[0]
        speedups[var][lang][prob].append (float (base) / float (mn))
      print i
      print p1
  langs = []
  probs = []
  diffs  = []
  for lang in languages:
    for prob in problems:
      sp = speedups['par'][lang][prob][0]
      sp_expert = speedups['expertpar'][lang][prob][0]
      diff = (float(sp_expert) / float(sp))

      langs.append (pretty_langs [lang])
      probs.append (prob)
      diffs.append (diff)

  r.pdf ('bargraph-speedup-diff.pdf', height=pdf_height (), width=pdf_width ())
  df = robjects.DataFrame({'Language': StrVector (langs),
                           'Problem': StrVector (probs),
                           'Difference' : FloatVector (diffs),
    })
    
  #print (df)
  gp = ggplot2.ggplot (df)
  
  scale = r('''
xformatter <- function(x) {
  sprintf("%d x", x)
}
scale_y_continuous(labels = xformatter)
''')

  pp = gp + \
      ggplot2.aes_string (x='Problem', y='Difference', fill='Language') + \
      ggplot2.geom_bar (position='dodge', stat='identity') + \
      robjects.r('scale_x_discrete(limits=c("randmat", "thresh", "winnow", "outer", "product", "chain"))') +\
      ggplot2_options () + \
      ggplot2_colors () + \
      r('ylab("Change in speedup")') +\
      scale
#      r('scale_y_continuous(labels = percent_format())')
  pp.plot ()
  r['dev.off']()


def print_results_speedup (values, basis):
  r = robjects.r
  speedups = {}
  for var in ['par', 'expertpar']:
    speedups[var] = {}
    for lang in languages:
      speedups[var][lang] = {}
      for prob in problems:
        speedups[var][lang][prob] = []
        base = r.mean (FloatVector (values [cfg.threads[-1]][prob][var.replace ('par','seq')][lang][0]))[0]
        # base with p = 1
        base_p1 = r.mean (FloatVector (values [1][prob][var][lang][0]))[0]
        # use fastest sequential program
        if basis == 'fastest' and base_p1 < base:
          base = base_p1
        elif basis == 'seq':
          pass
        elif basis == 'p1':
          base = base_p1
        
        mn = (r.mean (FloatVector (values[32][prob][var][lang][0])))[0]
        speedups[var][lang][prob].append (float (base) / float (mn))
        
  for lang in languages:
    sys.stdout.write ("& " + pretty_langs [lang])
    for prob in ["randmat", "thresh", "winnow", "outer", "product", "chain"]:
      for var in ["seq", "expertseq", "par", "expertpar"]:
        try:
          val = speedups[var][lang][prob][0]
          sys.stdout.write (" & " + str (round(float(val), 1)))
        except KeyError:
          sys.stdout.write (" & " + "-")
    #for var in ["seq", "expertseq", "par", "expertpar"]:
    #  sum = 0
    #  if var in ["par", "expertpar"]:
    #    for prob in ["chain", "outer", "product", "randmat", "thresh", "winnow",]:
    #      val = speedups[var][lang][prob][0]
    #      sum = sum + val
    #    sys.stdout.write (" & " + str (round(float(sum)/6, 1)))
    #  else:
    #    sys.stdout.write (" & " + "-")
    sys.stdout.write (" \\\\\n")

def simple_rank (cfg, values):
  print "\nexecution time rank"
  r = robjects.r
  for var in variations:
    print var
    for lang in languages:
      agg = 0
      for prob in problems:
        data = FloatVector (values[prob][var][lang][0])
        val = r['mean'] (data)[0]
        valmin = min ([ (r['mean'] (FloatVector (values[prob][var][l][0])))[0] for l in languages ])
        agg = agg + float (val) / float (valmin)
      agg = agg / len (problems)
      print lang + '\t' + str (round (agg, 1))

def simple_rank_speedup (cfg, values, basis):
  print "\nspeedup rank"
  r = robjects.r
  for var in ['par', 'expertpar']:
    print var
    speedups = {}
    for lang in languages:
      speedups[lang] = {}
      for prob in problems:
        speedups[lang][prob] = []
        base = r.mean (FloatVector (values [cfg.threads[-1]][prob][var.replace ('par','seq')][lang][0]))[0]
        # base with p = 1
        base_p1 = r.mean (FloatVector (values [1][prob][var][lang][0]))[0]
        # use fastest sequential program
        if basis == 'fastest' and base_p1 < base:
          base = base_p1
        elif basis == 'seq':
          pass
        elif basis == 'p1':
          base = base_p1
        
        mn = (r.mean (FloatVector (values[32][prob][var][lang][0])))[0]
        speedups[lang][prob].append (float(mn) / float(base))

    for lang in languages:
      agg = 0
      for prob in problems:
        val = (r.mean (FloatVector (speedups[lang][prob])))[0]
        valmin = min ([ (r.mean (FloatVector (speedups[l][prob])))[0] for l in languages])
        agg = agg + float (val) / float (valmin)
      agg = agg / len (problems)
      print lang + '\t' + str (round (agg, 1))
      
    res = {}
    for lang1 in languages:
      def get_res (lang, prob):
        return speedups[lang][prob]
      lang1_vals = FloatVector([mean (FloatVector(get_res (lang1, prob))) for prob in problems])
      for lang2 in languages:
        lang2_vals = FloatVector([mean (FloatVector(get_res (lang2, prob))) for prob in problems])

        if lang1 not in res:
          res[lang1] = {}
        if lang2 not in res[lang1]:
          res[lang1][lang2] = {}

        pval = (r['wilcox.test'] (lang1_vals, lang2_vals, paired = True))[2][0]
        if lang1 == lang2:
          res[lang1][lang2] = 0
        else:
          res[lang1][lang2] = pval
          
    print var
    print languages
    for lang1 in languages:
      sys.stdout.write (pretty_langs [lang1])
      for lang2 in languages:
        if lang1 == lang2:
          sys.stdout.write (" &       ")
        else:
          sys.stdout.write (" & " + str (round(res[lang1][lang2], 3)) + "  ")
      sys.stdout.write ("\\\\\n")


def mww_perf_tests (results):
  r = robjects.r

  res = {}
  for var in variations:
    for lang1 in languages:
      def get_res (lang, prob):
        return results [threads[-1]][prob][var][lang][0]
      lang1_vals = FloatVector([mean (FloatVector(get_res (lang1, prob))) for prob in problems])
      for lang2 in languages:
        lang2_vals = FloatVector([mean (FloatVector(get_res (lang2, prob))) for prob in problems])

        if lang1 not in res:
          res[lang1] = {}
        if lang2 not in res[lang1]:
          res[lang1][lang2] = {}

        pval = (r['wilcox.test'] (lang1_vals, lang2_vals, paired = True))[2][0]
        if lang1 == lang2:
          res[lang1][lang2] = 0
        else:
          res[lang1][lang2] = pval

    # trivial data display
    print var
    print languages
    for lang1 in languages:
      sys.stdout.write (pretty_langs [lang1])
      for lang2 in languages:
        if lang1 == lang2:
          sys.stdout.write (" &        ")
        else:
          sys.stdout.write (" & " + str (round(res[lang1][lang2], 3)) + "  ")
      sys.stdout.write("\\\\\n")

def get_results():
  results = {}
  for nthreads in threads:
    if nthreads not in results:
      results[nthreads] = {}
    for (language, problem, variation) in get_all():
      if is_sequential (variation) and nthreads != threads[-1]: continue
      if problem not in results[nthreads]:
        results[nthreads][problem] = {}
      if variation not in results[nthreads][problem]:
        results[nthreads][problem][variation] = {}
      if language not in results[nthreads][problem][variation]:
        results[nthreads][problem][variation][language] = {}

      for i in range(len(inputs)):
        time_output = get_time_output(
            language, problem, variation, i, nthreads)
        cur = read_file_values(time_output)

        results[nthreads][problem][variation][language][i] = cur
  return results

def mem_usage_graph (cfg):
  r = robjects.r
  varis = []
  langs = []
  probs = []
  mems  = []
  for var in cfg.variations:
    for lang in cfg.languages:
      for prob in cfg.problems:
        mem_filename = get_mem_output (lang, prob, var)
        with open (mem_filename, 'r') as mem_file:
          mem = mem_file.readline()
          mems.append (float (mem))
        varis.append (pretty_varis [var])
        langs.append (pretty_langs [lang])
        probs.append (prob)

  # memory usage is a simple histogram with all information in one graph.
  r.pdf ('bargraph-memusage.pdf', height=pdf_height (), width=pdf_width ())
  df = robjects.DataFrame({'Language': StrVector (langs),
                           'Problem': StrVector (probs),
                           'Variation' : StrVector (varis),
                           'Mem' : FloatVector (mems)
                           })

  gp = ggplot2.ggplot (df)

  # we rotate the x labels to make sure they don't overlap
  pp = gp  +\
      ggplot2.opts (**{'axis.text.x': ggplot2.theme_text (angle = 90, hjust=1)}) + \
      ggplot2.aes_string (x='Problem', y='Mem', fill='Language') + \
      ggplot2.geom_bar (position='dodge', stat='identity') + \
      ggplot2.facet_wrap ('Variation') + \
      ggplot2_options () + \
      ggplot2_colors () + \
      robjects.r('scale_x_discrete(limits=c("randmat", "thresh", "winnow", "outer", "product", "chain"))') +\
      robjects.r('ylab("Memory usage (in bytes)")')# + \

  pp.plot ()
  r['dev.off']()

# fieller's method for calculating confidence intervals
# for ratios of means.
def fieller (aa, bb):
  mean_a = r.mean (aa)
  mean_b = r.mean (bb)

  q   = mean_a/mean_b

  sem_a = r.sd (aa) / sqrt (len (aa))
  sem_b = r.sd (bb) / sqrt (len (bb))

  t   = r.qt (0.975, len (aa))
  se_q = q * sqrt (sem_a**2/mean_a**2 + sem_b**2/mean_b**2)

  return (q - t * se_q, q + t * se_q)

def bargraph_language (cfg, values):
  r = robjects.r
  for lang in cfg.languages:
    times = []
    varss = []
    probs = []
    ses   = []

    for prob in cfg.problems:
      for var in cfg.variations:
        # we use the pretty names to make the 
        varss.append (pretty_varis [var])
        probs.append (prob)

        data = FloatVector (values[prob][var][lang][0])
        times.append (r['mean'] (data)[0])

        t_result = r['t.test'] (data, 
                                **{" conf.level": 0.999}).rx ('conf.int')[0]
        ses.append ((t_result[1] - t_result[0])/2)



    r.pdf ('bargraph-executiontime-lang-' + lang + '.pdf', 
           height=pdf_height (), width=pdf_width ())
    df = robjects.DataFrame({'Variation': StrVector (varss),
                             'Problem': StrVector (probs),
                             'Time' : FloatVector (times),
                             'SE' : FloatVector (ses)
                             })

    limits = ggplot2.aes (ymax = 'Time + SE', ymin = 'Time - SE')
    dodge = ggplot2.position_dodge (width=0.9)

    gp = ggplot2.ggplot (df)

    pp = gp + \
        ggplot2.aes_string (x='Problem', y='Time', fill='Variation') + \
        ggplot2.geom_bar (position='dodge', stat='identity') + \
        ggplot2.geom_errorbar (limits, position=dodge, width=0.25) + \
        ggplot2_options () + \
        ggplot2_colors () + \
        robjects.r('scale_x_discrete(limits=c("randmat", "thresh", "winnow", "outer", "product", "chain"))') +\
        robjects.r('ylab("Execution time (in seconds)")') 
    pp.plot ()
    r['dev.off']()


def bargraph_variation (cfg, values):
  r = robjects.r
  for var in cfg.variations:
    # each variation gets plot
    avgs = []
    ses = []

    # normalized values
    navgs = []
    nses = []

    langs = []
    probs = []

    for prob in cfg.problems:
      # aggregate by problems
      lavgs = []
      lses = []
      for lang in cfg.languages:
        # each problem displays a list of language times for that problem
        data = FloatVector (values[prob][var][lang][0])
        
        langs.append (pretty_langs [lang])
        probs.append (prob)
        mean = r['mean'] (data)[0]
        lavgs.append (mean)

        t_result = r['t.test'] (data, **{"conf.level": 0.999}).rx ('conf.int')[0]
        lses.append ((t_result[1] - t_result[0])/2)
        
      avgs.extend (lavgs)
      ses.extend (lses)
        
      lmin = min (lavgs)
      navgs.extend ([la/lmin for la in lavgs])
      nses.extend ([ls/lmin for ls in lses])


    df = robjects.DataFrame({'Language': StrVector (langs),
                             'Problem': StrVector (probs),
                             'Time' : FloatVector (avgs),
                             'SE' : FloatVector (ses),
                             'NormTime' : FloatVector (navgs),
                             'NormSE' : FloatVector (nses),
                             'TimeLabel' : StrVector ([str(round(time, 1)) + "s" for time in avgs])
                             })

    # plot histogram of actual times
    r.pdf ('bargraph-executiontime-var-' + var + '.pdf', height=pdf_height (), width=pdf_width ())


    limits = ggplot2.aes (ymax = 'Time + SE', ymin = 'Time - SE')
    dodge = ggplot2.position_dodge (width=0.9)
    gp = ggplot2.ggplot (df)

    pp = gp + \
        ggplot2.aes_string (x='Problem', y='Time', fill='Language') + \
        ggplot2.geom_bar (position='dodge', stat='identity') + \
        ggplot2.geom_errorbar (limits, position=dodge, width=0.25) + \
        ggplot2_options () + \
        ggplot2_colors () + \
        robjects.r('scale_x_discrete(limits=c("randmat", "thresh", "winnow", "outer", "product", "chain"))') +\
        robjects.r('ylab("Execution time (in seconds)")')
 
    pp.plot ()

    # plot histogram of times normalized with respect to fastest time for a problem
    r.pdf ('bargraph-executiontime-var-norm-' + var + '.pdf', height=pdf_height (), width=pdf_width ())

    limits = ggplot2.aes (ymax = 'NormTime + NormSE', ymin = 'NormTime - NormSE')
    dodge = ggplot2.position_dodge (width=0.9)
    gp = ggplot2.ggplot (df)

    pp = gp + \
        ggplot2.aes_string (x='Problem', y='NormTime', fill='Language') + \
        ggplot2.geom_bar (position='dodge', stat='identity') + \
        ggplot2.geom_errorbar (limits, position=dodge, width=0.25) +\
        ggplot2_options () + \
        ggplot2_colors () + \
        robjects.r('scale_x_discrete(limits=c("randmat", "thresh", "winnow", "outer", "product", "chain"))') +\
        robjects.r('ylab("Execution time (normalized to fastest)")')
        #ggplot2.geom_text(data=df,
        #                  mapping = ggplot2.aes_string (x='Problem', 
        #                                                y='NormTime + NormSE + 0.1', 
        #                                                label='TimeLabel')
 
    pp.plot ()
    r['dev.off']()

def bargraph_variation_diff (cfg, values):
  r = robjects.r

  for (standard, expert) in [('seq', 'expertseq'), ('par', 'expertpar')]:
    langs = []
    probs = []
    diffs  = []
    for lang in cfg.languages:
      for prob in cfg.problems:
        data = FloatVector (values[prob][standard][lang][0])
        data_expert = FloatVector (values[prob][expert][lang][0])

        mean = r['mean'] (data)[0]
        mean_expert = r['mean'] (data_expert)[0]
        diff = (float(mean_expert) / float(mean) - 1)

        langs.append (pretty_langs [lang])
        probs.append (prob)
        diffs.append (diff)

    r.pdf ('bargraph-executiontime-diff-' + standard + '.pdf', height=pdf_height (), width=pdf_width ())
    df = robjects.DataFrame({'Language': StrVector (langs),
                             'Problem': StrVector (probs),
                             'Difference' : FloatVector (diffs),
      })
    
    #print (df)
    gp = ggplot2.ggplot (df)
  
    pp = gp + \
        ggplot2.aes_string (x='Problem', y='Difference', fill='Language') + \
        ggplot2.geom_bar (position='dodge', stat='identity') + \
        ggplot2_options () + \
        ggplot2_colors () + \
        robjects.r('scale_x_discrete(limits=c("randmat", "thresh", "winnow", "outer", "product", "chain"))') +\
        robjects.r('ylab("Execution time difference (in percent)")') +\
        robjects.r('scale_y_continuous(labels = percent_format())')
    pp.plot ()
    r['dev.off']()


# produce a graph for each langauge/variation that shows 
# the speed up for each problem

# produce a graph for each problem/variation that shows all languages
# speedup
def speedup_prob_var (cfg, values, basis):
  for var in cfg.variations:
    if var.find ('par') >= 0:
      r = robjects.r

      r.pdf ('speedup-' + var + '-' + control + '.pdf', 
             height=pdf_height (), width=pdf_width ())

      for prob in cfg.problems:
        base_selector = lambda lang:\
          values [cfg.threads[-1]][prob][var.replace ('par','seq')][lang][0]

        selector = lambda lang: lambda thread:\
            values [thread][prob][var][lang][0]
        line_plot (cfg, var, prob, 'Language', cfg.languages, selector, base_selector, basis)

# produce a graph for each language/variation that shows all problems
# speedups
def speedup_lang_var (cfg, values, basis):
  for var in cfg.variations:
    if var.find ('par') >= 0:

      for lang in cfg.languages:
        base_selector = lambda prob:\
          values [cfg.threads[-1]][prob][var.replace ('par','seq')][lang][0]

        selector = lambda prob: lambda thread:\
            values [thread][prob][var][lang][0]
        line_plot (cfg, var, lang, 'Problem', cfg.problems, selector, base_selector, basis)


def as_dataframe (cfg, results, basis):
  r = robjects.r
  varis = []
  langs = []
  probs = []
  times = []
  threads = []

  # speedups, with upper and lower bounds below
  speedups = [] 
  speedup_lowers = []
  speedup_uppers = []

  ses = [] # standard errors
  mems = [] # memory usage

  langs_ideal = list (cfg.languages)
  langs_ideal.append ('ideal')

  probs_ideal = list (cfg.problems)
  probs_ideal.append ('ideal')

  for var in cfg.variations:
    for lang in langs_ideal: # cfg.languages:
      for prob in probs_ideal: # cfg.problems:
        for thread in cfg.threads:

          if lang == 'ideal' and prob == 'ideal':
            continue
          elif lang == 'ideal' or prob == 'ideal':
            varis.append (var)
            langs.append (pretty_langs[lang])
            probs.append (prob)
            threads.append (thread)
            speedups.append (thread)
            speedup_lowers.append (thread)
            speedup_uppers.append (thread)
            times.append (0)
            ses.append(0)
            mems.append (0)
            continue

          varis.append (var) # pretty_varis [var])
          langs.append (pretty_langs [lang])
          probs.append (prob)
          threads.append (thread)
          
          if var.find('seq') >= 0:
            thread = cfg.threads[-1]

          vals = FloatVector (results[thread][prob][var][lang][0])
          time = mean (vals)
          times.append (time)

          #
          # time confidence interval
          #
          t_result = r['t.test'] (FloatVector(vals), 
                                  **{" conf.level": 0.999}).rx ('conf.int')[0]
          ses.append ((t_result[1] - t_result[0])/2)

          #
          # memory usage
          #
          mem_filename = get_mem_output (lang, prob, var)
          with open (mem_filename, 'r') as mem_file:
            mem = mem_file.readline()
            mems.append (float (mem))

          # we include dummy data for the sequential case to avoid the 
          # speedup calculation below
          if var.find('seq') >= 0:
            speedups.append (1)
            speedup_lowers.append (1)
            speedup_uppers.append (1)
            continue
            
          #
          # speedup values and confidence intervals
          #
          seq_vals = results[cfg.threads[-1]][prob][var.replace ('par', 'seq')][lang][0]

          # sequential base
          base = FloatVector (seq_vals)
          # base with p = 1
          base_p1 = FloatVector (results[1][prob][var][lang][0])
          # use fastest sequential program
          if basis == 'fastest' and mean (base_p1) < mean(base):
            base = base_p1
          elif basis == 'seq':
            pass
          elif basis == 'p1':
            base = base_p1
      

          labels = ['Base'] * r.length(base)[0] + ['N']*r.length (vals)[0]
          df = DataFrame ({'Times': base + vals, 
                           'Type': StrVector(labels)})
          ratio_test = r['pairwiseCI'] (r('Times ~ Type'), data=df,
                                        control='N',
                                        method='Param.ratio',
                                        **{'var.equal': False})[0][0]

          speedups.append (mean(base) / time)
          speedup_lowers.append (ratio_test[1][0])
          speedup_uppers.append (ratio_test[2][0])

  df = robjects.DataFrame({'Language': StrVector (langs),
                           'Problem': StrVector (probs),
                           'Variation' : StrVector (varis),
                           'Threads': IntVector (threads),
                           
                           'Time': FloatVector (times),
                           'SE': FloatVector (ses),
                           
                           'Speedup': FloatVector (speedups),
                           'SpeedupLower': FloatVector (speedup_lowers),
                           'SpeedupUpper': FloatVector (speedup_uppers),
                           
                           'Mem' : FloatVector (mems)
                           })


  r.assign ('df', df)

  r ('save (df, file="performance.Rda")')
  
  # reshape the data to make variation not a column itself, but a part of
  # the other columns describe ie, time, speedup, etc.
  #
  # also, remove the 'ideal' problem as we don't want it in this plot.
  df = r('''
redf = reshape (df, 
                timevar="Variation", 
                idvar = c("Language","Problem","Threads"), 
                direction="wide")
redf$Problem <- factor(redf$Problem, levels = c("randmat","thresh","winnow","outer","product","chain"))
redf[which(redf$Problem != "ideal"),]
''')
  
  r.pdf ('speedup-expertpar-all.pdf',
         height=6.5, width=10)

  change_name = 'Language'

  legendVec = IntVector (range (len (langs_ideal)))
  legendVec.names = StrVector (langs_ideal)

  gg = ggplot2.ggplot (df)

  limits = ggplot2.aes (ymax = 'SpeedupUpper.expertpar', ymin = 'SpeedupLower.expertpar')
  dodge = ggplot2.position_dodge (width=0.9)

  pp = gg + \
      ggplot2.geom_line() + ggplot2.geom_point(size=2.5) +\
      robjects.r('scale_color_manual(values = c("#ffcb7e", "#1da06b", "#b94646", "#00368a", "#CCCCCC"))') +\
      ggplot2.aes_string(x='Threads', y='Speedup.expertpar', 
                         group=change_name, color=change_name, 
                         shape=change_name) + \
      ggplot2.geom_errorbar (limits, width=0.25) + \
      ggplot2.opts (**{'axis.title.x' : ggplot2.theme_text(family = 'serif', face = 'bold', size = 10, vjust=-0.2),
                       'axis.title.y' : ggplot2.theme_text(family = 'serif', face = 'bold', size = 10, angle=90, vjust=0.2),
                       'axis.text.x' : ggplot2.theme_text(family = 'serif', size = 10),
                       'axis.text.y' : ggplot2.theme_text(family = 'serif', size = 10),
                       'legend.title' : ggplot2.theme_text(family = 'serif', face = 'bold', size = 10),
                       'legend.text' : ggplot2.theme_text(family = 'serif', size = 10),
                       'strip.text.x' : ggplot2.theme_text(family = 'serif', size = 10),
                       'aspect.ratio' : 1,
                       }) + \
      robjects.r('ylab("Speedup")') + \
      robjects.r('xlab("Number of cores")') + \
      ggplot2.facet_wrap ('Problem', nrow = 2)

  pp.plot()

  r['dev.off']()

#   r.assign ('df', df)

#   r ('save (df, file="performance.Rda")')
#   df = r('''
# redf = reshape (df, timevar="Variation", idvar = c("Language","Problem","Threads"), direction="wide")

# min ((redf [which(redf$Threads == %(threads) & redf$Problem == %(prob)),][c("Threads", "Language","Problem", "Time.expertpar")])$Time.expertpar)
# ''')
  
  # use merge to put new information into tables with tips from:
  # http://stackoverflow.com/questions/8594747/replacing-certain-values-in-data-frame-in-r
  # post processing:
  #  - for a particular variation/problem divide by the fastest language for 
  #    the normalized graphs
  #  - take a diff between memory usage and time

# Function to plot lines for a given dataset. Here these
# datasets will be either per-problem or per-language.
def line_plot (cfg, var, control, change_name, changing, selector, base_selector, basis):
  speedups = []
  thrds = []
  changes = []
  lowers = []
  uppers = []

  for n in cfg.threads:
    probs.append ('ideal')
    langs.append ('ideal')
    speedups.append (n)
    thrds.append (n)
    changes.append ('ideal')
    lowers.append (n)
    uppers.append (n)
    
  for c in changing:
    sel  = selector (c)

    # sequential base
    base = FloatVector (base_selector(c))
    # base with p = 1
    base_p1 = FloatVector (sel(1))
    # use fastest sequential program
    if basis == 'fastest' and mean (base_p1) < mean(base):
      base = base_p1
    elif basis == 'seq':
      pass
    elif basis == 'p1':
      base = base_p1
      
    for n in cfg.threads:
      ntimes = FloatVector (sel(n))

      # ratio confidence interval
      labels = ['Base'] * r.length(base)[0] + ['N']*r.length (ntimes)[0]
      df = DataFrame ({'Times': base + ntimes, 
                       'Type': StrVector(labels)})
      ratio_test = r['pairwiseCI'] (r('Times ~ Type'), data=df,
                                    control='N',
                                    method='Param.ratio',
                                    **{'var.equal': False,
                                    'conf.level': 0.999})[0][0]

      lowers.append (ratio_test[1][0])
      uppers.append (ratio_test[2][0])

      mn = mean (ntimes)      
      speedups.append (mean(base) / mn)
      # plot slowdowns
      #speedups.append (-mn/base)#(base / mn)
      thrds.append (n)
      if change_name == 'Language':
        changes.append (pretty_langs [c])
      else:
        changes.append (c)

  df = DataFrame ({'Speedup': FloatVector (speedups),
                   'Threads': IntVector (thrds),
                   change_name: StrVector (changes),
                   'Lower': FloatVector (lowers),
                   'Upper': FloatVector (uppers)
                   })
  ideal_changing = ['ideal']
  if change_name == 'Language':
    ideal_changing.extend ([pretty_langs [c] for c in changing])
  else:
    ideal_changing.extend (changing)

  legendVec = IntVector (range (len (ideal_changing)))
  legendVec.names = StrVector (ideal_changing)

  gg = ggplot2.ggplot (df)

  limits = ggplot2.aes (ymax = 'Upper', ymin = 'Lower')
  dodge = ggplot2.position_dodge (width=0.9)

  pp = gg + \
      ggplot2.geom_line() + ggplot2.geom_point(size=3) +\
      ggplot2.aes_string(x='Threads', y='Speedup', 
                         group=change_name, color=change_name, 
                         shape=change_name) + \
      ggplot2.scale_shape_manual(values=legendVec) + \
      ggplot2.geom_errorbar (limits, width=0.25) + \
      ggplot2_options () + \
      ggplot2_colors () + \
      ggplot2.opts (**{'axis.title.x' : ggplot2.theme_text(family = 'serif', face = 'bold', size = 15, vjust=-0.2)}) + \
      robjects.r('ylab("Speedup")') + \
      robjects.r('xlab("Cores")')

      # ggplot2.xlim (min(threads), max(threads)) + ggplot2.ylim(min(threads), max(threads)) +\
  pp.plot()

  r['dev.off']()

def mean (xs):
  return robjects.r.mean (xs)[0]

if __name__ == '__main__':
  main ()

