

#include <rx/rxposix.h>

regex_t* bw_alloc_reg();
int bw_make_reg(regex_t*,  char*, int, int, int, int);
void bw_free_reg( regex_t*);
int bw_re_nsub( regex_t*);
void bw_free_reg_space( regex_t*);
int bw_match( regex_t*,char*, int, regmatch_t*, int, int);

regmatch_t * bw_alloc_subarray( int sz)
{
  return (regmatch_t*) malloc( sizeof(regmatch_t) * (sz+1) );
}

void bw_free_subarray( regmatch_t * sa)
{
  free (sa);
}

int  bw_start_offset( regmatch_t * sa, int os)
{
  return sa[os].rm_so;
}

int  bw_end_offset( regmatch_t * sa, int os)
{
  return sa[os].rm_eo;
}

int bw_match( regex_t* reg, char* str, int nmatch,
	      regmatch_t* m_ptr, int fl_b, int fl_e)
{
  return regexec(reg, str, nmatch, m_ptr, fl_b | fl_e);
}

int bw_re_nsub( regex_t* reg)
{
  return  reg -> re_nsub;
}

regex_t * bw_alloc_reg()
{
  return (regex_t*) malloc( sizeof (regex_t));
}

void bw_free_reg( regex_t * reg)
{

  regfree( reg);
  free ( reg);
}
  
int bw_make_reg( regex_t * reg,
	      char* pat, int reg_ex, int reg_ic, int reg_ns, int reg_nl)
{
  return regcomp(reg,pat,reg_ex|reg_ic|reg_ns|reg_nl); 
}


void bw_free_reg_space( regex_t* reg)
{
  free (reg);
}
