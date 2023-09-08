/*
	description: "Portable declarations."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _portable_h_
#define _portable_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_config.h"

#ifdef EIF_VMS		/* VMS platform specific definitions; must precede any system or library includes */
#define __NEW_STARLET 1		/* define prototypes for VMS system (sys$) and library (lib$) functions */
#define _POSIX_EXIT 1		/* use POSIX-1 semantics for exit() */
#define _SOCKADDR_LEN 1		/* enables 4.4BSD- and and XPG4 V2-compatible socket interfaces */
/* #define _POSIX_C_SOURCE 2 */
/* #define _XOPEN_SOURCE */
/* #define _XOPEN_SOURCE_EXTENDED */
/* #define _LARGEFILE */		/* enable use of 64-bit file offsets */
#define USE_VMS_JACKETS 1	/* force use of VMS Porting Library, aka "The Jackets" */
#ifdef USE_VMS_JACKETS  	/* if using VMS Porting Library ("The Jackets") */
#define GENERIC_MOTIF_REDEFINES
/* #define GENERIC_PTHREAD_REDEFINES */
#include <vms_jackets.h>	/* VMS Porting Library jackets */
#undef fork /* remove VMS_JACKETS #define fork vfork */
#endif /* USE_VMS_JACKETS */
#define fork eifrt_vms_fork_jacket

#if !defined(__DECC_VER) || __DECC_VER < 50000000	/* DECC vers < 5.0 */
#define cma$tis_errno_get_addr CMA$TIS_ERRNO_GET_ADDR
#define cma$tis_vmserrno_get_addr CMA$TIS_VMSERRNO_GET_ADDR
#endif /* pre 5.0 DECC */

/* standard C library symbols that are overriden by Eiffel runtime VMS-specific jackets */
#ifndef USE_VMS_JACKETS
#define rmdir  eifrt_vms_rmdir
#define unlink eifrt_vms_unlink
/* #define system eifrt_vms_system -- doesnt work with _POSIX_EXIT */
/* --- readdir package wrappers (ignore multiple versions) --- */
#define opendir   eifrt_vms_opendir
#define closedir  eifrt_vms_closedir
#define rewinddir eifrt_vms_rewinddir
#define readdir   eifrt_vms_readdir
#define seekdir   eifrt_vms_seekdir
#define telldir   eifrt_vms_telldir
#endif /* USE_VMS_JACKETS */

#endif /* EIF_VMS */


#include <limits.h>			/* To avoid redefinition of constants limits. */
#include "eif_confmagic.h"
#include <stdlib.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif
 
/*
 * Standard types
 */
#ifdef EIF_VMS
#include <ints.h>		/* VMS: integer sizes are architecture dependent */
#elif EIF_OS == EIF_OS_HAIKU
#include <SupportDefs.h>
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

/* Portable integer pointers */
#ifdef EIF_WINDOWS
#include <stdint.h>

#ifndef _INTPTR_T_DEFINED
#define _INTPTR_T_DEFINED
#ifdef _WIN64
typedef __int64	intptr_t;
#else
typedef int		intptr_t;
#endif
#endif

#ifndef _UINTPTR_T_DEFINED
#define _UINTPTR_T_DEFINED
#ifdef _WIN64
typedef unsigned __int64	uintptr_t;
#else
typedef unsigned int		uintptr_t;
#endif
#endif

#elif EIF_OS == EIF_OS_HAIKU

#elif defined(EIF_SOLARIS)

#elif defined(VXWORKS)
typedef int intptr_t;
typedef unsigned int uintptr_t;

#elif defined(EIF_VMS)
#include <inttypes.h>
#if defined(__ALPHA) /* VMSAlpha may be 32 or 64 bit */
#if __INITIAL_POINTER_SIZE > 32
typedef	int64_t	 rt_int_ptr;
typedef uint64_t rt_uint_ptr;
#else
typedef int32_t  rt_int_ptr;
typedef uint32_t rt_uint_ptr;
#endif
#elif defined(__ia64) /* VMSIA64 always 64 bit? */
typedef	int64_t	 rt_int_ptr;
typedef uint64_t rt_uint_ptr;
#elif defined(__VAXC) || defined(__vaxc)
typedef intptr_t    rt_int_ptr;
typedef uintptr_t   rt_uint_ptr;
#else /* unknown VMS platform? */
#error "unknown VMS platform"
#endif

