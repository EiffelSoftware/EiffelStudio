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


#include "eif_config.h"
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif
#include "eif_portable.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_macros.h"
#include "eif_main.h"
#include "eif_memory.h"


rt_public void mem_free(char *object)
{
	/* Unconditionally free object, if not in generational scavenge zone, in
	 * which case the object will be either collected if it is really dead
	 * or be tenured later on. If the object is in the main memory, it is
	 * irreversibly freed, which will have unpredictable consequences if some
	 * other object still references it--RAM.
	 */
	EIF_GET_CONTEXT
	union overhead *zone = HEADER(object);
	uint32 flags = zone->ov_flags;
	unsigned int nbytes = Size(Dtype(object));

	if (0 == flags & (EO_OLD | EO_NEW))	/* Neither old nor new */
		return;							/* Object in scavenge zone */

	gfree(zone);		/* Free object, eventually calling dispose */

	/* Update `eiffel_usage' variable. Set to 0 if negative */

	eiffel_usage -= (nbytes + OVERHEAD);
	if (eiffel_usage < 0) eiffel_usage = 0;

	EIF_END_GET_CONTEXT
}

/*
 * Compiled for speed or for memory?
 */

rt_public void mem_speed(void)
{
	/* Dynamically set the allocation flag 'cc_for_speed' to true, to indicate
	 * to that the user cares more about raw speed than memory consumption.
	 */
	EIF_GET_CONTEXT

	if (cc_for_speed)			/* Already compiled for speed */
		return;					/* Nothing to be done */

	cc_for_speed = 1;			/* We are compiled for speed from now on */
	if (gen_scavenge & GS_OFF)	/* Generation scavenging turned off? */
		gen_scavenge = GS_SET;	/* Allow malloc to try again */

	EIF_END_GET_CONTEXT
}

rt_public void mem_slow(void)
{
	/* Dynamically set the allocation flag 'cc_for_speed; to false, which
	 * indicates that the user cares more about low memory consumption than
	 * speed. Note that if generation scavenging has already been enabled,
	 * we continue to use it.
	 */
	EIF_GET_CONTEXT

	if (!cc_for_speed)			/* Already compiled for memory */
		return;					/* Nothing to be done */

	cc_for_speed = 0;			/* We are compiled for speed from now on */
	if (gen_scavenge == GS_SET)	/* Scavenging still waiting to be activated */
		gen_scavenge = GS_OFF;	/* Turn it off */

	EIF_END_GET_CONTEXT
}

rt_public void mem_tiny(void)
{
	/* Basically the same as mem_slow(), but scavenging zone are freed if they
	 * have been allocated.
	 */
	EIF_GET_CONTEXT

	if (gen_scavenge & GS_ON)	/* Generation scavenging turned on */
		sc_stop();				/* Free 'to' and explode 'from' space */

	mem_slow();					/* And force cc_for_speed to zero */

#ifdef MAY_PANIC
	if (gen_scavenge != GS_OFF)
		eif_panic("memory flags corrupted");
#endif
	EIF_END_GET_CONTEXT
}

/*
 * Memory coalescing.
 */
#ifndef EIF_THREADS
rt_private int m_largest = 0;		/* Size of the largest coalesced block */ /* %%ss mt */
#endif /* EIF_THREADS */

rt_public int mem_largest(void)
{
	EIF_GET_CONTEXT

	return m_largest;			/* Return size of the largest block */

	EIF_END_GET_CONTEXT
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
	EIF_GET_CONTEXT

	m_largest = full_coalesc(ALL_T);

	EIF_END_GET_CONTEXT
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
	EIF_GET_CONTEXT
	return th_alloc;			/* Current allocation threshold */
	EIF_END_GET_CONTEXT
}

rt_public void mem_tset(long int value)
{
	EIF_GET_CONTEXT
	th_alloc = value;			/* Set new allocation threshold */
	EIF_END_GET_CONTEXT
}

