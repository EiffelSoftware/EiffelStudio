#include "malloc.c"

/*
 * Offcial end of malloc.
 */

#ifdef MEMCHK

/*
 * Memck: a memory consistency checker.
 *
 * The following routines are implementing a memory consistency checker. They
 * scan the memory and report inconsistencies on the standard output descriptor.
 * Messages referring to "block" give zone addresses whereas messages referring
 * to "object" give actual object addresses (i.e. the user pointer we got from
 * eif_malloc).
 */

#include <stdio.h>
#include <signal.h>

#define CHUNK_T		0			/* Scanning a chunk */
#define ZONE_T		1			/* Scanning a generation scavenging zone */

rt_private int max_dtype;			/* Maximum dynamic type in system */
rt_private int *obj_use = 0;		/* Object usage table by dynamic type */
rt_private int c_blocks;			/* Number of C blocks found */
rt_private int c_size;				/* Amount of memory used by C objects */
rt_private int mefree;				/* Memory listed in Eiffel free list */
rt_private int mcfree;				/* Memory listed in C free list */

rt_private void check_chunk(register5 char *, register6 char *, int);
rt_private void check_free_list(register1 union overhead *);
rt_private void check_flags(char *, char *);
rt_private void check_ref(char *);

rt_private void check_free_list(register1 union overhead *next)
{
	/* Make sure free block is in the free list */
	EIF_GET_CONTEXT
			
	register2 uint32 i;					/* Hashing list */
	register3 union overhead *p;		/* To walk along free list */
	register4 union overhead **hlist;	/* The free list */
	register5 union overhead **blist;	/* Associated buffer cache */
	register6 uint32 r;					/* For size hashing */
	int notfound = 0;					/* Assume block found */

	/* First compute the hashing list from the size information */
	r = next->ov_size & B_SIZE;
	i = 0;
	while (r >>= 1)
		i++;

	/* As each block carries its type, we are able to determine which free
	 * list it belongs. This is completely hidden by the interface with
	 * the outside world, and, as mentionned before, I love it :-)--RAM.
	 */
	hlist = FREE_LIST(next->ov_size & B_CTYPE);		/* Get right list ptr */
	blist = BUFFER(hlist);							/* And associated cache */

	/* To avoid the cost of an extra variable, look whether it is in hlist[i]
	 * first. That way, we will be able to test only for the next field in the
	 * loop and still have a pointer on current, so that we can update the list.
	 */
	if (next != hlist[i]) {
		p = blist[i];				/* Cached value = location of last op */
		if (!p || next <= p)		/* Is it ok ? */
			p = hlist[i];			/* No, it is before the cached location */
		for (; p; p = p->ov_next) {
			if (p->ov_next == next) {			/* Next block is ok */
				blist[i] = p;					/* Last operation */
				break;							/* Exit from loop */
			}
		}
		/* Consistency check: we MUST have found the block */
		if (p == (union overhead *) 0) {
			printf("memck: block 0x%lx not found in %s list #%d\n",
				next, next->ov_size & B_CTYPE ? "C" : "Eiffel", i);
#ifdef MEMPANIC
			printf("Dumping of list:\n");
			for (p = hlist[i]; p; p = p->ov_next)
				printf("\t0x%lx\n", p);
#endif
			notfound = 1;
			mempanic;
		}
	} else
		blist[i] = hlist[i];		/* Record last operation on free list */

	if (!notfound) {
		r = next->ov_size;
		if (r & B_CTYPE)
			mcfree += (r & B_SIZE) + OVERHEAD;
		else
			mefree += (r & B_SIZE) + OVERHEAD;
	}
}