#else
#include <stdint.h>
#endif

#if !defined(EIF_VMS)
typedef intptr_t	rt_int_ptr;
typedef uintptr_t	rt_uint_ptr;
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
#ifdef EIF_WINDOWS
#define RT_IL	__declspec(dllexport)
#else
#define RT_IL	extern
#endif
#else
#define RT_IL	extern
#endif

#ifndef EIF_WINDOWS
/* For non Windows platform, when the Eiffel compiler generates DLL or .so files 
 * __stdcall must be defined (at least to empty string).
 */
#ifndef __stdcall
#define __stdcall
#endif
#endif

#define rt_public				/* default C scope */
#define rt_private static		/* static outside a block means private */
/* Compiler specific implementation for inlining routines. */
#if defined(_MSC_VER)
/* Microsoft does not define `inline' for C, just for C++, __inline is available for both. */
#define rt_inline __inline
#else
#define rt_inline inline
#endif
#define rt_shared				/* data shared between modules, but not public */

/* Maps an Eiffel type on a C type */
typedef unsigned char	EIF_BOOLEAN;
typedef unsigned char	EIF_CHARACTER;
typedef unsigned char	EIF_CHARACTER_8;
typedef uint32			EIF_WIDE_CHAR;
typedef uint32			EIF_CHARACTER_32;
typedef signed char		EIF_INTEGER_8;
typedef int16			EIF_INTEGER_16;
typedef int32			EIF_INTEGER;
typedef int32			EIF_INTEGER_32;
#if defined(EIF_WINDOWS) && !defined(CYGWIN)	/* or whatever they actually are */
typedef __int64			EIF_INTEGER_64;
#ifdef _WIN64
typedef __int64			ssize_t;
#else
typedef int				ssize_t;
#endif
#elif defined(EIF_VMS)
typedef long long int		EIF_INTEGER_64;
#else
typedef long long		EIF_INTEGER_64;
#endif
typedef unsigned char	EIF_NATURAL_8;
typedef uint16			EIF_NATURAL_16;
typedef uint32			EIF_NATURAL;
typedef uint32			EIF_NATURAL_32;
#if defined(EIF_WINDOWS) && !defined(CYGWIN)	/* or whatever they actually are */
typedef unsigned __int64			EIF_NATURAL_64;
#elif defined(EIF_VMS)
typedef unsigned long long int		EIF_NATURAL_64;
#else
typedef unsigned long long		EIF_NATURAL_64;
#endif
typedef float			EIF_REAL_32;
typedef double			EIF_REAL_64;
typedef char *			EIF_REFERENCE;
typedef void *			EIF_POINTER;

/* C type for underlying integer type identifying object's dynamic type. */
typedef uint16		EIF_TYPE_INDEX;

/*
doc:	<struct name="EIF_TYPE" export="public">
doc:		<summary>Abstraction representing an Eiffel type. It is made of a compiler type ID or full dynamic type ID depending on the usage, and of some annotations (attached/detachable/separate/variant/frozen).</summary>
doc:		<field name="id" type="EIF_TYPE_INDEX">ID for the type (compiler type ID or full dynamic type ID).</field>
doc:		<field name="annotations" type="EIF_TYPE_INDEX">Annotations for the type (ATTACHED_FLAG, DETACHABLE_FLAG, SEPARATE_FLAG, (see rt_gen_types.h for a complete list).</field>
doc:	</struct>
*/
typedef struct eif_type {
	EIF_TYPE_INDEX id;
	EIF_TYPE_INDEX annotations;
} EIF_TYPE;

