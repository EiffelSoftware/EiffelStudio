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

extern int eif_argc;			/* Initial argc value (argument count) */
extern char **eif_argv;			/* Copy of initial argv (argument vector) */
extern void arg_init();			/* Command line arguments saving */

#endif