rt_private void check_ref(char *object)
{
	/* Make sure the references held in the object are valid */
	EIF_GET_CONTEXT

	union overhead *zone;
	uint32 flags;
	uint32 size;
	int refs;
	char *root;
	int has_expanded = 0;

	/* This is a copy of the scheme used in refers_new_object() */

	size = REFSIZ;
	zone = HEADER(object);
	flags = zone->ov_flags;

	if (Deif_bid(flags) > max_dtype) {
		printf("memck: object 0x%lx exceeds maximum dtype (%d), skipped.\n",
			object, flags & EO_TYPE);
		mempanic;
		return;
	}

	if (flags & EO_SPEC) {
		if (!(flags & EO_REF))
			return;
		size = (zone->ov_size & B_SIZE) - LNGPAD_2;
		refs = *(long *) (object + size);
		if (flags & EO_COMP)
			size = *(long *) (object + size + sizeof(long)) + OVERHEAD;
		else
			size = REFSIZ;
	} else
		refs = References(Deif_bid(flags));
	
	for (; refs != 0; refs--, object += size) {
		root = *(EIF_REFERENCE *) object;
		if (root == (EIF_REFERENCE) 0)
			continue;
		if (HEADER(root)->ov_flags & EO_EXP) {
			check_flags(root, zone + 1);		/* Explore expanded */
			has_expanded++;
		} else
			check_flags(root, zone + 1);
	}

	if (flags & EO_COMP) {				/* Object advertised some expandeds */
		if (!has_expanded) {
			printf("memck: object 0x%lx is EO_COMP but no expanded.", object);
			mempanic;
		}
	} else {
		if (has_expanded) {
			printf("memck: object 0x%lx not EO_COMP with %d expanded%s.",
				object, has_expanded, has_expanded == 1 ? "" : "s");
			mempanic;
		}
	}
}

rt_private void check_flags(EIF_REFERENCE object, EIF_REFERENCE from)
{
	/* Check the flags consistency in object. If from is a non null reference,
	 * that means the checking is currently being done by exploring the
	 * references from this object.
	 */
	EIF_GET_CONTEXT

	int dtype, dftype;
	uint32 flags;
	int num = 0;

	flags  = HEADER(object)->ov_flags;		/* Fetch Eiffel flags */
	dftype = flags & EO_TYPE;
	dtype  = Deif_bid(dftype);

	if (flags & EO_C)						/* Not an Eiffel object */
		return;;

	if ((uint32) object % MEM_ALIGNBYTES) {
		num++;
		printf("memck: object 0x%lx is mis-aligned.\n", object);
	}

	if (dtype > max_dtype) {
		num++;
		printf("memck: object 0x%lx exceeds maximum dynamic type (%d).\n",
			object, dtype);
	} else if (from == (char *) 0)
		obj_use[Deif_bid(flags)]++;

	if (dtype <= max_dtype && !(flags & EO_SPEC) && !(flags & EO_EXP)) {
		int mod;
		int nbytes = EIF_Size(dtype);
		int size = HEADER(object)->ov_size & B_SIZE;

		mod = nbytes % ALIGNMAX;
		if (mod != 0)
			nbytes += ALIGNMAX - mod; 

		if (size != nbytes) {
			num++;
			printf("memck: object 0x%lx should be %d bytes (is %d)\n",
				object, nbytes, size);
		}
	}

	if (flags & EO_MARK) {
		num++;
		printf("memck: object 0x%lx is marked with EO_MARK.\n", object);
	}

	if ((flags & EO_OLD) && (flags & EO_NEW)) {
		num++;
		printf("memck: object 0x%lx both EO_OLD and EO_NEW.\n", object);
	}
	
	if ((flags & EO_REM) && !(flags & EO_OLD)) {
		num++;
		printf("memck: object 0x%lx is EO_REM and not EO_OLD.\n", object);
	}

	if ((flags & EO_REM) && (flags & EO_NEW)) {
		num++;
		printf("memck: object 0x%lx is EO_REM and EO_NEW.\n", object);
	}

	if ((flags & EO_C) && (flags & EO_SPEC)) {
		num++;
		printf("memck: object 0x%lx is EO_C and EO_SPEC.\n", object);
	}

	if ((flags & EO_EXP) && (flags & EO_SPEC)) {
		num++;
		printf("memck: object 0x%lx is EO_EXP and EO_SPEC.\n", object);
	}

#ifdef WORKBENCH
	if (flags & EO_STOP) {
		num++;
		printf("memck: object 0x%lx is marked with EO_STOP.\n", object);
	}
#endif

	if (num && from != (char *) 0) {
		printf("memck: last %d messages while exploring %s0x%lx (DT %d)\n",
			num, flags & EO_EXP ? "expanded inside " : "", from,
			Dtype(from));
		mempanic;
	}
}

