/*

 #       #    #    ##    #       #        ####    ####            ####
 #       ##  ##   #  #   #       #       #    #  #    #          #    #
 #       # ## #  #    #  #       #       #    #  #               #
 #       #    #  ######  #       #       #    #  #        ###    #
 #       #    #  #    #  #       #       #    #  #    #   ###    #    #
 ######  #    #  #    #  ######  ######   ####    ####    ###     ####

	Malloc library functions.

  This file provides an Eiffel implementation of malloc, calloc, realloc,
  and free which are eif_malloc, eif_calloc, eif_realloc, and
  eif_free but only for the Unix/Linux platforms in NON-multithreaded 
  mode. The other platforms call the features provided in the C library
  (malloc, realloc ...). For VXWORKS, we are not supposed to link this file
  to the run-time but we can do this to perform test for us ( but don't
  forget to remove it in the delivery to HP (the HP's engineers have their
  own malloc, ... we do not have, so we call our malloc in the C library).
  Manuelt.
*/

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

rt_public Malloc_t eif_malloc (register unsigned int nbytes)
{

#if defined EIF_THREADS
/* In multithreaded mode, we do not want to use the eiffel implementation * 
 * of eif_malloc () because when calling reclaim () in a thread we want   *
 * the thread to give back the memory to the system and not to the        *
 * free-list. Otherwise, the creation of thread would be quite costly     *
 * manuelt. */

	return (Malloc_t) malloc (nbytes);

#elif defined EIF_WIN32 || defined EIF_VMS
/* For Windows and VMS platforms we use malloc() implemented in the C-library */
	return malloc (nbytes);

#elif defined VXWORKS
/* For VXWORKS, we have a special run-time. HP provides their own malloc ()
 *we do not have, so we call malloc() from the C-library to perform test */
#warning: file should not be linked for VXWORKS runtime. 
	return malloc (nbytes);

#else
/* all the other platforms (Unix/Linux) use an eiffel implementation *
 * for eif_malloc() */ 

	char *arena;

	/* The C object does not use its Eiffel flags field in the header. However,
	 * we set the EO_C bit. This will help the GC because it won't need
	 * extra-tests to skip the C arenas referenced by Eiffel objects.
	 */

	arena = xmalloc(nbytes, C_T, GC_OFF);
	if (arena != (char *) 0)
		HEADER(arena)->ov_flags = EO_C;		/* Clear all flags but EO_C */

	return (Malloc_t) arena;

#endif /* EIF_THREADS */	
}

rt_public Malloc_t eif_calloc (unsigned int nelem, unsigned int elsize)
{
#ifdef EIF_THREADS 
	return (Malloc_t) calloc (nelem, elsize);

#elif defined EIF_WIN32 || defined EIF_VMS
	return calloc (nelem, elsize);

#elif defined VXWORKS
#warning: file should not be linked for VXWORKS runtime.
	return calloc (nelem, elsize);

#else /* all the other platforms (Unix/Linux) use an eiffel implementation */
      /* for eif_calloc() */ 
	register1 unsigned int nbytes = nelem * elsize;
	register2 Malloc_t allocated;

	allocated = eif_malloc(nbytes);
	if (allocated != (Malloc_t) 0)
		bzero(allocated, nbytes);

	return allocated;

#endif /* EIF_THREADS */	
}

rt_public Malloc_t eif_realloc (register void *ptr, register unsigned int nbytes)
{
#ifdef EIF_THREADS 
	return (Malloc_t) realloc (ptr, nbytes);

#elif defined EIF_WIN32 || defined EIF_VMS
	return realloc (ptr, nbytes);

#elif defined VXWORKS
#warning: file should not be linked for VXWORKS runtime.
	return realloc (ptr,nbytes);

#else /* all the other platforms (Unix/Linux) use an eiffel implementation */
      /* for eif_realloc() */ 

	/* A realloc with a null pointer has to be equivalent to a single malloc */

	if (ptr == (Malloc_t) 0)
		return eif_malloc(nbytes);

	return (Malloc_t) xrealloc(ptr, nbytes, GC_OFF);

#endif /* EIF_THREADS */	
}

void eif_free(register void *ptr)
{
#if defined EIF_THREADS 
	free (ptr);

#elif defined EIF_WIN32 || defined EIF_VMS
	free (ptr);

#elif defined VXWORKS
#warning: file should not be linked for VXWORKS runtime
	free (ptr);

#else /* all the other platforms (Unix/Linux) use an eiffel implementation */
      /* for eif_free() */ 

	/* Free is guaranteed to work enven with a null pointer, while xfree will
	 * most probably dump a core...
	 */

	if (ptr == (Malloc_t) 0)
		return;
	xfree(ptr);

#endif /* EIF_THREADS */	
}

