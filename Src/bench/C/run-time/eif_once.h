/*

 ######    #    ######
 #         #    #
 #####     #    #####
 #         #    #
 #         #    #
 ######    #    #      #######

  ####   #    #   ####   ######          #    #
 #    #  ##   #  #    #  #               #    #
 #    #  # #  #  #       #####           ######
 #    #  #  # #  #       #        ###    #    #
 #    #  #   ##  #    #  #        ###    #    #
  ####   #    #   ####   ######   ###    #    #


	Once per process mechanism header file (available only in MT-mode)

*/
 
#include "eif_eiffel.h"
#ifndef _eif_once_h_
#define _eif_once_h_

#ifdef __cplusplus
extern "C" {
#endif

/*******************************************
 * Calls to once features throughout their *     
 * feature address. 			  	   	   *
 *******************************************/
 
extern EIF_REFERENCE eif_global_function (EIF_REFERENCE Current, EIF_POINTER function_ptr);
	/* Call to once function */

extern void eif_global_procedure  (EIF_REFERENCE Current, EIF_POINTER proc_ptr);
	/* Call to once procedure */ 

extern rt_shared void eif_destroy_once_per_process (void);
#ifdef __cplusplus
}
#endif

#endif