rt_public void memck(unsigned int max_dt)
{
	/* Perform consistency checks on the memory and report failures by messages
	 * on stdout. This routine is intended to be used as a debugging tool only.
	 * The argument max_dt gives the maximum possible dynamic type, which
	 * may help discover any discrepancy. If not specified (i.e. 0 is given)
	 * then the maximum possible value is used.
	 */
	EIF_GET_CONTEXT

	struct chunk *chunk;		/* Current chunk */
	char *arena;				/* Arena in chunk */

	if (max_dt == 0)			/* Maximum dtype left unspecified */
		max_dtype = scount - 1;
	else
		max_dtype = max_dt;

	if (max_dtype >= scount) {
		printf("memck: warning: dtype requested %d, maximum is %d\n",
			max_dtype, scount - 1);
		max_dtype = scount - 1;
	}
		
	if (obj_use == (int *) 0) {
		obj_use = (int *) xmalloc(scount * sizeof(int), C_T, GC_OFF);
		if (obj_use == (int *) 0) {
			printf("memck: cannot build object table\n");
			fflush(stdout);
			return;
		}
	}
	memset (obj_use, 0, scount * sizeof(int));

	c_blocks = c_size = 0;
	mefree = mcfree = 0;

	printf("memck: checking memory with maximum type of %d...\n", max_dtype);
	fflush(stdout);				/* Flush message right away */

	for (chunk = cklst.ck_tail; chunk; chunk = chunk->ck_prev) {

		arena = (char *) (chunk + 1);

		if (arena == ps_to.sc_arena)
			continue;			/* Skip 'to' zone since it is always empty */

		check_chunk((char *)chunk, arena, CHUNK_T);
	}

	/* If generation scavenging is active, check 'from' zone */

	if (gen_scavenge & GS_ON)
		check_chunk((char *)&sc_from, sc_from.sc_arena, ZONE_T);

	printf("memck: checking done.\n", max_dtype);
	fflush(stdout);				/* Make sure we always see messages */
}

rt_private void check_chunk(register5 char *chunk, register6 char *arena, int type)
		/* A struct chunk or struct sc_zone */
		/* Arena were objects are stored */
		/* Type is either CHUNK_T or ZONE_T */
{
	/* Consistency checks on the chunk's contents */
	EIF_GET_CONTEXT
	register1 union overhead *zone;		/* Malloc info zone */
	register2 uint32 size;				/* Object's size in bytes */
	register3 char *end;				/* First address beyond chunk */
	register4 uint32 flags;				/* Eiffel flags */

	switch (type) {
	case CHUNK_T:
		end = (char *) arena + ((struct chunk *) chunk)->ck_length;
		break;
	case ZONE_T:
		end = (char *) ((struct sc_zone *) chunk)->sc_top;
		break;
	}

	for (
		zone = (union overhead *) arena;
		(char *) zone < end;
		zone = (union overhead *) (((char *) zone) + (size & B_SIZE) + OVERHEAD)
	) {
		size = zone->ov_size;			/* Size and flags */

		if (size % MEM_ALIGNBYTES) {
			printf("memck: block 0x%lx has size %d\n", zone, size);
			mempanic;
		}

		/* The first consistency checking is made on the malloc flags. If
		 * the block is large enough to hit the end of the chunk it must be
		 * B_LAST. Also its B_CTYPE bit must be correctly set depending on
		 * the type of the chunk. All the tests are pretty trivial, so I won't
		 * comment much of them.
		 */

		if ((char *) zone + (size & B_SIZE) + OVERHEAD > end)
			if (type == CHUNK_T) {
				printf("memck: block 0x%lx goes beyond chunk.\n", zone);
				mempanic;
			} else {
				printf("memck: block 0x%lx goes beyond top of zone.\n", zone);
				mempanic;
			}
		
		if (
			type == CHUNK_T &&
			(char *) zone + (size & B_SIZE) + OVERHEAD == end
		)
			if (!(size & B_LAST)) {
				printf("memck: block 0x%lx not marked B_LAST.\n", zone);
				mempanic;
			}

		if (type == CHUNK_T) {
			if (((struct chunk *) chunk)->ck_type == C_T) {
				if (!(size & B_CTYPE)) {
					printf("memck: block 0x%lx should be B_CTYPE.\n", zone);
					mempanic;
				}
			} else {
				if (size & B_CTYPE) {
					printf("memck: block 0x%lx cannot be B_CTYPE.\n", zone);
					mempanic;
				}
			}
		}

		if (size & B_FWD) {
			printf("memck: block 0x%lx marked with B_FWD.\n", zone);
			mempanic;
		}

		if (type == CHUNK_T && !(size & B_BUSY)) {
			check_free_list(zone);	/* Make sure it is in free list */
			continue;
		}

		if (size & B_C) {
			c_blocks++;
			c_size += (size & B_SIZE) + OVERHEAD;
		}

		arena = (char *) (zone + 1);	/* Get public object pointer */

		if (!(size & B_BUSY) && type != ZONE_T)		/* Object is free */
			continue;

		if (zone->ov_flags & EO_C)		/* Not an Eiffel object */
			continue;

		if (type == CHUNK_T) {			/* Not in scavenge zone */

			if (((struct chunk *) chunk)->ck_type == C_T && size & B_C)
				continue;

			if (!(zone->ov_flags & EO_OLD) && !(zone->ov_flags & EO_NEW)) {
				printf("memck: object 0x%lx neither OLD nor NEW.\n", arena);
				mempanic;
			}
		}

		check_flags(arena, (char *) 0);	/* Check flags consistency */
		check_ref(arena);				/* Make sure references are valid */
	}
}

