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
#if defined(__SunOS_5_9)
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


static EIF_ATOMIC_INLINE EIF_INTEGER_32 eif_atomic_compare_and_swap_integer_32 (EIF_INTEGER_32 *dest, EIF_INTEGER_32 setter, EIF_INTEGER_32 compare)
	{
		// Atomically update dest contents to setter if original contents were equal to compare, return original value, caller checks if value equals compare value, if so then dest must now equal setter, if not then no operation occurred.
#if defined(_WIN32)
		return (EIF_INTEGER_32) InterlockedCompareExchange((long *)dest, setter, compare);
#elif defined (__EIF_GNUC_ATOMOPS__)
		return (EIF_INTEGER_32) __sync_val_compare_and_swap (dest, compare, setter);
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
		return (EIF_INTEGER_32) atomic_cas_32 (dest, compare, setter);
#else
		return (EIF_INTEGER_32)0;
#endif
	}

static EIF_ATOMIC_INLINE EIF_INTEGER_32 eif_atomic_swap_integer_32 (EIF_INTEGER_32 *dest, EIF_INTEGER_32 setter)
	{
		// Atomically update contents of dest to setter, return original value of dest.
#if defined(_WIN32)
		return (EIF_INTEGER_32) InterlockedExchange((long *)dest, setter);
#elif defined (__EIF_GNUC_ATOMOPS__)
		return (EIF_INTEGER_32) __sync_val_compare_and_swap (dest, *dest, setter);
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
		return (EIF_INTEGER_32) atomic_swap_32 (dest, setter);
#else
		return (EIF_INTEGER_32)0;
#endif
	}

static EIF_ATOMIC_INLINE EIF_INTEGER_32 eif_atomic_add_integer_32 (EIF_INTEGER_32 *dest, EIF_INTEGER_32 val)
	{
		// Atomically update dest target to original value plus val, return this new value.
#if defined(_WIN32)
		return (EIF_INTEGER_32) (InterlockedExchangeAdd((long *)dest, val) + val); // Add val to return new value.
#elif defined (__EIF_GNUC_ATOMOPS__)
		return (EIF_INTEGER_32) __sync_add_and_fetch (dest, val);
#elif defined (__EIF_SUNPRO_C_ATOMOPS__)
		return (EIF_INTEGER_32) atomic_add_32_nv (dest, val);
#else  
		return (EIF_INTEGER_32)0;
#endif
	}

#define RTS_ACAS_I32(dest,setter,compare) eif_atomic_compare_and_swap_integer_32((EIF_INTEGER_32 *)dest,setter,compare)
#define RTS_AS_I32(dest, setter) eif_atomic_swap_integer_32((EIF_INTEGER_32 *)dest,setter)
#define RTS_AI_I32(dest) eif_atomic_add_integer_32((EIF_INTEGER_32 *)dest, 1)
#define RTS_AD_I32(dest) eif_atomic_add_integer_32((EIF_INTEGER_32 *)dest, -1)
#define RTS_AA_I32(dest, val) eif_atomic_add_integer_32((EIF_INTEGER_32 *)dest,val)


#ifdef __cplusplus
}

#endif

#endif	/* _eif_atomops_h_ */

