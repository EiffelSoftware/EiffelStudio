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

#ifndef HAS_INDEX
#ifndef index
#define index strchr
#endif
#ifndef rindex
#define rindex strrchr
#endif
#endif

/* Are we using ISE GC? By default, yes. */
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