rt_private void output_free_list(FILE *f)
{
	EIF_GET_CONTEXT
	int ncblocks[NBLOCKS];		/* Number of C blocks in free list */
	int ncsize[NBLOCKS];		/* Size of C free list (with overhead) */
	int neblocks[NBLOCKS];		/* Number of Eiffel blocks in free list */
	int nesize[NBLOCKS];		/* Size of Eiffel free list (with overhead) */
	int tcblocks = 0;			/* Total number of blocks in C list */
	int tcsize = 0;				/* Size of blocs in free C list */
	int teblocks = 0;			/* Total number of blocks in Eiffel list */
	int tesize = 0;				/* Size of blocs in free Eiffel list */
	int i;
	union overhead *p;

	for (i = 0; i < NBLOCKS; i++)
		neblocks[i] = nesize[i] = ncblocks[i] = ncsize[i] = 0;

	for (i = 0; i < NBLOCKS; i++)
		for (p = e_hlist[i]; p; p = p->ov_next)
			neblocks[i]++, nesize[i] += (p->ov_size & B_SIZE) + OVERHEAD;

	for (i = 0; i < NBLOCKS; i++)
		for (p = c_hlist[i]; p; p = p->ov_next)
			ncblocks[i]++, ncsize[i] += (p->ov_size & B_SIZE) + OVERHEAD;

	for (i = 0; i < NBLOCKS; i++) {
		tcblocks += ncblocks[i];
		tcsize += ncsize[i];
		teblocks += neblocks[i];
		tesize += nesize[i];
	}

	fprintf(f, "memck: status of free list:\n");

	for (i = 0; i < NBLOCKS; i++)
		fprintf(f,
			"\t#%d: Eiffel %d blocks (%d bytes), C %d blocks (%d bytes)\n",
			i, neblocks[i], nesize[i], ncblocks[i], ncsize[i]);

	fprintf(f, "memck: summary of free list:\n");
	fprintf(f, "\tTOTAL: Eiffel %d blocks (%d bytes), C %d blocks (%d bytes)\n",
			teblocks, tesize, tcblocks, tcsize);
}

rt_private void output_table(FILE *f)
{
	EIF_GET_CONTEXT
	int i;
	int use;
	int usage;
	int nb_obj = 0;
	int mem_used = 0;

	fprintf(f, "memck: usage table:\n");;
	for (i = 0; i < scount; i++) {
		use = obj_use[i];
		if (use == 0)
			continue;
		usage = use * (EIF_Size(i) + OVERHEAD);
		fprintf(f, "\t%s: %d (%d bytes)\n", System(i).cn_generator, use, usage);
		nb_obj += use;
		mem_used += usage;
	}

	fprintf(f, "memck: usage summary: %d objects (%d bytes)\n",
		nb_obj, mem_used);
	fprintf(f, "memck: C usage: %d blocks (%d bytes)\n",
		c_blocks, c_size);
	fprintf(f, "memck: memory in free-list: Eiffel: %d bytes / C: %d bytes\n",
		mefree, mcfree);

	output_free_list(f);

	fprintf(f, "memck: current state of memory (total, Eiffel, C):\n");
	fprintf(f, "memck: chunks       : %d, %d, %d\n",
		m_data.ml_chunk, e_data.ml_chunk, c_data.ml_chunk);
	fprintf(f, "memck: total memory : %ld, %ld, %ld\n",
		m_data.ml_total, e_data.ml_total, c_data.ml_total);
	fprintf(f, "memck: overhead     : %ld, %ld, %ld\n",
		m_data.ml_over, e_data.ml_over, c_data.ml_over);
	fprintf(f, "memck: memory used  : %ld, %ld, %ld\n",
		m_data.ml_used, e_data.ml_used, c_data.ml_used);
	fprintf(f, "memck: memory free  : %ld, %ld, %ld\n",
		m_data.ml_total - m_data.ml_used - m_data.ml_over,
		e_data.ml_total - e_data.ml_used - e_data.ml_over,
		c_data.ml_total - c_data.ml_used - c_data.ml_over);

	fflush(f);
}

