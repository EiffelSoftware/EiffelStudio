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
 * feature address. 			   *
 *******************************************/
 
extern EIF_REFERENCE eif_global_function (EIF_REFERENCE Current, EIF_REFERENCE (*feature_address) (EIF_REFERENCE));
	/* Call to once function */

extern void eif_global_procedure  (EIF_REFERENCE Current, void * (*feature_address) (EIF_REFERENCE));
	/* Call to once procedure */ 

extern rt_shared void eif_destroy_once_mutexes (void); /* shared?? FIXME */
#ifdef __cplusplus
}
#endif

#endif

