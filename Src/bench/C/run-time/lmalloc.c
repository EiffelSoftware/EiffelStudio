/*

 #       #    #    ##    #       #        ####    ####            ####
 #       ##  ##   #  #   #       #       #    #  #    #          #    #
 #       # ## #  #    #  #       #       #    #  #               #
 #       #    #  ######  #       #       #    #  #        ###    #
 #       #    #  #    #  #       #       #    #  #    #   ###    #    #
 ######  #    #  #    #  ######  ######   ####    ####    ###     ####

	Malloc library functions.
	$Id$

  Wrappers to malloc functions from standard libs. 
  Define LMALLOC_CHECK, for checks and debugging output.

*/


#include "eif_portable.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_lmalloc.h"
#if defined LMALLOC_DEBUG || defined LMALLOC_CHECK
#include <stdio.h>
#endif	/* LMALLOC_CHECK or LMALLOC_DEBUG */
#include "rt_assert.h"

#if !defined EIF_VMS && !defined VXWORKS
#include <malloc.h>
#endif	/* !defined EIF_VMS && !defined VXWORKS */

#include <string.h>		/* For memset(), bzero() */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

#ifdef LMALLOC_CHECK


/*---------------*/
/* Definitions.  */
/*---------------*/
#define EIF_FSZ	16
struct lm_entry {
	void *ptr;	
	int line;
	char file[EIF_FSZ];
	struct lm_entry *next;
}; 

rt_shared void eif_lm_display ();
rt_shared int is_in_lm (void *ptr);
rt_private struct lm_entry **lm = (struct lm_entry **) 0;

rt_private int lm_create (); 
rt_private int lm_put (void *ptr, char *file, int line);
rt_private int lm_remove (void *ptr);
rt_shared  int eif_lm_free ();

/*----------------------*/
/* MT declarations.     */
/*----------------------*/

#ifdef EIF_THREADS
rt_private EIF_MUTEX_TYPE *lm_lock = NULL;
#define EIF_LM_LOCK \
	EIF_MUTEX_LOCK (lm_lock, "Couldn't lock lm lock"); \

#define EIF_LM_UNLOCK \
	EIF_MUTEX_UNLOCK (lm_lock, "Couldn't lock lm lock"); 

#else	/* EIF_THREADS */
#define EIF_LM_LOCK
#define EIF_LM_UNLOCK
#endif	/* EIF_THREADS */
	

/*-------------------------------------------*/
/* Create and initialize lm linked list.     */
/*-------------------------------------------*/
rt_private int lm_create () {

	REQUIRE ("lm not created", lm == (struct lm_entry **) 0);

	lm = (struct lm_entry **) malloc (sizeof(struct lm_entry *));
	if (!lm) 
		return -1;
	
	*lm = (struct lm_entry *) 0;
	return 0;
}

/*-------------------------------------*/
/* Add an entry in lm linked list.     */
/*-------------------------------------*/
rt_private int lm_put (void *ptr, char *file, int line) {

	struct lm_entry *ne;
	
#ifdef EIF_THREADS
	static int alloc = 0;
		
	if (!lm_lock) {
		if (alloc)	{/* Are we allocating lm lock? */
			if (lm_create ())
				return -1;
			return 0;
		}
		alloc = 1;
		EIF_MUTEX_CREATE (lm_lock, "Couldn't create lm lock\n");
		lm_put (lm_lock, "N/A", 0);
	}  
	CHECK ("lm already created", alloc == 1);
	CHECK ("lm_lock created", lm_lock != NULL);

#endif /* EIF_THREADS */

	EIF_LM_LOCK

	if (!lm) {
		if (lm_create ()) {
			EIF_LM_UNLOCK
			eif_panic ("Couldn't create lm linked list");
		}
	}

	ne = (struct lm_entry *) malloc (sizeof (struct lm_entry));

	if (!ne)	{
		EIF_LM_UNLOCK
		return -1;
	}

	ne->ptr = ptr;
	strncpy (ne->file, file, EIF_FSZ);
	ne->file [EIF_FSZ - 1] = '\0';
	ne->line = line;
	ne->next = *lm;
	*lm = ne;
	EIF_LM_UNLOCK;
	return 0;
}