rt_shared void mem_diagnose(int sig)
{
	EIF_GET_CONTEXT
	printf("diagnosing memory...\n");
	fflush(stdout);
	if (sig == SIGUSR1) {
		printf("\tcollecting...\n");
		fflush(stdout);
		mksp();
	}
	printf("\tscanning...\n");
	memck(0);
	output_table(stdout);
}

rt_public eif_mem_info(EIF_BOOLEAN flag)
{
	EIF_GET_CONTEXT
	printf("diagnosing memory...\n");
	if (flag){
		printf("\tcollecting...\n");
		fflush(stdout);
		mksp();
	}
	printf("\tscanning...\n");
	memck(0);
	output_table(stdout);
}

#endif /* MEMCHK */


#ifndef EIF_THREADS
rt_private uint32 *type_use = 0;   /* Object usage table by dynamic type */
rt_private uint32 c_mem = 0;		/* C memory used (bytes) */
#endif /* EIF_THREADS */

/*rt_private void inspect();    (never defined) */
rt_private void check_obj(char *object);


rt_private void check_obj(char *object)
{
	EIF_GET_CONTEXT
	int dtype;
	uint32 flags;
	uint32 mflags;

	flags = HEADER(object)->ov_flags;		/* Fetch Eiffel flags */
	dtype = Deif_bid(flags);

	if (flags & EO_C) {						/* Not an Eiffel object */
		mflags = HEADER(object)->ov_size;
		c_mem += (mflags & B_SIZE) + OVERHEAD;
		return;;
	}

	if (dtype <= scount)
		type_use[Deif_bid(flags)]++;

}


rt_private void inspect_chunk(register char *chunk, register char *arena, int type)
					  		/* A struct chunk or struct sc_zone */
					  		/* Arena were objects are stored */
		 					/* Type is either CHUNK_T or ZONE_T */
{
	/* Consistency checks on the chunk's contents */

	register1 union overhead *zone;		/* Malloc info zone */
	register2 uint32 size;				/* Object's size in bytes */
	register3 char *end = (char *) 0;				/* First address beyond chunk */

	switch (type) {
	case CHUNK_T:
		end = (char *) arena + ((struct chunk *) chunk)->ck_length;
		break;
	case ZONE_T:
		end = (char *) ((struct sc_zone *) chunk)->sc_top;
		break;
	default:
		eif_panic ("Unknown chunk type");	
	}

	for (
		zone = (union overhead *) arena;
		(char *) zone < end;
		zone = (union overhead *) (((char *) zone) + (size & B_SIZE) + OVERHEAD)
	) {
		size = zone->ov_size;			/* Size and flags */

		if (type == CHUNK_T && !(size & B_BUSY)) {
			continue;
		}
		arena = (char *) (zone + 1);	/* Get public object pointer */

		if (!(size & B_BUSY) && type != ZONE_T)		/* Object is free */
			continue;

		if (zone->ov_flags & EO_C) {	/* Not an Eiffel object */
			check_obj(arena);
			continue;
		}

		if (type == CHUNK_T) {			/* Not in scavenge zone */

			if (((struct chunk *) chunk)->ck_type == C_T && size & B_C)
				continue;
		}

		check_obj(arena);
	}
}


