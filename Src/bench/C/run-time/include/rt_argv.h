/*

   ##    #####    ####   #    #          #    #
  #  #   #    #  #    #  #    #          #    #
 #    #  #    #  #       #    #          ######
 ######  #####   #  ###  #    #   ###    #    #
 #    #  #   #   #    #   #  #    ###    #    #
 #    #  #    #   ####     ##     ###    #    #

	Private declaration of argument vectors.
*/

#ifndef _rt_argv_h_
#define _rt_argv_h_

#include "eif_argv.h"

#ifdef __cplusplus
extern "C" {
#endif

extern void arg_init(int eargc, char **eargv);			/* Command line arguments saving */

#ifdef __cplusplus
}
#endif

#endif
