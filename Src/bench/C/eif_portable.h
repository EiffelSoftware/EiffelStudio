/*

 #####   ####  #####  #####   ##   #####  #      ######       #    #
 #    # #    # #    #   #    #  #  #    # #      #            #    #
 #    # #    # #    #   #   #    # #####  #      #####        ######
 #####  #    # #####    #   ###### #    # #      #       ###  #    #
 #      #    # #   #    #   #    # #    # #      #       ###  #    #
 #       ####  #    #   #   #    # #####  ###### ######  ###  #    #

	Some portable declarations.

    $Id$

*/

#ifndef _portable_h_
#define _portable_h_

#include "eif_config.h"

#include <limits.h>			/* To avoid redefinition of constants limits. */
#include "eif_confmagic.h"
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif
 
#ifdef EIF_VMS
/* 
 *  VMS system specific definitions 
 */
#define _POSIX_EXIT
#define __NEW_STARLET	/* define prototypes for sys$, lib$ function calls */
/* #define _VMS_V6_SOURCE	** see DECC RTL doc (geteuid) */
#if !defined(__DECC_VER) || __DECC_VER < 50000000	/* DECC vers < 5.0 */
#define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR
#define cma$tis_vmserrno_get_addr CMA$TIS_VMSERRNO_GET_ADDR
#endif /* pre 5.0 DECC */
/* handle standard C library symbols that are overriden by Eiffel runtime */
/* --- symbols newly defined in VMS V7.0 DECC Runtime library --- */
#define rmdir  eif_vms_rmdir
#define unlink eif_vms_unlink
#define getenv eif_vms_getenv
#define putenv eif_vms_putenv
#define setenv eif_vms_setenv
#define strdup eif_vms_strdup
/* #define system eif_vms_system -- doesnt work with _POSIX_EXIT */
/* --- symbols in readdir package (wrappers solve version problems) --- */
#define opendir   eif_vms_opendir
#define closedir  eif_vms_closedir
#define rewinddir eif_vms_rewinddir
#define readdir   eif_vms_readdir
#define seekdir   eif_vms_seekdir
#define telldir   eif_vms_telldir

#ifdef __cplusplus
}
#endif

#include <dirent.h>
#include <string.h>
#include <unistd.h>
#include <unixlib.h>
#include <unixio.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned long VMS_STS;		/* VMS status (condition) value */
typedef struct _generic_64 bintim;	/* VMS binary time (8 bytes) */

#ifdef HAS_TIMES
#define HZ  100   	/* seconds in units (10 millisecs) for times() */
#endif

/* This is usually defined in config.h; we redefine it correctly here. */
#ifdef PAGESIZE_VALUE
#undef PAGESIZE_VALUE
#endif
#ifdef __vax
#define PAGESIZE_VALUE 512
#elif defined(__Alpha_AXP)
/* Actually, this is supposed to be implementation-defined (i.e. different
 * AXP implementations can have different values), but this will do for now. */
#define PAGESIZE_VALUE 8192
#else
    undefined architecture
#endif /* __vax */

/* Macros to test for VMS-style (low bit) success/failure. */
#define  VMS_SUCCESS(x)	(   (x)&1  )
#define  VMS_FAILURE(x)	( !((x)&1) )
/* access to descriptor components */
typedef struct dsc$descriptor DX;	/* prototype descriptor */
#define DXLEN(d) ( (d).dsc$w_length )
#define DXPTR(d) ( (d).dsc$a_pointer )
#define DX_BLD(d,ptr,len) DX d = { len, DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)ptr }
/* itemlist entry for vms system calls */
typedef struct itemlist3def { 
    unsigned short buflen, itemcode; 
    void *bufadr; 
    unsigned short *retlenadr; 
    } ITEMLIST3, ITEMLIST[];
#define ITEM(code,buf,siz,rlen) { siz, code, buf, rlen }
#define ITEM_A(code,buf,rlen)	ITEM(code, buf, sizeof(buf), rlen )
#define ITEM_S(code,buf,rlen)	ITEM(code, &buf, sizeof(buf), rlen )
#define ITEMLIST_END		{0,0,0,0}
#endif /* EIF_VMS */

/*
 * Standard types
 */
#ifdef EIF_VMS
#ifdef __cplusplus
}
#endif
#include <ints.h>		/* integer sizes are architecture dependent */
#ifdef __cplusplus
extern "C" {
#endif
#elif INTSIZE < 4
typedef int int16;
typedef long int32;
typedef unsigned int uint16;
typedef unsigned long uint32;
#else
typedef short int16;
typedef int int32;
typedef unsigned short uint16;
typedef unsigned int uint32;
#endif

/*
 * Integer 32 bit constants
 */
#ifndef INT32_MAX
#define INT32_MAX 2147483647
#endif

#ifndef INT32_MIN
#define INT32_MIN (- INT32_MAX - 1)
#endif

/*
 * Integer 16 bit constants
 */

#ifndef INT16_MAX
#define INT16_MAX 32767
#endif

#ifndef UINT16_MAX
#define UINT16_MAX 65535U
#endif

/*
 * Scope control pseudo-keywords
 */

#ifdef  EIF_USE_DLL
#define RT_LNK	__declspec(dllimport)
#elif defined(EIF_MAKE_DLL)
#define RT_LNK	__declspec(dllexport)
#else
#define RT_LNK extern
#endif

#ifdef EIF_IL_DLL
#define RT_IL	__declspec(dllexport)
#else
#define RT_IL	extern
#endif

#define rt_public				/* default C scope */
#define rt_private static		/* static outside a block means private */
#define rt_shared				/* data shared between modules, but not public */

/* Maps an Eiffel type on a C type */
typedef unsigned char	EIF_BOOLEAN;
typedef unsigned char	EIF_CHARACTER;
typedef uint32			EIF_WIDE_CHAR;
typedef char			EIF_INTEGER_8;
typedef int16			EIF_INTEGER_16;
typedef int32			EIF_INTEGER;
typedef int32			EIF_INTEGER_32;
#if defined(EIF_WIN32) || defined(EIF_VMS)      /* or whatever they actually are */
typedef __int64			EIF_INTEGER_64;
#else
typedef long long		EIF_INTEGER_64;
#endif
typedef float			EIF_REAL;
typedef double			EIF_DOUBLE;
typedef char *			EIF_REFERENCE;
typedef void *			EIF_POINTER;

	/* previously in eif_globals.h */
#define MTC_NOARG           
#define MTC                 /* MTC_NOARG, */
#define EIF_CONTEXT_NOARG   void /* eif_global_context_t    *MTC_NOARG */
#define EIF_CONTEXT         /* EIF_CONTEXT_NOARG, */
#define EIF_STATIC_OPT

#ifdef __cplusplus
}
#endif

#endif