rt_public long mem_pget(void)
{
	EIF_GET_CONTEXT
	return plsc_per;			/* Current full collection period */
	EIF_END_GET_CONTEXT
}

rt_public void mem_pset(long int value)
{
	EIF_GET_CONTEXT
	plsc_per = value;			/* Set new full collection period */
	EIF_END_GET_CONTEXT
}

/*
 * Memory usage.
 */
#ifndef EIF_THREADS
rt_private struct emallinfo mem_stats; /* %%ss mt */
#endif /* EIF_THREADS */
rt_public void mem_stat(long int type)
{
	/* Initialize the mem statistics buffer, which will be used by the mem_info
	 * routine to fetch the fields value, one at a time. By copying the whole
	 * structure atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	EIF_GET_CONTEXT
	
	struct emallinfo *sm = meminfo(type);	/* Get structure by type */

	bcopy(sm, &mem_stats, sizeof(struct emallinfo));

	EIF_END_GET_CONTEXT
}

rt_public long mem_info(long int field)
{
	/* Extracts values from the emallinfo structure */
	EIF_GET_CONTEXT

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
	EIF_END_GET_CONTEXT
}

/*
 * GC statistics.
 */
#ifndef EIF_THREADS
rt_private struct gacstat gc_stats;
rt_private long gc_count;
#endif /* EIF_THREADS */

rt_public void gc_mon(char flag)
{
	EIF_GET_CONTEXT
	gc_monitor = (int) flag;	/* Turn GC statistics on/off */
	EIF_END_GET_CONTEXT
}

rt_public void gc_stat(long int type)
{
	/* Initialize the GC statistics buffer, which will be used by the gc_info
	 * routine to fetch the fields value, one at a time. By copying the whole
	 * structure atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	
	EIF_GET_CONTEXT
	struct gacstat *gs = &g_stat[type];	/* Get structure by type */

	bcopy(gs, &gc_stats, sizeof(struct gacstat));

	if (type == GST_PART)
		gc_count = g_data.nb_full;
	else
		gc_count = g_data.nb_partial;

	EIF_END_GET_CONTEXT
}

rt_public long gc_info(long int field)
{
	/* Extracts values from the gacstat structure */
	EIF_GET_CONTEXT

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
	EIF_END_GET_CONTEXT
}

rt_public double gc_infod(long int field)
{
	/* Extracts values from the gacstat structure */
	EIF_GET_CONTEXT

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
	EIF_END_GET_CONTEXT
}

/*
 * Is garbage collection enabled?
 */

rt_public char gc_ison(void)
{
	EIF_GET_CONTEXT
	return g_data.status & GC_STOP ? '\0' : '\01';
	EIF_END_GET_CONTEXT
}


rt_public void eif_set_max_mem (EIF_INTEGER lim)
{
	/*
	 * Set the maximum amount of memory the run-time can allocate.
	 */

	EIF_GET_CONTEXT
	eif_max_mem = (int) lim;
	EIF_END_GET_CONTEXT
}

rt_public void eif_set_chunk_size (EIF_INTEGER sz)
{
	/*
	 * Set the chunk size (the run-time always allocates a number of bytes
	 * multiple of this amount from the system)
	 */

	EIF_GET_CONTEXT
	int size = (int) sz;
	if (size > 0) eif_chunk_size = size;
	EIF_END_GET_CONTEXT
}

rt_public EIF_INTEGER eif_get_max_mem (void)
{
	/*
	 * Return the maximum amount of memory the run-time can allocate.
	 */

	EIF_GET_CONTEXT
	return (EIF_INTEGER) eif_max_mem;
	EIF_END_GET_CONTEXT
}

rt_public EIF_INTEGER eif_get_chunk_size (void)
{
	/*
	 * Return chunk size.
	 */

	EIF_GET_CONTEXT
	return (EIF_INTEGER) eif_chunk_size;
	EIF_END_GET_CONTEXT
}

#ifdef __cplusplus
}
#endif

