/*

 #    #  ######  #    #   ####   #####    #   #           ####
 ##  ##  #       ##  ##  #    #  #    #    # #           #    #
 # ## #  #####   # ## #  #    #  #    #     #            #
 #    #  #       #    #  #    #  #####      #     ###    #
 #    #  #       #    #  #    #  #   #      #     ###    #    #
 #    #  ######  #    #   ####   #    #     #     ###     ####

	Externals for class MEMORY.
*/

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"
#include <string.h>
#include "rt_assert.h"
#include "eif_constants.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "eif_except.h"
#include "eif_macros.h"
#include "rt_main.h"
#include "eif_memory.h"

/* Global variable to find out if we are performing the final collect */
rt_public EIF_BOOLEAN eif_is_in_final_collect = EIF_FALSE;

rt_public void mem_free(EIF_REFERENCE object)
{
	/* Unconditionally free object, if not in generational scavenge zone, in
	 * which case the object will be either collected if it is really dead
	 * or be tenured later on. If the object is in the main memory, it is
	 * irreversibly freed, which will have unpredictable consequences if some
	 * other object still references it--RAM.
	 */
	union overhead *zone = HEADER(object);
	uint32 flags = zone->ov_flags;
	unsigned int nbytes = EIF_Size(Dtype(object));

	if (0 == (flags & (EO_OLD | EO_NEW)))	/* Neither old nor new */
		return;							/* Object in scavenge zone */

	gfree(zone);		/* Free object, eventually calling dispose */

	/* Update `eiffel_usage' variable. Set to 0 if negative */

	eiffel_usage -= (nbytes + OVERHEAD);
	if (eiffel_usage < 0) eiffel_usage = 0;
}

/*
 * Compiled for speed or for memory?
 */

rt_public void mem_speed(void)
{
	/* Dynamically set the allocation flag 'cc_for_speed' to true, to indicate
	 * to that the user cares more about raw speed than memory consumption.
	 */

	if (cc_for_speed)			/* Already compiled for speed */
		return;					/* Nothing to be done */

	cc_for_speed = 1;			/* We are compiled for speed from now on */
	if (gen_scavenge & GS_OFF)	/* Generation scavenging turned off? */
		gen_scavenge = GS_SET;	/* Allow malloc to try again */
}

rt_public void mem_slow(void)
{
	/* Dynamically set the allocation flag 'cc_for_speed; to false, which
	 * indicates that the user cares more about low memory consumption than
	 * speed. Note that if generation scavenging has already been enabled,
	 * we continue to use it.
	 */

	if (!cc_for_speed)			/* Already compiled for memory */
		return;					/* Nothing to be done */

	cc_for_speed = 0;			/* We are compiled for speed from now on */
	if (gen_scavenge == GS_SET)	/* Scavenging still waiting to be activated */
		gen_scavenge = GS_OFF;	/* Turn it off */
}

rt_public void mem_tiny(void)
{
	/* Basically the same as mem_slow(), but scavenging zone are freed if they
	 * have been allocated.
	 */

	if (gen_scavenge & GS_ON)	/* Generation scavenging turned on */
		sc_stop();				/* Free 'to' and explode 'from' space */

	mem_slow();					/* And force cc_for_speed to zero */

#ifdef MAY_PANIC
	if (gen_scavenge != GS_OFF)
		eif_panic("memory flags corrupted");
#endif
}

/*
 * Memory coalescing.
 */
rt_private int m_largest = 0;		/* Size of the largest coalesced block */ /* %%ss mt */

rt_public EIF_INTEGER mem_largest(void)
{

	return (EIF_INTEGER) m_largest;			/* Return size of the largest block */
}

