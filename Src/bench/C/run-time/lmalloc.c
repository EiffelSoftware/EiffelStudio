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

  Additionally, this file contains some VMS platform specific functions.
  They are here (rather than in misc.c) because this module can be 
  included in a non-Eiffel application (ebench daemon) without lots of
  side effects.
  David Schwartz
*/


#include "eif_config.h"
#include "eif_portable.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_lmalloc.h"
#include <malloc.h>


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

#elif EIF_WIN32 || defined EIF_VMS
/* For Windows and VMS platforms we use malloc() implemented in the C-library */
	return malloc (nbytes);

#elif defined VXWORKS
/* For VXWORKS, we have a special run-time. HP provides their own malloc ()
 *we do not have, so we call malloc() from the C-library to perform test */
#warning: file should not be linked for VXWORKS runtime. 
	return malloc (nbytes);

#elif !defined HAS_SMART_MMAP && !defined HAS_SBRK
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

#elif !defined HAS_SMART_MMAP && !defined HAS_SBRK
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

#elif !defined HAS_SMART_MMAP && !defined HAS_SBRK
	return realloc (ptr, nbytes);
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


#elif defined VXWORKS
#warning: file should not be linked for VXWORKS runtime
	free (ptr);

#elif defined EIF_WIN32 || defined EIF_VMS
	free (ptr);

#elif !defined HAS_SMART_MMAP && !defined HAS_SBRK
	return free (ptr);
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





#ifdef EIF_VMS

#ifdef EIF_VMS_OLD
/*	**********************************************	    */
/*	***   VMS specific function definitions.   ***	    */
/*	**********************************************	    */

#include <starlet.h>		/* vms system services */
#include <descrip.h>		/* descriptor data structures */

/* VMS version of "putenv" (note - VMS V7 onward has a putenv (and a	*/
/* setenv as well); I'm not sure precisely what they do (that is, how	*/
/* they are is implemented).  This one creates a logical name		*/
/* definition in the PROCESS table (so that it's private to the current	*/
/* process and any subprocesses that are subsequently created) in USER	*/
/* mode (so that it doesn't outlive the currently running image).  This	*/
/* behavior is more akin to unix putenv, which doesn't permit a		*/
/* subprocess to modify a parent's environment.  This routine was	*/
/* pinched from the C/ipc/ipcshared/ipcvms.c version.			*/

#include lnmdef				/* sys$crelnm, etc. LNM$ symbols */

rt_public int eif_rt_putenv (const char *envstring)
{
    VMS_STS st;
    char *eq;
    DX_BLD(nam_d,0,0);
    const $DESCRIPTOR(tabnam_d, "LNM$PROCESS");
    ITEMLIST lnm_list = { ITEM(LNM$_STRING, NULL, 0, NULL), ITEMLIST_END };

    /* the argument must be a string of the form <name>=<value>		*/
    eq = strchr(envstring, '=');	/* find the =			*/
    if (!eq) return -1;			/* argument is invalid		*/
    DXPTR(nam_d) = (char*)envstring;	/* name is part up to (but not	*/
    DXLEN(nam_d) = eq - envstring;	/* including) the "="		*/
    lnm_list[0].bufadr = ++eq;		/* value is the rest following	*/
    lnm_list[0].buflen = strlen(eq);	/* the "="			*/
    st = sys$crelnm(0, (void*)&tabnam_d, &nam_d, 0, &lnm_list);
    if (VMS_FAILURE(st)) {
#ifdef DEBUG
	printerr(EVMSERR, "eif_rt_putenv: error %%x%x from sys$crelnm(%s)\n-- %s",
		st, envstring, strerror(EVMSERR,st));
#endif /* DEBUG */
	return -1;
    }
    return 0;
} /* end putenv() */


rt_public int eif_rt_setenv(const char *name, const char *val, int overwrite) {
    VMS_STS st;
    DX_BLD(nam_d,0,0);
    const $DESCRIPTOR(tabnam_d, "LNM$PROCESS");
    ITEMLIST lnm_list = { ITEM(LNM$_STRING, NULL, 0, NULL), ITEMLIST_END };

    /* **FIXME** - dss --- don't create name if overwrite == 0 and already exists */
    DXPTR(nam_d) = (char*)name;
    DXLEN(nam_d) = strlen(name);
    lnm_list[0].bufadr = (char*)val;
    lnm_list[0].buflen = strlen(val);
    st = sys$crelnm(0, (void*)&tabnam_d, &nam_d, 0, &lnm_list);
#ifdef DEBUG
    if (VMS_FAILURE(st)) {
	printerr(EVMSERR, "eif_rt_setenv: error %%x%x from sys$crelnm(%s)=%s\n-- %s",
		st, name,val, strerror(EVMSERR,st));
	return -1;
    }
#endif /* DEBUG */
    return ( st & 1) - 1;
} /* end setenv() */


int eif_rt_unlink (const char *name)
{
    int err;
    err = remove(name);
    return err;
}


#else  /* EIF_VMS_OLD */
rt_public int eif_rt_putenv (const char *envstring) {  
    extern int DECC$PUTENV (const char *envstring) ;
    return DECC$PUTENV (envstring);  
}

rt_public int eif_rt_setenv(const char *name, const char *val, int overwrite) {  
    extern int DECC$SETENV (const char *name, const char *val, int overwrite) ;
    return DECC$SETENV (name, val, overwrite);  
}

rt_public int eif_rt_unlink (const char *name) {
    extern int DECC$UNLINK ( const char*name) ;
    return DECC$UNLINK (name);  
}

#endif  /* EIF_VMS_OLD */

#ifdef TEST
#include <stdio.h>
#include <ssdef.h>
#include <errno.h>
#include <starlet.h>		/* for sys$getmsg() */

main () {
	char			buff[256];
	int			cond;
	int			flags = 0xf;
	char			mesg[133];
	$DESCRIPTOR(message_text,mesg);
	int			mesglen;
	register		status;

	printf("\n\nEnter putenv string as   name=value :  ");
	(void)fflush(stdout);
	(void)gets(buff);
	if (buff[0] != '\0') {
		cond = putenv(buff);		
		printf("Return value is %d.\n",(int)cond);
		status = SYS$GETMSG(cond,&mesglen,&message_text,flags,0);
		printf("\n<%d> %s\n",status,mesg);
/*		lib$stop(cond); */
	}
}
#endif	/* TEST */

#endif /* EIF_VMS */
