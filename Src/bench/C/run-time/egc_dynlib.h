/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

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

