/*

 #####   ######  #####  #####    #   ######  #    #  ######          #    #
 #    #  #         #    #    #   #   #       #    #  #               #    #
 #    #  #####     #    #    #   #   #####   #    #  #####           ######
 #####   #         #    #####    #   #       #    #  #        ###    #    #
 #   #   #         #    #   #    #   #        #  #   #        ###    #    #
 #    #  ######    #    #    #   #   ######    ##    ######   ###    #    #

	Declarations for retrieve mechanism.

*/

#ifndef _rt_retrieve_h_
#define _rt_retrieve_h_

#include "eif_retrieve.h"

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_REFERENCE ise_compiler_retrieve (EIF_INTEGER f_desc, int (*ret_func) (void));

#ifdef __cplusplus
}
#endif

#endif
