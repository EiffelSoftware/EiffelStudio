/*
	description: "Externals for class MEMORY."
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

/*
doc:<file name="memory.c" header="eif_memory.h" version="$Id$" summary="Externals for MEMORY class">
*/

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"
#include <string.h>
#include "rt_assert.h"
#include "rt_constants.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "eif_except.h"
#include "rt_macros.h"
#include "rt_main.h"
#include "rt_memory.h"

#ifdef BOEHM_GC
#include "rt_boehm.h"
#endif

/*
doc:	<attribute name="eif_is_in_final_collect" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Global variable to find out if we are performing the final collect</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Modified only at the very end of a system execution.</synchronization>
doc:	</attribute>
*/
rt_public EIF_BOOLEAN eif_is_in_final_collect = EIF_FALSE;

#ifndef EIF_THREADS
#define EIF_MEMORY_SETTING_LOCK	
#define EIF_MEMORY_SETTING_UNLOCK 
#else	/* EIF_THREADS */
/*
doc:	<attribute name="eif_memory_mutex" return_type="EIF_LW_MUTEX_TYPE" export="shared">
doc:		<summary>Ensure that all modification of GC/Memory parameters are done in a synchronized way. Variables protected by `eif_memory_mutex' don't need to be protected if already under the protection of `eif_gc_mutex'. This is because once you have the lock of `eif_gc_mutex' no other code can be executed at the same time.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_shared	EIF_LW_MUTEX_TYPE *eif_memory_mutex = (EIF_LW_MUTEX_TYPE *) 0;
#define EIF_MEMORY_SETTING_LOCK	EIF_ASYNC_SAFE_LW_MUTEX_LOCK (eif_memory_mutex, "Couldn't lock memory mutex");
#define EIF_MEMORY_SETTING_UNLOCK EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK (eif_memory_mutex, "Couldn't unlock memory mutex");
#endif /* EIF_THREADS */



rt_public void eif_mem_free(EIF_REFERENCE object)
{
	/* Unconditionally free object, if not in generational scavenge zone, in
	 * which case the object will be either collected if it is really dead
	 * or be tenured later on. If the object is in the main memory, it is
	 * irreversibly freed, which will have unpredictable consequences if some
	 * other object still references it--RAM.
	 */
	union overhead *zone = HEADER(object);
#ifdef ISE_GC
	uint32 flags = zone->ov_flags;

	if (0 == (flags & (EO_OLD | EO_NEW)))	/* Neither old nor new */
		return;							/* Object in scavenge zone */

	gfree(zone);		/* Free object, eventually calling dispose */

		/* Manu: 08/21/2003: One could think that we should update `eiffel_usage'
		 * here as it used to be done in the past. But here is why I decided not
		 * to keep this. First `eiffel_usage' is just an information to help
		 * find out when triggering a GC cycle, second people playing with `eif_mem_free'
		 * are simply crazy, I still don't understand why we keep this C features.
		 * Third who cares if the `eiffel_usage' is actually higher, it will force
		 * more collection, but you pay the price of using `eif_mem_free'. Finally
		 * updating `eiffel_usage' without using its mutex is not safe.
		 */

#else
#ifdef BOEHM_GC
	GC_free(zone);
#elif defined(NO_GC)
	free(zone);
#endif
#endif
}

/*
 * Compiled for speed or for memory?
 */

rt_public void eif_mem_speed(void)
{
	/* Dynamically set the allocation flag 'cc_for_speed' to true, to indicate
	 * to that the user cares more about raw speed than memory consumption.
	 */

#ifdef ISE_GC
	RT_GET_CONTEXT
	EIF_MEMORY_SETTING_LOCK
	if (!cc_for_speed) {	/* Is it alread compiled for speed */
		cc_for_speed = 1;			/* We are compiled for speed from now on */
		if (gen_scavenge == GS_OFF) {
				/* If generation scavenging is off, try to restore the scavenge zone
				 * so that they can be used for next Eiffel object creation. */
			create_scavenge_zones();
		}
	}
	EIF_MEMORY_SETTING_UNLOCK
#endif
}

