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

/*
	Structures and types defining global variables.
	All type definitions are concentrates here because we need
	to put them in a context when running multithreaded apps.
*/

#ifndef _rt_types_h_
#define _rt_types_h_

#include "eif_types.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
	/* Structure used for keep stacks that are thread specific, so GC knows about all
	 * stacks in all threads and traverse them when performing a collection. */
struct stack_list {
	int count;						/* Number of stacks in Current */
	int capacity;					/* Number of possible stacks in Current */
	union {
		void ** volatile data;				/* Array of data */
		struct stack ** volatile sstack;		/* Typed array of stack - GC stack */
		struct xstack ** volatile xstack;		/* Typed array of xtack - exception stack */
#ifdef WORKBENCH
		struct opstack ** volatile opstack;	/* Typed array of opstack - interpreter */
#endif
	} threads;
};

#endif

#ifdef __cplusplus
}
#endif

#endif	 /* _rt_types_h */
