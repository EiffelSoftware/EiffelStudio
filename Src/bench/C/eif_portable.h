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

#if defined (EIF_VMS)	/* VMS Platform specific definitions; must precede any other include files */
#define USE_VMS_JACKETS

#ifdef USE_VMS_JACKETS	/* if using VMS Porting Library, aka The Jackets */
#define GENERIC_MOTIF_REDEFINES
#define GENERIC_PTHREAD_REDEFINES
#include <vms_jackets.h>	/* VMS Porting Library jackets */
#endif /* USE_VMS_JACKETS */

/* these definitions _must_ occur before any include files */
#define _POSIX_EXIT
#define __NEW_STARLET		/* define prototypes for VMS sys$, lib$ function calls */

/* #define _VMS_V6_SOURCE	** see DECC RTL doc (geteuid) */
#if !defined(__DECC_VER) || __DECC_VER < 50000000	/* DECC vers < 5.0 */
#define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR
#define cma$tis_vmserrno_get_addr CMA$TIS_VMSERRNO_GET_ADDR
#endif /* pre 5.0 DECC */
/* handle standard C library symbols that are overriden by Eiffel runtime */
/* --- symbols newly defined in VMS V7.0 DECC Runtime library --- */
#define getenv eif_vms_getenv
#define putenv eif_vms_putenv
#define setenv eif_vms_setenv
#define strdup eif_vms_strdup
#ifdef USE_VMS_JACKETS
#else  /* USE_VMS_JACKETS */
#define rmdir  eif_vms_rmdir
#define unlink eif_vms_unlink
/* #define system eif_vms_system -- doesnt work with _POSIX_EXIT */
/* --- symbols in readdir package (wrappers solve version problems) --- */
#define opendir   eif_vms_opendir
#define closedir  eif_vms_closedir
#define rewinddir eif_vms_rewinddir
#define readdir   eif_vms_readdir
#define seekdir   eif_vms_seekdir
#define telldir   eif_vms_telldir
#endif /* USE_VMS_JACKETS */

#endif /* EIF_VMS */



#include <limits.h>			/* To avoid redefinition of constants limits. */
#include "eif_confmagic.h"
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif
 
#ifdef EIF_VMS
#include <dirent.h>
#include <string.h>
#include <unistd.h>
#include <unixlib.h>
#include <unixio.h>

#ifdef HAS_TIMES
#define HZ  100   	/* seconds in units (10 millisecs) for times() */
#endif

/* This is usually defined in config.h; we redefine it correctly here. */
#undef PAGESIZE_VALUE
#ifdef __vax
#define PAGESIZE_VALUE 512
#elif defined(__Alpha_AXP)
/* For Alpha, this is actually implementation-defined, and should be */
/* determined at runtime,  but this will have to do for now.  */
#define PAGESIZE_VALUE 8192
#else
    undefined architecture
#endif /* __vax */

/* Macros to test for VMS-style (low bit) success/failure. */
#define  VMS_SUCCESS(x)	 (     (x) & 1   )
#define  VMS_FAILURE(x)  ( ! ( (x) & 1 ) )

/* access to descriptor components */
typedef struct dsc$descriptor DX;	/* prototype descriptor */
#define DXLEN(d) ( (d).dsc$w_length )
#define DXPTR(d) ( (d).dsc$a_pointer )
#pragma message disable (NEEDCONSTEXT,ADDRCONSTEXT)	/* skip non-constant extension warnings */
#define DX_BLD(d,ptr,len) DX d = { len, DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)ptr }
#define DX_BUF(d,buf) DX d = { sizeof(buf), DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)&buf }

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
#include <ints.h>		/* VMS: integer sizes are architecture dependent */
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
typedef signed char		EIF_INTEGER_8;
typedef int16			EIF_INTEGER_16;
typedef int32			EIF_INTEGER;
typedef int32			EIF_INTEGER_32;
#ifdef CYGWIN
typedef long long		EIF_INTEGER_64;
#elif defined(EIF_WIN32)	/* or whatever they actually are */
typedef __int64			EIF_INTEGER_64;
#elif defined(EIF_VMS)
typedef long long int		EIF_INTEGER_64;
#else
typedef long long		EIF_INTEGER_64;
#endif
typedef float			EIF_REAL;
typedef double			EIF_DOUBLE;
typedef char *			EIF_REFERENCE;
typedef void *			EIF_POINTER;

/* For workbench mode only. */
typedef uint32		BODY_INDEX;

	/* previously in eif_globals.h */
#define MTC_NOARG           
#define MTC                 /* MTC_NOARG, */
#define EIF_CONTEXT_NOARG   void /* eif_global_context_t    *MTC_NOARG */
#define EIF_CONTEXT         /* EIF_CONTEXT_NOARG, */
#define EIF_STATIC_OPT


#ifdef EIF_VMS
/* VMS specific definitions */
#if !defined FILENAME_MAX || FILENAME_MAX < 4095
#undef  FILENAME_MAX	    /* override default 256, too small */
#define FILENAME_MAX 4095   /* == NAML$C_MAXRSS */
#endif 

typedef unsigned long VMS_STS;		/* VMS status (condition) value */
typedef struct _generic_64 bintim;	/* VMS binary time (8 bytes) */

/* VMS abstractions used in runtime */
RT_LNK size_t eifrt_vms_dirname_len (const char* path) ;
RT_LNK int eifrt_vms_spawn (const char* cmd, int async_flag) ;
RT_LNK const char* eifrt_vms_imagename (char* buf, size_t bufsiz) ;
RT_LNK const char* eifrt_vms_get_progname (char* buf, size_t bufsiz) ;
RT_LNK int   eifrt_vms_has_path_terminator (const char* path) ;
RT_LNK void  eifrt_vms_append_file_name (char* path, const char* file) ;
RT_LNK char* eifrt_vms_filespec (const char* filespec, char* buf) ;
RT_LNK char* eifrt_vms_directory_file_name (const char* dir, char* buf) ;
#ifdef EIF_VMS_V6_ONLY
RT_LNK char * dir_dot_dir (char * dir) ;
#endif
#endif /* EIF_VMS */


#ifdef __cplusplus
}
#endif

#endif