rt_public void eif_mem_slow(void)
{
	/* Dynamically set the allocation flag 'cc_for_speed; to false, which
	 * indicates that the user cares more about low memory consumption than
	 * speed. Note that if generation scavenging has already been enabled,
	 * we continue to use it.
	 */

#ifdef ISE_GC
	RT_GET_CONTEXT
	EIF_MEMORY_SETTING_LOCK
	cc_for_speed = 0;			/* We are compiled for low memory from now on */
	EIF_MEMORY_SETTING_UNLOCK
#endif
}

rt_public void eif_mem_tiny(void)
{
	/* Basically the same as eif_mem_slow(), but scavenging zone are freed if they
	 * have been allocated.
	 */

#ifdef ISE_GC
	if (gen_scavenge & GS_ON)	/* Generation scavenging turned on */
		sc_stop();				/* Free 'to' and explode 'from' space */

	eif_mem_slow();					/* And force cc_for_speed to zero */

	ENSURE("Scavenging disabled", gen_scavenge == GS_OFF);
#endif
}

/*
 * Memory coalescing.
 */

#ifndef EIF_THREADS
rt_private EIF_INTEGER m_largest = 0;
#endif

rt_public EIF_INTEGER eif_mem_largest(void)
{
#ifdef ISE_GC
	RT_GET_CONTEXT
	return m_largest;			/* Return size of the largest block */
#else
	return 0;
#endif
}

rt_public void eif_mem_coalesc(void)
{
	/* Run a full coalescing on all the chunks managed by the run-time, both
	 * C and Eiffel ones. This certainly can be a big help in reducing the
	 * memory fragmentation by coalescing adjacent free blocks.
	 * The function returns the size of the biggest coalesced block, or 0 if
	 * no coalescing occurred, and it is stored in m_largest (to avoid an
	 * attribute on the Eiffel side).
	 */

#ifdef ISE_GC
	RT_GET_CONTEXT
	m_largest = (EIF_INTEGER) full_coalesc(ALL_T);
#endif
}

/*
 * Automatic garbage collection control.
 *
 * Get/set current object allocation threshold, which is the minimum amount of
 * bytes to be allocated before an automatic garbage collection cycle is raised.
 *
 * Also get/set the 'plsc_per' variable, which controls the period of full
 * collections in the acollect() routine.
 */

rt_public EIF_INTEGER eif_mem_tget(void)
{
#ifdef ISE_GC
	return th_alloc;			/* Current allocation threshold */
#else
	return 0;
#endif
}

rt_public void eif_mem_tset(long int value)
{
#ifdef ISE_GC
	RT_GET_CONTEXT
	EIF_MEMORY_SETTING_LOCK
	th_alloc = value;			/* Set new allocation threshold */
	EIF_MEMORY_SETTING_UNLOCK
#endif
}

rt_public long eif_mem_pget(void)
{
#ifdef ISE_GC
	return plsc_per;			/* Current full collection period */
#else
	return 0;
#endif
}

rt_public void eif_mem_pset(long int value)
{
#ifdef ISE_GC
	RT_GET_CONTEXT
	EIF_MEMORY_SETTING_LOCK
	plsc_per = value;			/* Set new full collection period */
	EIF_MEMORY_SETTING_UNLOCK
#endif
}

/*
 * Memory usage.
 */
rt_public void eif_mem_stat(EIF_POINTER item, EIF_INTEGER type)
{
	/* Initialize the mem statistics `item' buffer. By copying the whole
	 * structure atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	
#ifdef ISE_GC
	struct emallinfo *sm = meminfo(type);	/* Get structure by type */

	memcpy (item, sm, sizeof(struct emallinfo));
#endif
}

/*
 * GC statistics.
 */

