/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision$"
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

#ifndef _eif_scoop_h_
#define _eif_scoop_h_

#ifdef __cplusplus
extern "C" {
#endif

typedef struct call_data {
	EIF_OBJECT        target;          /* Target of a call */
#ifdef WORKBENCH
	BODY_INDEX        body_index;      /* Routine to be called */
	EIF_TYPED_VALUE * result;          /* Address of a result for queries */
#else
	union {
		fnptr             address;         /* Routine to be called */
		size_t            offset;          /* Offset of an attribute */
	} feature;
	void *            result;          /* Address of a result for queries, the result type depends on the called feature */
	void           (* pattern) (struct call_data *); /* Stub that is used to perform a call */
#endif /* WORKBENCH */
	EIF_NATURAL_32    count;           /* Number of arguments excluding target object */
	EIF_SCP_PID       sync_pid;        /* Indicator of a synchronous call */
	EIF_BOOLEAN       is_lock_passing; /* Indicator of a lock passing call */
	EIF_TYPED_VALUE   argument [1];    /* Arguments excluding target object */
} call_data;

#ifdef WORKBENCH
rt_public void eif_log_call (int static_type_id, int feature_id, EIF_SCP_PID current_pid, call_data * data);
rt_public void eif_log_callp (int origin, int offset, EIF_SCP_PID current_pid, call_data * data);
#else
rt_public void eif_log_call (EIF_SCP_PID p, call_data * a);
#endif

rt_public void eif_try_call (call_data * a);
rt_public void eif_free_call (call_data * a);
rt_public EIF_BOOLEAN eif_is_uncontrolled (EIF_SCP_PID c, EIF_SCP_PID s);

rt_public 

/* Atomic Operations */

#define EIF_ATOMIC_INLINE

#if defined(__GNUC__)
# if defined(__GNUC_PATCHLEVEL__)
#  define __GNUC_VERSION__ (__GNUC__ * 10000 \
                            + __GNUC_MINOR__ * 100 \
                            + __GNUC_PATCHLEVEL__)
# else
#  define __GNUC_VERSION__ (__GNUC__ * 10000 \
                            + __GNUC_MINOR__ * 100)
# endif

#if (__GNUC_VERSION__ >= 40102)
	#define __GNUC_ATOMOPS_BUILTIN__
#endif

#endif



static EIF_ATOMIC_INLINE EIF_INTEGER_32 eif_atomic_compare_and_swap_integer_32 (EIF_INTEGER_32 *dest, EIF_INTEGER_32 setter, EIF_INTEGER_32 compare)
	{
		// Atomically update dest contents to setter if original contents were equal to compare, return original value, caller checks if value equals compare value, if so then dest must now equal setter, if not then no operation occurred.
#if defined(_WIN32)
		return (EIF_INTEGER_32) InterlockedCompareExchange((long *)dest, setter, compare);
#elif defined (__GNUC_ATOMOPS_BUILTIN__)
		return __sync_val_compare_and_swap (dest, compare, setter);
#else
		return (EIF_INTEGER_32)0;
#endif
	}

static EIF_ATOMIC_INLINE EIF_INTEGER_32 eif_atomic_swap_integer_32 (EIF_INTEGER_32 *dest, EIF_INTEGER_32 setter)
	{
		// Atomically update contents of dest to setter, return original value of dest.
#if defined(_WIN32)
		return (EIF_INTEGER_32) InterlockedExchange((long *)dest, setter);
#elif defined (__GNUC_ATOMOPS_BUILTIN__)
		return (EIF_INTEGER_32) __sync_val_compare_and_swap (dest, *dest, setter);
#else
		return (EIF_INTEGER_32)0;
#endif
	}

static EIF_ATOMIC_INLINE EIF_INTEGER_32 eif_atomic_add_integer_32 (EIF_INTEGER_32 *dest, EIF_INTEGER_32 val)
	{
		// Atomically update dest target to original value plus val, return this new value.
#if defined(_WIN32)
		return (EIF_INTEGER_32) (InterlockedExchangeAdd((long *)dest, val) + val); // Add val to return new value.
#elif defined (__GNUC_ATOMOPS_BUILTIN__)
		return (EIF_INTEGER_32) __sync_add_and_fetch (dest, val);
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

#endif	/* _eif_scoop_h_ */

