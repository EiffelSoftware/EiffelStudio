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
 * This file was produced by running metaconfig and is intended to be included
 * after eif_config.h and after all the other needed includes have been dealt 
 * with.
 *
 * This file may be empty, and should not be edited. Rerun metaconfig instead.
 * If you wish to get rid of this magic, remove this file and rerun metaconfig
 * without the -M option.
 *
 *  $Id$
 */

#ifndef _confmagic_h_
#define _confmagic_h_

/* Specific setup for VXWORKS port */
#ifdef VXWORKS
#include <vxWorks.h>
#define CUSTOM
#define NEED_HASH_H
#define NEED_TIMER_H
#endif

/* Are we using ISE GC? By default, yes. */
/* DEFINE_BOEHM_GC */
/* DEFINE_NO_GC */

#ifdef BOEHM_GC 
#define NO_ISE_GC
#if defined(EIF_THREADS) && defined(EIF_WINDOWS)
#define GC_DLL
#endif
#endif

#ifdef NO_GC
#define NO_ISE_GC
#endif

#ifndef NO_ISE_GC
#define ISE_GC
#endif

/* Do not compile with assertions, by default. */
/*
#define EIF_EXPENSIVE_ASSERTIONS
#define EIF_ASSERTIONS
*/

#ifndef EIF_ASSERTIONS
#define NDEBUG
#endif	/* EIF_ASSERTIONS */

#endif	/* _confmagic_h_ */
