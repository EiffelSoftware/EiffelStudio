/*

 #    #  ######   ####    #####   ####   #####           #    #
 #    #  #       #    #     #    #    #  #    #          #    #
 ######  #####   #          #    #    #  #    #          ######
 #    #  #       #          #    #    #  #####    ###    #    #
 #    #  #       #    #     #    #    #  #   #    ###    #    #
 #    #  ######   ####      #     ####   #    #   ###    #    #

	Private declarations for Hector.
*/

#ifndef _rt_hector_h_
#define _rt_hector_h_

#include "eif_hector.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
extern struct stack hec_saved;	/* Saved indirection pointers */
#endif

#ifdef __cplusplus
}
#endif

#endif