/*-----------------------------------------*/
/* Remove an entry in lm linked list.      */
/*-----------------------------------------*/
rt_private int lm_remove (void *ptr) {

	struct lm_entry *cur;
	struct lm_entry *tmp;
#ifdef EIF_THREADS	
	if (ptr == lm_lock)
		return 0;
#endif

	EIF_LM_LOCK

	CHECK ("lm exists", lm != (struct lm_entry **) 0);	

	if (!ptr) {
		EIF_LM_UNLOCK
		return 0;
	}
	
	if (!lm) {	
		EIF_LM_UNLOCK
		return -1;
	}
		
	if (!(*lm)) {
		EIF_LM_UNLOCK
		return -1;
	}
		
	cur = *lm;
	if (cur->ptr == ptr) {
		*lm = cur->next;
		free (cur);
		EIF_LM_UNLOCK
		return 0;
	}

	tmp = cur->next;

	while (tmp)	{
		if (tmp->ptr == ptr) {
			cur->next = tmp->next;
#ifdef LMALLOC_DEBUG
			fprintf (stderr, "(allocated at %s:%d) ", tmp->file, tmp->line);
#endif
			free (tmp);
			EIF_LM_UNLOCK
			return 0;
		}
		cur = tmp;
		tmp = cur->next;
	}

	EIF_LM_UNLOCK
	return -1;

}

/*-----------------------------------*/
/* Occurrence of element in lm.      */
/*-----------------------------------*/
	
rt_shared int is_in_lm (void *ptr) {
	struct lm_entry *cur;

	EIF_LM_LOCK;
	if (!lm) {
		EIF_LM_UNLOCK;
		return 0;
	}
	for (cur = *lm; cur != NULL; cur = cur->next) {
		if (ptr == cur->ptr) {
			EIF_LM_UNLOCK
			return 1;
		}
	}
	EIF_LM_UNLOCK;	
	return 0;
}

/*------------------------------*/
/* Display lm linked list.      */
/*------------------------------*/
rt_shared void eif_lm_display () {
	struct lm_entry *cur;

#ifdef EIF_THREADS
	REQUIRE ("lm_lock exists", lm_lock != (EIF_MUTEX_TYPE *) 0);
#endif
	EIF_LM_LOCK;
	if (!(*lm)) {
		fprintf (stderr, "*** lm is empty ***\n");	
		EIF_LM_UNLOCK;
		return;
	}
	fprintf (stderr, "*** Objects remaining in lm list ***\n");
	for (cur = *lm; cur != NULL; cur = cur->next) {
		fprintf (stderr, "0x%x allocated at %s:%d\n", (size_t) cur->ptr,  cur->file, cur->line);
	}
	fprintf (stderr, "*** end ***\n");
	EIF_LM_UNLOCK;	
}
	

/*------------------------------*/
/* Free lm linked list.         */
/*------------------------------*/
rt_shared int eif_lm_free () {
	struct lm_entry *cur, *tmp;

#ifdef EIF_THREADS
	if (!lm_lock)
		return -1;
#endif
	EIF_LM_LOCK
	if (!lm) {
		EIF_LM_UNLOCK
		return -1;
	}
		
	for (cur = *lm; cur != NULL; ) {
		tmp = cur;
		cur = cur->next;	
		free (tmp);
	}
	free (lm);
	EIF_LM_UNLOCK
#ifdef EIF_THREADS
	fprintf (stderr, "*** Destroy and free lm lock 0x%lx\n", (unsigned long) lm_lock);
	EIF_MUTEX_DESTROY (lm_lock, "Couldn't destroy lm lock");
	lm_lock = NULL;
#endif /* EIF_THREADS */
	return 0;
}
#endif	/* LMALLOC_CHECK */

#if defined LMALLOC_DEBUG || defined LMALLOC_CHECK
rt_public Malloc_t eiffel_malloc (register unsigned int nbytes, char *file, int line)
#else
rt_public Malloc_t eiffel_malloc (register unsigned int nbytes)
#endif
{
#ifdef LMALLOC_CHECK
	Malloc_t ret;

	ret = (Malloc_t) malloc (nbytes);
	if (lm_put (ret, file, line))	
		fprintf (stderr, "*** Warning: cannot lm malloc %d bytes at %s:%d\n", nbytes, file, line);
#ifdef LMALLOC_DEBUG
#ifdef EIF_THREADS
	fprintf (stderr, "EIF_MALLOC: 0x%lx\t(%d bytes) in thread %lx\n", (unsigned long) ret, nbytes, EIF_THR_SELF);	
#else	/* EIF_THREADS */
	fprintf (stderr, "EIF_MALLOC: 0x%lx\t(%d bytes)\n", (unsigned long) ret, nbytes);	
#endif	/* EIF_THREADS */
#endif
	return ret;
#else	/* LMALLOC_CHECK */
	return (Malloc_t) malloc (nbytes);
#endif	/* LMALLOC_CHECK */
}

