/*

 #    #  #####    ####   ######  #    #   #####           ####
 #    #  #    #  #    #  #       ##   #     #            #    #
 #    #  #    #  #       #####   # #  #     #            #
 #    #  #####   #  ###  #       #  # #     #     ###    #
 #    #  #   #   #    #  #       #   ##     #     ###    #    #
  ####   #    #   ####   ######  #    #     #     ###     ####

	Urgent memory chunk handling. The purpose of urgent memory is to
	let the run-time get some memory in situations where the garbage
	collector cannot be called. A typical use would be getting a small
	chunk to let one of the internal stacks grow.

	Given that the overhead of the urgent memory is really small, it is
	allocated even if the package is optimized for memory.
*/

#include "config.h"
#include "portable.h"
#include "urgent.h"

/* Urgent memory chunks are held in an array. The urgent_index variable gives
 * the index in urgent_mem[] which holds the address of a free chunk of memory.
 * This index is decreased each time the run-time requests a chunk, and it
 * reaches -1 when the array has no more chunks in stock.
 */
private char *urgent_mem[URGENT_NBR];		/* Array holding urgent chunks */
private int urgent_index = -1;				/* Last index with free chunk */

/* Getting and releasing chunks */
shared void ufill();			/* Get as many chunks as possible */
shared char *uchunk();			/* Urgent allocation of a stack chunk */

/* I don't want to include malloc.h for a single declaration--RAM */
extern char *cmalloc();

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	1		/* Highest debug level */
#endif
#endif

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

shared void ufill()
{
	/* Fill in the urgent chunk array as far as possible. At the time this
	 * routine is called, it is safe to call the GC if we get short in memory,
	 * hence we may call cmalloc directly.
	 */

	register1 int i;					/* Location to be filled in */
	register2 char *chunk;				/* Allocated chunk */

	for (i = urgent_index + 1; i < URGENT_NBR; i++) {
		chunk = cmalloc(URGENT_CHUNK);	/* Attempt allocation */
		if (chunk == (char *) 0)		/* Could not get memory */
			break;
		urgent_mem[i] = chunk;			/* Record chunk for later perusal */
	}

	urgent_index = i - 1;				/* Points on last available chunk */
}

shared char *uchunk()
{
	/* Get an urgent chunk for stack growing. It would not be sane to allocate
	 * memory for an Eiffel object from this urgent stock, so be it--RAM.
	 * The function returns the address of the next free block of memory
	 * available, or NULL if there is none available. The chunk is suitable
	 * for immediate use: it  has to be split in two parts, one small header
	 * structure and the arena where data are stored.
	 */
	
	if (urgent_index > 0)					/* A free chunk is available */
		return urgent_mem[urgent_index--];	/* Return its address */

	return (char *) 0;			/* No chunk is available */
}


