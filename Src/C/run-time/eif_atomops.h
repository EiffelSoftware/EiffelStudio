/*
	description:	"Atomic Memory Operations Support"
	date:		"$Date$"
	revision:	"$Revision: 86017 $"
	copyright:	"Copyright (c) 2010-2014, Eiffel Software."
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

#ifndef _eif_atomops_h_
#define _eif_atomops_h_

#include "eif_config.h"

#if EIF_OS == EIF_OS_SUNOS
#	include <sys/atomic.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Atomic Operations */

#define EIF_ATOMIC_INLINE

#if defined(__GNUC__)
# if defined(__GNUC_PATCHLEVEL__)
#  define __EIF_GNUC_VERSION__ (__GNUC__ * 10000 \
                            + __GNUC_MINOR__ * 100 \
                            + __GNUC_PATCHLEVEL__)
# else
#  define __EIF_GNUC_VERSION__ (__GNUC__ * 10000 \
                            + __GNUC_MINOR__ * 100)
# endif

#if (__EIF_GNUC_VERSION__ >= 40102)
#	define __EIF_GNUC_ATOMOPS__
#endif

#endif

/*
* Atomic operations:
* RTS_ACAS_I32(dest,setter,compare) - compare-exchange
* RTS_AS_I32(dest, setter)          - exchange
* RTS_AA_I32(dest, val)             - add-fetch
* RTS_AS_PTR(dest, setter)          - exchange for pointers
* RTS_AI_I32(dest)                  - increment-fetch
* RTS_AD_I32(dest)                  - decrement-fetch
* EIF_HAS_ATOMIC                    - Preprocessor guard. Defined if atomic operations are available.
*/

#if defined(_WIN32)
#	define RTS_ACAS_I32(dest,setter,compare) InterlockedCompareExchange ((long *) dest, setter, compare)
#	define RTS_AS_I32(dest, setter)          InterlockedExchange ((long *) dest, setter)
#	define RTS_AA_I32(dest, val)             (InterlockedExchangeAdd ((long *) dest, val) + val) // Add val to return new value.
#	define RTS_AS_PTR(dest, setter)          InterlockedExchangePointer ((PVOID volatile *)dest, (PVOID) setter)
#	define EIF_HAS_ATOMIC
#elif defined (__EIF_GNUC_ATOMOPS__) || defined (__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4) || (defined (__clang__) && (defined (__x86_64__) || defined (__i386__)))
#	define RTS_ACAS_I32(dest,setter,compare) __sync_val_compare_and_swap (dest, compare, setter)
#	define RTS_AS_I32(dest, setter)          __sync_val_compare_and_swap (dest, *dest, setter)
#	define RTS_AA_I32(dest, val)             __sync_add_and_fetch (dest, val)
#	define RTS_AS_PTR(dest, setter)          __sync_val_compare_and_swap (dest, *dest, setter)
#	define EIF_HAS_ATOMIC
#elif (EIF_OS == EIF_OS_SUNOS && ((EIF_ARCH == EIF_ARCH_SPARC) || (EIF_ARCH == EIF_ARCH_SPARC_64))) || (EIF_OS == EIF_OS_LINUX && (defined (__SUNPRO_C) || defined (__SUNPRO_CC)))
	/**
	 * There are no C equivalents to the atomic operatons.
	 * The following replacements should be synchronized by mutexes
	 * and are provided here only as a reference for future implementation.
	 */
#	define RTS_ACAS_I32(dest,setter,compare) (* (int32_t *) dest == (int32_t) compare ? (* (int32_t *) dest = (int32_t) setter), (int32_t) compare : * (int32_t *) dest)
#	define RTS_AS_I32(dest, setter)          (* (int32_t *) dest = (int32_t) setter)
#	define RTS_AA_I32(dest, val)             (* (int32_t *) dest += (int32_t) val)
#	define RTS_AS_PTR(dest, setter)          (* (void **) dest = (void *) setter)
#elif EIF_OS == EIF_OS_SUNOS
#	define RTS_ACAS_I32(dest,setter,compare) atomic_cas_32 ((volatile uint32_t *) dest, compare, setter)
#	define RTS_AS_I32(dest, setter)          atomic_swap_32 ((volatile uint32_t*) dest, setter)
#	define RTS_AA_I32(dest, val)             atomic_add_32_nv ((volatile uint32_t*) dest, val)
#	define RTS_AS_PTR(dest, setter)          atomic_swap_ptr (dest, setter)
#	define EIF_HAS_ATOMIC
#else
#	error "Missing atomic compare-exchange functionality."
#endif

#define RTS_AI_I32(dest) RTS_AA_I32 (dest, 1)
#define RTS_AD_I32(dest) RTS_AA_I32 (dest, -1)


#ifdef __cplusplus
}

#endif

#endif	/* _eif_atomops_h_ */
