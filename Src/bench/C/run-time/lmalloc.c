/*

 #       #    #    ##    #       #        ####    ####            ####
 #       ##  ##   #  #   #       #       #    #  #    #          #    #
 #       # ## #  #    #  #       #       #    #  #               #
 #       #    #  ######  #       #       #    #  #        ###    #
 #       #    #  #    #  #       #       #    #  #    #   ###    #    #
 ######  #    #  #    #  ######  ######   ####    ####    ###     ####

	Malloc library functions.

	This file is intended to be linked with an Eiffel application which
	uses external C software (object files or libraries like X11 or curses).
	Provided that no '-lc' appears on the linking line BEFORE the run-time
	archive, the malloc() used will be the one from the Eiffel run-time.
*/

#ifndef EIF_THREADS

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_lmalloc.h"

#ifdef I_STRING
#include <string.h>		/* For memset(), bzero() */
#else
#include <strings.h>
#endif

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/* Important: I've turned the GC off when malloc routines are ran because I
 * have the feeling it would introduce confusion in the brain of the final
 * Eiffel users. It is possible to use cmalloc() and al. instead if GC is
 * wanted, but that makes a difference only when we are short in memory--RAM.
 */

rt_public Malloc_t malloc(register unsigned int nbytes)
{
	char *arena;

	/* The C object does not use its Eiffel flags field in the header. However,
	 * we set the EO_C bit. This will help the GC because it won't need
	 * extra-tests to skip the C arenas referenced by Eiffel objects.
	 */

	arena = xmalloc(nbytes, C_T, GC_OFF);
	if (arena != (char *) 0)
		HEADER(arena)->ov_flags = EO_C;		/* Clear all flags but EO_C */

	return (Malloc_t) arena;
}

rt_public Malloc_t calloc(unsigned int nelem, unsigned int elsize)
{
	register1 unsigned int nbytes = nelem * elsize;
	register2 Malloc_t allocated;

	allocated = malloc(nbytes);
	if (allocated != (Malloc_t) 0)
		bzero(allocated, nbytes);

	return allocated;
}

rt_public Malloc_t realloc(register void *ptr, register unsigned int nbytes)
{
	/* A realloc with a null pointer has to be equivalent to a single malloc */

	if (ptr == (Malloc_t) 0)
		return malloc(nbytes);

	return (Malloc_t) xrealloc(ptr, nbytes, GC_OFF);
}

void free(register void *ptr)
{
	/* Free is guaranteed to work enven with a null pointer, while xfree will
	 * most probably dump a core...
	 */

	if (ptr == (Malloc_t) 0)
		return;

	xfree(ptr);
}

#endif /* EIF_THREADS */
