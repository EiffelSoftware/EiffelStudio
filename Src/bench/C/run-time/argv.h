/*

   ##    #####    ####   #    #          #    #
  #  #   #    #  #    #  #    #          #    #
 #    #  #    #  #       #    #          ######
 ######  #####   #  ###  #    #   ###    #    #
 #    #  #   #   #    #   #  #    ###    #    #
 #    #  #    #   ####     ##     ###    #    #

	Argument vectors.
*/

#ifndef _argv_h_
#define _argv_h_

#ifdef __cplusplus
extern "C" {
#endif

extern int eif_argc;			/* Initial argc value (argument count) */
extern char **eif_argv;			/* Copy of initial argv (argument vector) */
extern void arg_init(int eargc, char **eargv);			/* Command line arguments saving */

#ifdef __cplusplus
}
#endif

#endif

