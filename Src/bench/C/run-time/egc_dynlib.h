/********************
 *** EGC_DYNLIB.H ***
 ********************/

#ifndef _EGC_DYNLIB_H_
#define _EGC_DYNLIB_H_

#include "eif_cecil.h"
#include "eif_eiffel.h"
	
#ifdef __cplusplus
extern "C" {
#endif

extern void init_rt(void);
extern void reclaim_rt(void);
	
#define DYNAMIC_LIB_RT_INITIALIZE(x)\
	char **l ; \
	char **ol = (char **) 0; \
	init_rt(); \
	l = loc_set.st_top;  \
	RTLI(x);
		
#define DYNAMIC_LIB_RT_END RTLE;	
			
#define DYNAMIC_LIB_RT_RECLAIM(x) \
			reclaim_rt(); 
				
			
#ifdef __cplusplus
}
#endif

#endif

