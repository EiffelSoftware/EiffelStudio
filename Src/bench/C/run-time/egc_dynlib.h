/********************
 *** EGC_DYNLIB.H ***
 ********************/

#ifndef _egc_dynlib_h_
#define _egc_dynlib_h_

#include "eif_cecil.h"
#include "eif_eiffel.h"
	
#ifdef __cplusplus
extern "C" {
#endif

/* Initialization and destruction of runtime.
 * Both routines are defined in `egc_dynlib.c' */
extern void init_rt(void);
extern void reclaim_rt(void);
	
#define DYNAMIC_LIB_RT_INITIALIZE(x)\
	init_rt(); \
	{ \
		RTLD; \
		RTLI(x); \
		
#define DYNAMIC_LIB_RT_END \
		RTLE; \
	}
			
#define DYNAMIC_LIB_RT_RECLAIM(x) \
	reclaim_rt(); 
			
#ifdef __cplusplus
}
#endif

#endif