rt_public void eif_gc_mon(char flag)
{
#ifdef ISE_GC
	RT_GET_CONTEXT
	EIF_MEMORY_SETTING_LOCK
	gc_monitor = (int) flag;	/* Turn GC statistics on/off */
	EIF_MEMORY_SETTING_UNLOCK
#endif
}

rt_public void eif_gc_stat(EIF_POINTER item, EIF_INTEGER type)
{
	/* Initialize the GC statistics `item' buffer. By copying the whole structure
	 * atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	
#ifdef ISE_GC
	RT_GET_CONTEXT
	struct gacstat *gs = &rt_g_stat[type];	/* Get structure by type */

	memcpy (item, gs, sizeof(struct gacstat));

	EIF_G_DATA_MUTEX_LOCK;
	if (type == GST_PART) {
		((struct gacstat *) item)->count = rt_g_data.nb_full;
	} else {
		((struct gacstat *) item)->count = rt_g_data.nb_partial;
	}
	EIF_G_DATA_MUTEX_UNLOCK;
#endif
}

/*
 * Is garbage collection enabled?
 */

rt_public char eif_gc_ison(void)
{
#ifdef ISE_GC
	RT_GET_CONTEXT
	char result;
	EIF_G_DATA_MUTEX_LOCK;
	result = (char) (rt_g_data.status & GC_STOP ? '\0' : '\01');
	EIF_G_DATA_MUTEX_UNLOCK;
	return result;
#else
#ifdef BOEHM_GC
	return EIF_TEST(GC_dont_gc != 0);
#else
	return '\0';
#endif
#endif
}

rt_public void eif_set_coalesce_period (EIF_INTEGER p)
{
#ifdef ISE_GC
	REQUIRE ("p positive", p >= 0);
	clsc_per = p;
	ENSURE ("clsc_per set", clsc_per == p);
#endif
}

rt_public void eif_set_max_mem (EIF_INTEGER lim)
{
	/*
	 * Set the maximum amount of memory the run-time can allocate.
	 */

#ifdef ISE_GC
	RT_GET_CONTEXT
	EIF_MEMORY_SETTING_LOCK
	eif_max_mem = (int) lim;
	EIF_MEMORY_SETTING_UNLOCK
#endif
}

rt_public EIF_INTEGER eif_get_max_mem (void)
{
	/*
	 * Return the maximum amount of memory the run-time can allocate.
	 */

#ifdef ISE_GC
	return (EIF_INTEGER) eif_max_mem;
#else
	return 0;
#endif
}	/* eif_max_mem () */

rt_public EIF_INTEGER eif_tenure (void)	
{
	/* Return the maximum tenuring age. */

	/* Not in per thread basis. */

#ifdef ISE_GC
	return eif_tenure_max;
#else
	return 0;
#endif
}	/* eif_tenure () */

rt_public EIF_INTEGER eif_generation_object_limit (void)
{
	/* Return the maximum size of object allocatable in 	
	 * the generational scavenge zone.
	 */

	/* Not in per thread basis. */

#ifdef ISE_GC
	return (EIF_INTEGER) eif_gs_limit;
#else
	return 0;
#endif
}	/* eif_generation_object_limit () */

rt_public EIF_INTEGER eif_scavenge_zone_size (void)
{
	/* Return size of geneartional scavenge zone. */

	/* Not in per thread basis. */

#ifdef ISE_GC
	return (EIF_INTEGER) eif_scavenge_size;
#else
	return 0;
#endif
}	/* eif_scavenge_zone_size () */

rt_public EIF_INTEGER eif_coalesce_period (void) 
{
#ifdef ISE_GC
	return (EIF_INTEGER) clsc_per;	
#else
	return 0;
#endif
}	/* eif_coalesce_period () */	

rt_public EIF_INTEGER eif_get_chunk_size (void)
{
	/*
	 * Return chunk size.
	 */

#ifdef ISE_GC
	return (EIF_INTEGER) eif_chunk_size;
#else
	return 0;
#endif
}	/* eif_get_chunk_size () */

#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/
