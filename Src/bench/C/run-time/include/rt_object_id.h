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

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_object_id_stack_mutex;
#endif

#ifdef __cplusplus
}
#endif


#endif
