/*

   ##    #####    ####   #    #          #    #
  #  #   #    #  #    #  #    #          #    #
 #    #  #    #  #       #    #          ######
 ######  #####   #  ###  #    #   ###    #    #
 #    #  #   #   #    #   #  #    ###    #    #
 #    #  #    #   ####     ##     ###    #    #

	Argument vectors.
*/

#ifndef _eif_argv_h_
#define _eif_argv_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int eif_argc;			/* Initial argc value (argument count) */
extern char **eif_argv;			/* Copy of initial argv (argument vector) */
extern void arg_init(int eargc, char **eargv);			/* Command line arguments saving */
RT_LNK EIF_INTEGER arg_number(void);
RT_LNK EIF_REFERENCE arg_option(EIF_INTEGER num);	/* Eiffel string of argv[num] */

#ifdef __cplusplus
}
#endif

#endif

