
/* Header file for Unix system routines which are called from Eiffel. */

/* String with textual description of meaning of error code `code'. */

#define error_description(code) Strerror(code)
#include <sys/types.h>
#include <signal.h>
             