rt_private void eif_memck(void)
{
	EIF_GET_CONTEXT
	struct chunk *chunk;		/* Current chunk */
	char *arena;				/* Arena in chunk */

	if (type_use == (uint32 *) 0) {
		type_use = (uint32 *) xmalloc(scount * sizeof(uint32), C_T, GC_OFF);
		if (type_use == (uint32 *) 0) {
			printf("memck: cannot build object table\n");
			fflush(stdout);
			return;
		}
	}
	memset (type_use, 0, scount * sizeof(uint32));

	c_mem = 0;					/* Initializes C memory usage */

	for (chunk = cklst.ck_tail; chunk; chunk = chunk->ck_prev) {

		arena = (char *) (chunk + 1);

		if (arena == ps_to.sc_arena)
			continue;			/* Skip 'to' zone since it is always empty */

		inspect_chunk((char *)chunk, arena, CHUNK_T);
	}

	/* If generation scavenging is active, check 'from' zone */
	if (gen_scavenge & GS_ON)
		inspect_chunk((char *)&sc_from, sc_from.sc_arena, ZONE_T);

	fflush(stdout);				/* Make sure we always see messages */

}

rt_public void eif_trace_types(FILE *f)
{
	EIF_GET_CONTEXT
	int i;
	uint32 use;
	uint32 usage;

	eif_memck();
	for (i = 0; i < scount; i++) {
		use = type_use[i];
		if (use == 0)
			continue;
		usage = use * (EIF_Size(i) + OVERHEAD);
		fprintf(f, "\t%s: %d (%d bytes)\n", System(i).cn_generator, use, usage);
	}
	fprintf(f, "C memory usage (bytes): %ld\n", (long) c_mem);
	fflush(f);

}


#ifdef TEST

/* This section implements a set of tests for the malloc package.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

#undef TEST
#undef DEBUG

#define lint 0					/* Avoid definition of rcsid */
#include "garcol.c"
#include "timer.c"

rt_private char *vmalloc(unsigned int);		/* Verbose malloc */
rt_private char *vcalloc(unsigned int);		/* Verbose calloc */
rt_private char *vrealloc(char *, unsigned int);/* Verbose realloc */
rt_private void vfree(char *);			/* Verbose free */
rt_private void mem_status(void);		/* Print memory status */
rt_private void mem_reset(void);		/* Reset memory */
rt_private void run_tests(void);		/* Run all the memory tests */

/* char *(**ecreate)(); FIXME: SEE EIF_PROJECT.C */
/* void (**edispose)(); FIXME: SEE EIF_PROJECT.C */
long nbref[1];