rt_public void mem_coalesc(void)
{
	/* Run a full coalescing on all the chunks managed by the run-time, both
	 * C and Eiffel ones. This certainly can be a big help in reducing the
	 * memory fragmentation by coalescing adjacent free blocks.
	 * The function returns the size of the biggest coalesced block, or 0 if
	 * no coalescing occurred, and it is stored in m_largest (to avoid an
	 * attribute on the Eiffel side).
	 */

	m_largest = full_coalesc(ALL_T);
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

rt_public long mem_tget(void)
{
	return th_alloc;			/* Current allocation threshold */
}

rt_public void mem_tset(long int value)
{
	th_alloc = value;			/* Set new allocation threshold */
}

rt_public long mem_pget(void)
{
	return plsc_per;			/* Current full collection period */
}

rt_public void mem_pset(long int value)
{
	plsc_per = value;			/* Set new full collection period */
}

/*
 * Memory usage.
 */
rt_private struct emallinfo mem_stats; /* %%ss mt */
rt_public void mem_stat(long int type)
{
	/* Initialize the mem statistics buffer, which will be used by the mem_info
	 * routine to fetch the fields value, one at a time. By copying the whole
	 * structure atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	
	struct emallinfo *sm = meminfo(type);	/* Get structure by type */

	memcpy (&mem_stats, sm, sizeof(struct emallinfo));
}

rt_public long mem_info(long int field)
{
	/* Extracts values from the emallinfo structure */

	switch (field) {
	case 0:
		return mem_stats.ml_chunk;
	case 1:
		return mem_stats.ml_total;
	case 2:
		return mem_stats.ml_used;
	case 3:
		return mem_stats.ml_over;
	default:
		eraise("invalid mem_info request", EN_PROG);
	}
	/* NOTREACHED */
	return 0;
}

/*
 * GC statistics.
 */
rt_private struct gacstat gc_stats;
rt_private long gc_count;

rt_public void gc_mon(char flag)
{
	gc_monitor = (int) flag;	/* Turn GC statistics on/off */
}

rt_public void gc_stat(long int type)
{
	/* Initialize the GC statistics buffer, which will be used by the gc_info
	 * routine to fetch the fields value, one at a time. By copying the whole
	 * structure atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	
	struct gacstat *gs = &g_stat[type];	/* Get structure by type */

	memcpy (&gc_stats, gs, sizeof(struct gacstat));

	if (type == GST_PART)
		gc_count = g_data.nb_full;
	else
		gc_count = g_data.nb_partial;
}

rt_public long gc_info(long int field)
{
	/* Extracts values from the gacstat structure */

	switch (field) {
	case 0:
		return gc_count;
	case 1:
		return gc_stats.mem_used;
	case 2:
		return gc_stats.mem_collect;
	case 3:
		return gc_stats.mem_avg;
	case 4:
		return gc_stats.real_time;
	case 5:
		return gc_stats.real_avg;
	case 6:
		return gc_stats.real_itime;
	case 7:
		return gc_stats.real_iavg;
	default:
		eraise("invalid gc_info request", EN_PROG);
	}
	/* NOTREACHED */
	return 0;
}

rt_public double gc_infod(long int field)
{
	/* Extracts values from the gacstat structure */

	switch (field) {
	case 8:
		return gc_stats.cpu_time;
	case 9:
		return gc_stats.cpu_avg;
	case 10:
		return gc_stats.cpu_itime;
	case 11:
		return gc_stats.cpu_iavg;
	case 12:
		return gc_stats.sys_time;
	case 13:
		return gc_stats.sys_avg;
	case 14:
		return gc_stats.sys_itime;
	case 15:
		return gc_stats.sys_iavg;
	default:
		eraise("invalid gc_info request", EN_PROG);
	}
	/* NOTREACHED */
	return 0;
}

/*
 * Is garbage collection enabled?
 */

rt_public char gc_ison(void)
{
	return (char) (g_data.status & GC_STOP ? '\0' : '\01');
}

rt_public void eif_set_coalesce_period (EIF_INTEGER p)
{
	REQUIRE ("p positive", p >= 0);
	clsc_per = p;
	ENSURE ("clsc_per set", clsc_per == p);
}

rt_public void eif_set_max_mem (EIF_INTEGER lim)
{
	/*
	 * Set the maximum amount of memory the run-time can allocate.
	 */

	eif_max_mem = (int) lim;
}

rt_public EIF_INTEGER eif_get_max_mem (void)
{
	/*
	 * Return the maximum amount of memory the run-time can allocate.
	 */

	return (EIF_INTEGER) eif_max_mem;
}	/* eif_max_mem () */

rt_public EIF_INTEGER eif_tenure (void)	
{
	/* Return the maximum tenuring age. */

	/* Not in per thread basis. */

	return	eif_tenure_max;
}	/* eif_tenure () */

rt_public EIF_INTEGER eif_generation_object_limit (void)
{
	/* Return the maximum size of object allocatable in 	
	 * the generational scavenge zone.
	 */

	/* Not in per thread basis. */

	return (EIF_INTEGER) eif_gs_limit;
}	/* eif_generation_object_limit () */

rt_public EIF_INTEGER eif_scavenge_zone_size (void)
{
	/* Return size of geneartional scavenge zone. */

	/* Not in per thread basis. */

	return (EIF_INTEGER) eif_scavenge_size;
}	/* eif_scavenge_zone_size () */

rt_public EIF_INTEGER eif_coalesce_period (void) 
{
	int ret;	/* Return value. */
	ret = clsc_per;	
	return (EIF_INTEGER) ret;
}	/* eif_coalesce_period () */	

rt_public EIF_INTEGER eif_get_chunk_size (void)
{
	/*
	 * Return chunk size.
	 */

	return (EIF_INTEGER) eif_chunk_size;
}	/* eif_get_chunk_size () */

#ifdef __cplusplus
}
#endif

