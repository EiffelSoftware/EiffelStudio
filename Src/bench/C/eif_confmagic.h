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
/* the following are used only during the compilation of the run-time
 * it would be better removing it in any other case -> don't leave it
 * when copying include files to bench/spec/$PLATFORM/include
 */
#define panic eiffel_panic
#define malloc eiffel_malloc
#define calloc eiffel_calloc
#define realloc eiffel_realloc
#define free eiffel_free
#endif

#ifndef HAS_BCMP
#ifndef bcmp
#define bcmp(s,d,l) memcmp((s),(d),(l))
#endif
#endif

#ifndef HAS_BCOPY
#ifndef bcopy
#define bcopy(s,d,l) memcpy((d),(s),(l))
#endif
#endif

#ifndef HAS_BZERO
#ifndef bzero
#define bzero(s,l) memset((s),0,(l))
#endif
#endif

#ifndef HAS_INDEX
#ifndef index
#define index strchr
#endif
#endif

#ifndef HAS_INDEX
#ifndef rindex
#define rindex strrchr
#endif
#endif

#endif