rt_public main(void)
{
	/* Tests the memory allocation package */

	printf("> Starting tests for malloc package\n");
	printf("> Package has been optimized for %s\n",
		cc_for_speed ? "speed" : "memory");
	run_tests();
	mem_reset();
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
	/* Run all the memory tests */

	int i, j;
	char *p[8];
	char *p1, *p2, *p3;

	printf(">> Testing malloc(0)\n");
	(void) vmalloc(0);

	/* Start with intensive mallocs */

	printf(">> Mallocing memory (small blocks)\n");
	for (j = 1, i = 0; i < 4; i++, j += 32)
		(void) vmalloc(j);

	printf(">> Mallocing memory (big blocks) with frees\n");
	for (j = CHUNK_DEFAULT, i = 0; i < 3; i++, j *= 2)
		vfree(vmalloc(j));

	printf(">> Ensuring big mallocs fail\n");
	vmalloc(1<<(NBLOCKS + 1));
	
	mem_reset();

	/* Test coalescing */

	printf(">> Testing coalsecing (I)\n");
	p1 = vmalloc(10);
	p2 = vmalloc(12);
	printf(">>> Coalescing expected here\n");
	vfree(p2);
	printf(">>> And also here\n");
	vfree(p1);

	printf(">> Testing coalsecing (II)\n");
	p1 = vmalloc(10);
	p2 = vmalloc(1);
	p3 = vmalloc(12);
	printf(">>> Coalescing expected here\n");
	vfree(p3);
	printf(">> But not here\n");
	vfree(p1);
	printf(">>> Another coalescing case\n");
	vfree(p2);
	
	mem_reset();

	/* Testing calloc */
	printf(">> Testing calloc, followed by free\n");
	printf(">>> Big block...\n");
	p1 = vcalloc(CHUNK_DEFAULT + 5);
	printf(">>> Small block...\n");
	p2 = vcalloc(40);
	vfree(p2);
	vfree(p1);
	printf(">>> Big block again !!\n");
	p1 = vcalloc(CHUNK_DEFAULT + 5);
	vfree(p1);

	mem_reset();

	/* Test realloc */

	printf(">> Testing realloc\n");
	printf(">>> Allocating first block\n");
	p1 = vmalloc(128);
	printf(">>> Allocating second block to force moving\n");
	p2 = vmalloc(128);
	printf(">>> Extending first block (expect move)\n");
	p1 = vrealloc(p1, 256);
	printf(">>> Void reallocating...\n");
	p1 = vrealloc(p1, 256);
	printf(">>> Shrinking second block (no move, split -> null size block)\n");
	p2 = vrealloc(p2, 128 - ALIGNMAX - 1);
	printf(">>> Re-extending second block (no move)\n");
	p2 = vrealloc(p2, 128);
	printf(">>> Shrinking second block (no move, but split)\n");
	p2 = vrealloc(p2, 40);
	printf(">>> Shrinking second block again (no move, no split)\n");
	p2 = vrealloc(p2, 37);
	printf(">>> Re-extending second block (no move but coalescing)\n");
	p2 = vrealloc(p2, 128);
	printf(">>> Extending second block (expect move)\n");
	p2 = vrealloc(p2, 256);
	printf(">>> Freeing second block\n");
	vfree(p2);
	printf(">>> Extending first block (expect coalescing)\n");
	p1 = vrealloc(p1, 512);
	printf(">>> Freeing first block\n");
	vfree(p1);
	mem_reset();

	/* Testing full_coalesc */

	printf(">> Testing full coalescing\n");
	printf(">>> Mallocing 8 blocks (A B C D E F G H)\n");
	for (i = 0; i < 8; i++) {
		printf(">>> Mallocing block %c\n", 'A' + i);
		p[i] = xmalloc(30000, C_T, GC_OFF);
	}
	mem_status();
	printf(">>> Freeing 5 blocks (G, H, C, D, E)\n");
	printf(">>> Freeing G\n");
	xfree(p[6]);
	printf(">>> Freeing H\n");
	xfree(p[7]);
	printf(">>> Freeing C\n");
	xfree(p[2]);
	printf(">>> Freeing D\n");
	xfree(p[3]);
	printf(">>> Freeing E\n");
	xfree(p[4]);
	mem_status();
	printf(">>> Running full coalescing\n");
	full_coalesc(C_T);
	mem_status();
	printf(">>> Freeing remaining blocks\n");
	printf(">>> Freeing A\n");
	xfree(p[0]);
	printf(">>> Freeing B\n");
	xfree(p[1]);
	printf(">>> Freeing F\n");
	xfree(p[5]);
	mem_status();
	printf(">>> Running full coalescing again\n");
	full_coalesc(C_T);
	mem_status();

	/* Test Eiffel malloc */

	printf(">> Testing emalloc (Eiffel malloc)\n");
	for (i = 0; i < 8; i++)
		(void) emalloc(0);
	mem_status();

	printf(">> Testing spmalloc (Eiffel special objects)\n");
	for (i = 0; i < 8; i++)
		(void) spmalloc(i * 40);
	mem_status();

	/* Test explosion of scavenge space if necessary */
	if (gen_scavenge & GS_ON) {
		printf(">> Exploding scavenge zone\n");
		explode_scavenge_zone(&sc_from);
		mem_status();
	}
}

rt_private char *vmalloc(unsigned int size)
{
	char *result;
	
	printf(">>>> mallocing %d bytes\n", size);
	result = xmalloc(size, C_T, GC_OFF);
	if (result == (char *) 0)
		printf(">>>> FAILED: malloc (%d bytes)\n", size);
	mem_status();
	
	return result;
}

rt_private void vfree(char *ptr)
{
	union overhead *zone = ((union overhead *) ptr) - 1;

	printf(">>>> freeing %d bytes\n", zone->ov_size & B_SIZE);
	xfree(ptr);
	mem_status();
}

rt_private char *vcalloc(unsigned int size)
{
	char *result;

	printf(">>>> callocing %d bytes\n", size);
	result = xcalloc(size, 1);
	if (result == (char *) 0)
		printf(">>>> FAILED: calloc (%d bytes)\n", size);
	mem_status();
	
	return result;
}

