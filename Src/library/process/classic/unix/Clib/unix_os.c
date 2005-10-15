
/* Unix system routines which are called from Eiffel. */

#include <eif_eiffel.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>
#include <fcntl.h>
#include "unix_os.h"


EIF_POINTER unix_allocate_arg_memory (EIF_INTEGER count) {
  char ** result;

#ifdef __SVR4
  result = (char **) malloc((size_t) (count * sizeof(char *)));
#else
  result = (char **) malloc((unsigned) (count * sizeof(char *)));
#endif
  if (result == NULL) {
    enomem();
  }
  return (EIF_POINTER) result;
}

