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

#ifndef HAS_BCMP
#ifndef bcmp
#define bcmp(s,d,l) memcmp((s),(d),(l))
#endif
#endif

#ifndef HAS_BCOPY
#ifndef bcopy
#define bcopy(s,d,l) memcpy((d),(s),(l))
#endif
#else
#ifdef EIF_ALPHA
#define bcopy(s,d,l) bcopy ((const char *) s, (char *) d, l) 
#endif /* EIF_ALPHA */
#endif

#ifndef HAS_BZERO
#ifndef bzero
#define bzero(s,l) memset((s),0,(l))
#endif
#else
#ifdef EIF_ALPHA
#define bzero(s,l) bzero ((char *) s, l)
#endif /* EIF_ALPHA */
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
