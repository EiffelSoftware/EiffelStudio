/*
	description:	"Atomic Memory Operations Support"
	date:		"$Date$"
	revision:	"$Revision: 86017 $"
	copyright:	"Copyright (c) 2010, Eiffel Software."
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

#if defined(__SUNPRO_C)
#if defined (__SunOS_5_9)
// Atomic Operations are for Solaris 10 and above
#else
#include <sys/atomic.h>
#define __EIF_SUNPRO_C_ATOMOPS__
#endif
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
	#define __EIF_GNUC_ATOMOPS__
#endif

#endif


#if defined(_WIN32)
#define RTS_ACAS_I32(dest,setter,compare) InterlockedCompareExchange((long *)dest, setter, compare)
#elif defined (__EIF_GNUC_ATOMOPS__)
#define RTS_ACAS_I32(dest,setter,compare) __sync_val_compare_and_swap (dest, compare, setter)
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
#define RTS_ACAS_I32(dest,setter,compare) atomic_cas_32 ((volatile uint32_t *)dest, compare, setter)
#else
#define RTS_ACAS_I32(dest,setter,compare) 0
#endif


#if defined(_WIN32) 
#define RTS_AS_I32(dest, setter) InterlockedExchange((long *)dest, setter)
#elif defined (__EIF_GNUC_ATOMOPS__)
#define RTS_AS_I32(dest, setter) __sync_val_compare_and_swap (dest, *dest, setter)
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
#define RTS_AS_I32(dest, setter) atomic_swap_32 ((volatile uint32_t*)dest, setter)
#else
#define RTS_AS_I32(dest, setter) 0
#endif


#if defined(_WIN32)
#define RTS_AA_I32(dest, val) (InterlockedExchangeAdd((long *)dest, val) + val) // Add val to return new value.
#elif defined (__EIF_GNUC_ATOMOPS__)
#define RTS_AA_I32(dest, val) __sync_add_and_fetch (dest, val)
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
#define RTS_AA_I32(dest, val) atomic_add_32_nv ((volatile uint32_t*)dest, val)
#else  
#define RTS_AA_I32(dest, val) 0
#endif

#define RTS_AI_I32(dest) RTS_AA_I32(dest, 1)
#define RTS_AD_I32(dest) RTS_AA_I32(dest, -1)


#if defined(_WIN32)
#	define RTS_ACAS_PTR(dest,setter,compare) InterlockedCompareExchangePointer(dest, setter, compare)
#elif defined (__EIF_GNUC_ATOMOPS__)
#	define RTS_ACAS_PTR(dest,setter,compare) __sync_val_compare_and_swap (dest, compare, setter)
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
#	define RTS_ACAS_PTR(dest,setter,compare) atomic_cas_ptr (dest, compare, setter)
#else
#	error "Missing atomic compare-exchange functionality."
#endif


#if defined(_WIN32) 
#	define RTS_AS_PTR(dest, setter) InterlockedExchangePointer(dest, setter)
#elif defined (__EIF_GNUC_ATOMOPS__)
#	define RTS_AS_PTR(dest, setter) __sync_val_compare_and_swap (dest, *dest, setter)
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
#	define RTS_AS_PTR(dest, setter) atomic_swap_ptr (dest, setter)
#else
#	error "Missing atomic exchange functionality."
#endif


#define RTS_AI_PTR(dest) RTS_AI_I32(dest)
#define RTS_AD_PTR(dest) RTS_AD_I32(dest)


#ifdef __cplusplus
}

#endif

#endif	/* _eif_atomops_h_ */

