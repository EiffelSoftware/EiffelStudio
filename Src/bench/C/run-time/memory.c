/*

 #    #  ######  #    #   ####   #####    #   #           ####
 ##  ##  #       ##  ##  #    #  #    #    # #           #    #
 # ## #  #####   # ## #  #    #  #    #     #            #
 #    #  #       #    #  #    #  #####      #     ###    #
 #    #  #       #    #  #    #  #   #      #     ###    #    #
 #    #  ######  #    #   ####   #    #     #     ###     ####

	Externals for class MEMORY.
*/


#include "config.h"
#include "portable.h"
#include "malloc.h"
#include "garcol.h"
#include "except.h"

extern uint32 gen_scavenge;		/* Malloc flag, controls scavenging */
extern int cc_for_speed;		/* Optimized for speed of for memory */
extern long th_alloc;			/* Allocation threshold, in bytes */
extern long plsc_per;			/* Period of plsc() in acollect() */
extern int gc_monitor;			/* GC monitoring flag */

extern int full_coalesc();		/* Perform free blocks coalescing */

/*
 * Compiled for speed or for memory?
 */

public void mem_speed()
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

public void mem_slow()
{
	/* Dynamically set the allocation flag 'cc_for_speed; to false, which
	 * indicates that the user cares more about low memory consumption than
	 * speed. Note that if generation scavenging has already been enabled,
	 * we continue to use it.
	 */

	if (!cc_for_speed)			/* Already compiled for memory */
		return;					/* Nothing to be done */

	cc_for_speed = 0;			/* We are compiled for speed from now on */
	if (gen_scavenge == GS_SET)	/* Scavenging still wating to be activated */
		gen_scavenge = GS_OFF;	/* Turn it off */
}

public void mem_tiny()
{
	/* Basically the same as mem_slow(), but scavenging zone are freed if they
	 * have been allocated.
	 */

	if (gen_scavenge & GS_ON)	/* Generation scavenging turned on */
		sc_stop();				/* Free 'to' and explode 'from' space */

	mem_slow();					/* And force cc_for_speed to zero */

#ifdef MAY_PANIC
	if (gen_scavenge != GS_OFF)
		panic("memory flags corrupted");
#endif
}

/*
 * Memory coalescing.
 */

private int m_largest = 0;		/* Size of the largest coalesced block */

public int mem_largest()
{
	return m_largest;			/* Return size of the largest block */
}

public void mem_coalesc()
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

public long mem_tget()
{
	return th_alloc;			/* Current allocation threshold */
}

public void mem_tset(value)
long value;
{
	th_alloc = value;			/* Set new allocation threshold */
}

public long mem_pget()
{
	return plsc_per;			/* Current full collection period */
}

public void mem_pset(value)
long value;
{
	plsc_per = value;			/* Set new full collection period */
}

/*
 * Memory usage.
 */

private struct mallinfo mem_stats;

public void mem_stat(type)
long type;
{
	/* Initialize the mem statistics buffer, which will be used by the mem_info
	 * routine to fetch the fields value, one at a time. By copying the whole
	 * structure atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	
	struct mallinfo *sm = meminfo(type);	/* Get structure by type */

	bcopy(sm, &mem_stats, sizeof(struct mallinfo));
}

public long mem_info(field)
long field;
{
	/* Extracts values from the mallinfo structure */

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
}

/*
 * GC statistics.
 */

private struct gacstat gc_stats;
private long gc_count;

public void gc_mon(flag)
char flag;
{
	gc_monitor = (int) flag;	/* Turn GC statistics on/off */
}

public void gc_stat(type)
long type;
{
	/* Initialize the GC statistics buffer, which will be used by the gc_info
	 * routine to fetch the fields value, one at a time. By copying the whole
	 * structure atomically and then fetching the fields on the copy, we ensure
	 * the integrity of the data (otherwise, the memory statistics could
	 * suddenly be changed by a call to the GC)--RAM.
	 */
	
	struct gacstat *gs = &g_stat[type];	/* Get structure by type */

	bcopy(gs, &gc_stats, sizeof(struct gacstat));

	if (type == GST_PART)
		gc_count = g_data.nb_full;
	else
		gc_count = g_data.nb_partial;
}

public long gc_info(field)
long field;
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
}

public double gc_infod(field)
long field;
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
}

/*
 * Is garbage collection enabled?
 */

public char gc_ison()
{
	return g_data.status & GC_STOP ? '\0' : '\01';
}

