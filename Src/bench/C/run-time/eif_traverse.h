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

/* Flags for traversal */
#define TR_PLAIN		0x00		/* No accounting during object traversal */
#define TR_ACCOUNT		0x01		/* Accounting of objects in obj_nb */
#define TR_MAP			0x02		/* Build a maping table in obj_table */
#define TR_ACCOUNT_ATTR	0x04		/* Accounting of types of attributes */
#define INDEPEND_ACCOUNT 0x11
#define RECOVER_ACCOUNT	0x15

RT_LNK EIF_REFERENCE find_referers (EIF_REFERENCE target, EIF_INTEGER result_type);
RT_LNK EIF_REFERENCE find_instance_of (EIF_INTEGER instance_type, EIF_INTEGER result_type);

#ifdef __cplusplus
}
#endif

#endif