/*
doc:	<struct name="EIF_ENCODED_TYPE" export="public">
doc:		<summary>Since EIF_TYPE and EIF_ENCODED_TYPE have the same size, the encoded version is basically a memcpy version of the EIF_TYPE representation. It is used to provide backward compatibility to most Eiffel and C APIs manipulating types as an INTEGER. The only difference with previous IDs is that once in a while values are larger than we previously had (i.e. used to just be in the range 0 .. 65535).</summary>
doc:	</struct>
*/
typedef int32	EIF_ENCODED_TYPE;
typedef EIF_ENCODED_TYPE	EIF_TYPE_ID;

/* C type for underlying integer type identifying object's SCOOP Processor ID. */
typedef uint16		EIF_SCP_PID;

/* For workbench mode only. */
typedef uint32		BODY_INDEX;

/* Index into array of once values */
typedef uint32 ONCE_INDEX;

/* 64-bit signed and unsigned type for runtime */
typedef EIF_NATURAL_64	rt_uint64;
typedef EIF_INTEGER_64	rt_int64;

/* Native strings */
#ifdef EIF_WINDOWS
typedef wchar_t EIF_NATIVE_CHAR;
typedef wchar_t * EIF_FILENAME;
#else
typedef char EIF_NATIVE_CHAR;
typedef char * EIF_FILENAME;
#endif


	/* previously in eif_globals.h */
#define MTC_NOARG           
#define MTC                 /* MTC_NOARG, */
#define EIF_CONTEXT_NOARG   void /* eif_global_context_t    *MTC_NOARG */
#define EIF_CONTEXT         /* EIF_CONTEXT_NOARG, */
#define EIF_STATIC_OPT


#ifdef EIF_VMS
/* VMS platform specific definitions */
#include "eif_vmsdef.h"
#endif /* EIF_VMS */

/* Compatibility with 5.x (where x <= 5) version of compiler. */
/* eif_cecil.h */
#define EIF_REAL_FUNCTION	EIF_REAL_32_FUNCTION
#define EIF_DOUBLE_FUNCTION	EIF_REAL_64_FUNCTION
#define eif_real_function	eif_real_32_function
#define eif_double_function	eif_real_64_function
#define EIF_REAL_TYPE		EIF_REAL_32_TYPE
#define EIF_DOUBLE_TYPE		EIF_REAL_64_TYPE
#define EIF_FN_FLOAT		EIF_FN_REAL_32
#define	EIF_FN_DOUBLE		EIF_FN_REAL_64

/* eif_struct.h */
#define SK_FLOAT	SK_REAL32
#define SK_REAL		SK_REAL32
#define	SK_DOUBLE	SK_REAL64
#define SK_INT		SK_INT32
#define SK_CHAR		SK_CHAR8
#define SK_WCHAR	SK_CHAR32

/* eif_portable.h */
#define EIF_REAL	EIF_REAL_32
#define EIF_DOUBLE	EIF_REAL_64

/* eif_rout_obj.h */
#define eif_real_item	eif_real32_item
#define eif_double_item	eif_real64_item
#define eif_put_double_item_with_object	eif_put_real64_item_with_object
#define eif_put_real_item_with_object	eif_put_real32_item_with_object
#define eif_put_double_item	eif_put_real64_item
#define eif_put_real_item	eif_put_real32_item

/* Private compatibility */
#define it_float	it_real32
#define it_double	it_real64
#define egc_sp_real	egc_sp_real32
#define egc_sp_double	egc_sp_real64
#define	egc_real_ref_dtype	egc_real32_ref_dtype
#define egc_doub_ref_dtype	egc_real64_ref_dtype
#define egc_real_dtype	egc_real32_dtype
#define egc_doub_dtype	egc_real64_dtype

#define c_outd	c_outr64
#define c_outr	c_outr32
#define chupper(c) ((EIF_CHARACTER_8) toupper(c))
#define chlower(c) ((EIF_CHARACTER_8) tolower(c))
#define chis_upper(c) (EIF_TEST(isupper(c)))
#define chis_lower(c) (EIF_TEST(islower(c)))
#define chis_digit(c) (EIF_TEST(isdigit(c)))
#define chis_alpha(c) (EIF_TEST(isalpha(c)))

#ifdef __cplusplus
}
#endif

#endif /* _portable_h_ */