rt_private char *vrealloc(char *ptr, unsigned int size)
{
	char *result;
	unsigned int i = ((union overhead *) ptr - 1)->ov_size & B_SIZE;

	printf(">>>> reallocing %d bytes into %d\n", i, size);
	result = xrealloc(ptr, size, GC_OFF);
	if (result == (char *) 0)
		printf(">>>> FAILED: realloc (%d bytes)\n", size);
	else if (result == ptr)
		printf(">>>> block was not moved\n");
	else
		printf(">>>> block was moved\n");
	mem_status();
	
	return result;
}

rt_private void mem_status(void)
{
	/* Prints memory status */

	printf(">>>> Current state of memory\n");
	printf(">>>>> chunks       : %d\n", m_data.ml_chunk);
	printf(">>>>> total memory : %ld\n", m_data.ml_total);
	printf(">>>>> overhead     : %ld\n", m_data.ml_over);
	printf(">>>>> memory used  : %ld\n", m_data.ml_used);
	printf(">>>>> memory free  : %ld\n",
		m_data.ml_total - m_data.ml_used - m_data.ml_over);
	printf(">>>>> C chunks       : %d\n", c_data.ml_chunk);
	printf(">>>>> C total memory : %ld\n", c_data.ml_total);
	printf(">>>>> C overhead     : %ld\n", c_data.ml_over);
	printf(">>>>> C memory used  : %ld\n", c_data.ml_used);
	printf(">>>>> C memory free  : %ld\n",
		c_data.ml_total - c_data.ml_used - c_data.ml_over);
	printf(">>>>> Eiffel chunks       : %d\n", e_data.ml_chunk);
	printf(">>>>> Eiffel total memory : %ld\n", e_data.ml_total);
	printf(">>>>> Eiffel overhead     : %ld\n", e_data.ml_over);
	printf(">>>>> Eiffel memory used  : %ld\n", e_data.ml_used);
	printf(">>>>> Eiffel memory free  : %ld\n",
		e_data.ml_total - e_data.ml_used - e_data.ml_over);
}

rt_private void mem_reset(void)
{
	/* Reset memory */

	int i;

	printf(">> Reseting memory\n");
	mem_status();
	printf(">>> Releasing core\n");
		rel_core();
	mem_status();
	printf(">>> Resetting internal data structures\n");
	for (i = 0; i < NBLOCKS; i++) {
		c_hlist[i] = (union overhead *) 0;
		e_hlist[i] = (union overhead *) 0;
	}
	m_data.ml_chunk = m_data.ml_total = 0;
	m_data.ml_over = m_data.ml_used = 0;
	c_data.ml_chunk = c_data.ml_total = 0;
	c_data.ml_over = c_data.ml_used = 0;
	e_data.ml_chunk = e_data.ml_total = 0;
	e_data.ml_over = e_data.ml_used = 0;
	cklst.ck_head = cklst.ck_tail = 0;
	cklst.cck_head = cklst.cck_tail = 0;
	cklst.eck_head = cklst.eck_tail = 0;
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

rt_public struct xstack eif_stack = {		/* Calling stack */
	(struct stxchunk *) 0,				/* st_hd */
	(struct stxchunk *) 0,				/* st_tl */
	(struct stxchunk *) 0,				/* st_cur */
	(struct ex_vect *) 0,				/* st_top */
	(struct ex_vect *) 0,				/* st_end */
	(struct ex_vect *) 0,				/* st_bot */
};
rt_public struct xstack eif_trace = {		/* Exception trace */
	(struct stxchunk *) 0,				/* st_hd */
	(struct stxchunk *) 0,				/* st_tl */
	(struct stxchunk *) 0,				/* st_cur */
	(struct ex_vect *) 0,				/* st_top */
	(struct ex_vect *) 0,				/* st_end */
	(struct ex_vect *) 0,				/* st_bot */
};

rt_public struct stack hec_stack = {			/* Indirection table "hector" */
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};

#include "eif_sig.h"
struct s_stack sig_stk;		/* Initialized by initsig() */
int esigblk = 0;			/* By default, signals are not blocked */

rt_public void ufill(void)
{
}

rt_public void esdpch(void)
{
}

rt_public void epop(void)
{
}

rt_public struct cnode esystem[20];

#endif

