#include "garcol.c"

/* This section implements a set of tests for the garbage collector.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

#undef TEST
#undef DEBUG
#define lint					/* Avoid definition of rcsid */
#include "malloc.c"
#include "timer.c"


rt_private void run_tests(void);		/* Run all the garbage collector's tests */
rt_private void scavenge_trace(void);	/* Statistics on the scavenge space */
rt_private void run_gc(void);			/* Run garbage collector with statistics */

rt_public main(void)
{
	/* Tests for the garbage collector */

	printf("> Starting tests for the garbage collector\n");
	printf("> Package has been optimized for %s\n",
		cc_for_speed ? "speed" : "memory");
	run_tests();

	/* Generation scavenging is going to be turned off. The garbage collector
	 * can only run correctly if the remembered set is reset.
	 */
	st_reset(&rem_set);
	st_reset(&moved_set);

	printf("> Switching optimizations\n");
	cc_for_speed = 1 - cc_for_speed;
	printf("> Package is now optimized for %s\n",
		cc_for_speed ? "speed" : "memory");
	run_tests();
	printf("> End of tests\n");
	exit(0);
}

rt_private void run_tests(void)
{
	/* Run all garbage collector's tests */

	int i;
	EIF_REFERENCE p;

	/* Test generation-based collectors */

	printf(">> Testing generation collection\n");
	scavenge_trace();
	printf(">> Allocating 15 objects (void references, all remembered)\n");
	for (i = 0; i < 15; i++)
		epush(&rem_set, emalloc(0));
	scavenge_trace();
	printf(">> Collecting...\n");
	(void) collect();
	scavenge_trace();
	printf(">> Scavenge again (everything is to be collected)\n");
	(void) collect();
	scavenge_trace();
	printf(">> Allocating 15 objects (self references, all remembered)\n");
	for (i = 0; i < 15; i++) {
		epush(&rem_set, (p = emalloc(0)));
		*(EIF_REFERENCE *) p = p;			/* Double reference on itself */
		*((EIF_REFERENCE *) p + 1) = p;
	}
	printf(">> Collecting...\n");
	(void) collect();
	scavenge_trace();
	printf(">> Scavenge again (nothing is to be collected)\n");
	(void) collect();
	scavenge_trace();

	printf(">> Taking one object for root\n");
	root_obj = p;
	printf(">> Partial scavenge...\n");
	run_gc();
	scavenge_trace();

	printf(">> Releasing the root object\n");
	root_obj = 0;
	printf(">> Partial scavenge... (collects one garbage object)\n");
	run_gc();
	scavenge_trace();
}

rt_private void scavenge_trace(void)
{
	printf(">>> Scavenging flags: ");
	printf("%s%s%s%s\n",
		gen_scavenge & GS_OFF ? "GS_OFF " : "",
		gen_scavenge & GS_ON ? "GS_ON " : "",
		gen_scavenge & GS_SET ? "GS_SET " : "",
		gen_scavenge & GS_STOP ? "GS_STOP " : "");
	printf(">>> Bytes used in from: %d\n", sc_from.sc_top - sc_from.sc_arena);
	printf(">>> Objects remebered: %d\n", nb_items(&rem_set));
	printf(">>> Moved set: %d\n", nb_items(&moved_set));
}

rt_private void run_gc(void)
{
	scollect(partial_scavenging, GST_PART);
	printf(">>> GC status:\n");
	printf(">>>> # of full collects    : %ld\n", g_data.nb_full);
	printf(">>>> # of partial collects : %ld\n", g_data.nb_partial);
	printf(">>>> Amount of memory freed: %ld\n", g_stat->mem_collect);
	printf(">>>> Total time used       : %lfs\n", g_stat->real_time / 100.);
	printf(">>>> Total time used (avg) : %lfs\n", g_stat->real_avg / 100.);
	printf(">>>> CPU time used         : %lfs\n", g_stat->cpu_time);
	printf(">>>> CPU time used (avg)   : %lfs\n", g_stat->cpu_avg);
	printf(">>>> System time used      : %lfs\n", g_stat->sys_time);
	printf(">>>> System time used (avg): %lfs\n", g_stat->sys_avg);
}

/* Functions not provided here */
rt_public void eraise(char *tag, int val)
{
	printf("Exception: %s (code %d)\n", tag, val);
	exit(1);
}

rt_public void enomem(void)
{
	eraise("Out of memory", 0);
}

rt_public void eif_panic(char *s)
{
	printf("PANIC: %s\n", s);
	exit(1);
}

