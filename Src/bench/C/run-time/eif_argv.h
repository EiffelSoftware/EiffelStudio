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

#ifdef __cplusplus
extern "C" {
#endif

extern int eif_argc;			/* Initial argc value (argument count) */
extern char **eif_argv;			/* Copy of initial argv (argument vector) */
extern int arg_number(void);
extern void arg_init(int eargc, char **eargv);			/* Command line arguments saving */
extern char *arg_option(int num);	/* Eiffel string of argv[num] */

#ifdef __cplusplus
}
#endif

#endif

