/*
 * Object id externals
 */

#ifndef _rt_object_id_h_
#define _rt_object_id_h_

#include "eif_object_id.h"


#ifdef __cplusplus
extern "C" {
#endif

extern struct stack object_id_stack;	/* Stack where objects referenced through `object_id' are stored
										 * See class IDENTIFIED */	

#ifdef CONCURRENT_EIFFEL
extern struct stack separate_object_id_set; /* keeps track of objects referenced in other processors */
#endif

#ifdef __cplusplus
}
#endif


#endif
