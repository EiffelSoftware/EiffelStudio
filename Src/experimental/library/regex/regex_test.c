

#include <rx.h>

regex_t* alloc_reg();
int make_reg(regex_t*,  char*, int, int, int, int);
void free_reg( regex_t*);
int re_nsub( regex_t*);

int main()
{
  regex_t *reg;
  int regex_cmp;

  reg = alloc_reg(); 
  
  regex_cmp = make_reg(reg, "\\(P\\)", 0,0,0,0);
  printf("The result code is %i \n", regex_cmp);
  printf("The number of fields is %i\n", re_nsub(reg));

  regex_cmp = regexec(reg, "Hello World",0,0,0);

  printf("The result code is %i \n", regex_cmp);

  free_reg(reg);

}

int re_nsub( regex_t* reg)
{
  return  reg -> re_nsub;
}

regex_t * alloc_reg()
{
  return (regex_t*) malloc( sizeof (regex_t));
}

void free_reg( regex_t * reg)
{

  regfree( reg);
  free ( reg);
}
  
int make_reg( regex_t * reg,
	      char* pat, int reg_ex, int reg_ic, int reg_ns, int reg_nl)
{
  return regcomp(reg,pat,reg_ex|reg_ic|reg_ns|reg_nl); 
}
