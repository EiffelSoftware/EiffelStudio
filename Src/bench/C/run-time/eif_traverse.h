/*

 #####  #####     ##    #    #  ######  #####    ####   ######       #    #
   #    #    #   #  #   #    #  #       #    #  #       #            #    #
   #    #    #  #    #  #    #  #####   #    #   ####   #####        ######
   #    #####   ######  #    #  #       #####        #  #       ###  #    #
   #    #   #   #    #   #  #   #       #   #   #    #  #       ###  #    #
   #    #    #  #    #    ##    ######  #    #   ####   ######  ###  #    #

	Include file for traversal of objects.
*/

#ifndef _eif_traverse_h_
#define _eif_traverse_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_REFERENCE find_referers (EIF_REFERENCE target, int result_type);
RT_LNK EIF_REFERENCE find_instance_of (int instance_type, int result_type);

#ifdef __cplusplus
}
#endif

#endif