#if defined LMALLOC_CHECK || defined LMALLOC_DEBUG
rt_public Malloc_t eiffel_calloc (unsigned int nelem, unsigned int elsize, char *file, int line)
#else
rt_public Malloc_t eiffel_calloc (unsigned int nelem, unsigned int elsize)
#endif
{
#ifdef LMALLOC_CHECK
	Malloc_t ret;
	ret = (Malloc_t) calloc (nelem, elsize);
	if (lm_put (ret, file, line))	
		fprintf (stderr, "*** Warning: cannot lm calloc %d * %d at %s:%d\n", (unsigned int) nelem, (unsigned int) elsize, file, line);
#ifdef LMALLOC_DEBUG
#ifdef EIF_THREADS
	fprintf (stderr, "EIF_CALLOC: 0x%lx\t(%d elts * %d bytes = %d bytes) in thread %lx\n", (unsigned long) ret, nelem, elsize, nelem*elsize, EIF_THR_SELF);	
#else
	fprintf (stderr, "EIF_CALLOC: 0x%lx\t(%d elts * %d bytes = %d bytes)\n", (unsigned long) ret, nelem, elsize, nelem*elsize);	
#endif /* EIF_THREADS */
#endif
	return ret;
#else	/* LMALLOC_CHECK */
	return (Malloc_t) calloc (nelem, elsize);
#endif	/* LMALLOC_CHECK */
}

#if defined LMALLOC_DEBUG || LMALLOC_CHECK
rt_public Malloc_t eiffel_realloc (register void *ptr, register unsigned int nbytes, char *file, int line)
#else
rt_public Malloc_t eiffel_realloc (register void *ptr, register unsigned int nbytes)
#endif
{
#ifdef LMALLOC_CHECK
	Malloc_t ret;

	ret = (Malloc_t) realloc (ptr, nbytes);
	if (ptr != ret) {
	if (lm_remove (ptr))	
		fprintf (stderr, "*** Warning: cannot lm remove-realloc 0x%x while reallocating at %s:%d\n", (size_t) ptr, file, line);
	if (lm_put (ret, file, line))	
		fprintf (stderr, "*** Warning: cannot lm realloc 0x%x with %d bytes while reallocating at %s:%d\n", (size_t) ptr, nbytes, file, line);
	}
#ifdef LMALLOC_DEBUG
#ifdef EIF_THREADS
	fprintf (stderr, "EIF_REALLOC: 0x%lx\t(old 0x%lx, %d bytes) in thread %lx\n", (unsigned long) ret, (unsigned long) ptr, nbytes, EIF_THR_SELF);	
#else	/* EIF_THREADS */
	fprintf (stderr, "EIF_REALLOC: 0x%lx\t(old 0x%lx, %d bytes)\n", (unsigned long) ret, (unsigned long) ptr, nbytes);	
#endif	/* EIF_THREADS */
#endif	/* LMALLOC_DEBUG */
	return ret;
#else	/* LMALLOC_CHECK */
	return (Malloc_t) realloc (ptr, nbytes);
#endif	/* LMALLOC_CHECK */
}

#if defined LMALLOC_CHECK || defined LMALLOC_DEBUG
void eiffel_free(register void *ptr, char *file, int line)
#else
void eiffel_free(register void *ptr)
#endif
{
#ifdef LMALLOC_CHECK
  	if (ptr) {
		free (ptr);
		if (lm_remove (ptr))	
			fprintf (stderr, "*** Warning: cannot lm free 0x%lx at %s:%d\n", (unsigned long) ptr, file, line);
	}
#ifdef LMALLOC_DEBUG
#ifdef EIF_THREADS
	fprintf (stderr, "EIF_FREE: 0x%lx in thread %lx\n", (unsigned long) ptr, EIF_THR_SELF);	
#else	/* EIF_THREADS */
	fprintf (stderr, "EIF_FREE: 0x%lx\n", (unsigned long) ptr);	
#endif	/* EIF_THREADS */
#endif
#else	/* LMALLOC_CHECK */
	if (ptr)
		free (ptr);
#endif	/* LMALLOC_CHECK */
}

