/*

 #       #    #    ##    #       #        ####    ####            ####
 #       ##  ##   #  #   #       #       #    #  #    #          #    #
 #       # ## #  #    #  #       #       #    #  #               #
 #       #    #  ######  #       #       #    #  #        ###    #
 #       #    #  #    #  #       #       #    #  #    #   ###    #    #
 ######  #    #  #    #  ######  ######   ####    ####    ###     ####

	Malloc library functions.

  Wrappers to malloc functions from standard libs. 
  Define LMALLOC_CHECK, for checks and debugging output.


  Additionally, this file contains some VMS platform specific functions.
  They are here (rather than in misc.c) because this module can be 
  included in a non-Eiffel application (ebench daemon) without lots of
  side effects.
  David Schwartz
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





#ifdef EIF_VMS
#include <lib$routines>
#include <dvidef>
#include <ssdef>
#pragma message disable (NEEDCONSTEXT)	/* skip non-constant address warnings */
#pragma message disable (ADDRCONSTEXT)	/* skip non-constant address warnings */
#define DX_BUF(d,buf) DX d = { sizeof buf, DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)&buf }
#include <starlet>		/* vms system services */
#include <descrip>		/* descriptor data structures */
#include <lnmdef>		/* sys$crelnm, etc. LNM$ symbols */

/* Problem: Unix-centric programs often check each element of a path name for		*/
/* environment variables ($-prefixed names) and translate them in place, emulating	*/
/* shell processing. On VMS, logical names are made to appear as environment variables	*/
/* by the VMS DECC RTL implementation of getenv().  Many VMS DECC RTL functions, and	*/
/* getenv() in particular, do not respect the "concealed" attribute of a logical name.	*/
/* This causes a problem in using translated names to build Unix-style file		*/
/* specifications - they end up with mixed Unix- and VMS- filespecs.			*/
/* Solution: If an "envrionment variable" value is or contains a concealed logical	*/
/* name, then return the variable name, rather than the value.  This allows the VMS	*/
/* file system calls to handle the name translation.					*/
/* Note: this is a kludge. A more correct solution would be to implement this		*/
/* functionality only when the name is being used as the first element of a pathname.	*/
#undef getenv
extern char* getenv (const char *name) ;	/* copied from unixlib.h */
rt_public char* eif_vms_getenv (const char* name)
{
    char* crtval = getenv (name);          	/* call the "real deal" */
    if (strlen(name) <= LNM$C_NAMLENGTH) {
	static const $DESCRIPTOR (tab_dx, "LNM$FILE_DEV");   /* standard default table name */
	char nambuf[LNM$C_NAMLENGTH +1];		/* documented max length +1 for terminator */
	char valbuf[LNM$C_NAMLENGTH +1]; 
	char tblbuf[LNM$C_TABNAMLEN +1]; 
	DX_BLD (lnm_dx, nambuf, 0);
	unsigned short vallen, tbllen;
	long name_attr, max_index;
	ITEMLIST items = { 
	    ITEM (LNM$_STRING, valbuf, sizeof valbuf -1, &vallen), 
	    ITEM (LNM$_ATTRIBUTES, &name_attr, sizeof name_attr, NULL),
	    ITEM (LNM$_MAX_INDEX, &max_index, sizeof max_index, NULL),
	    ITEM (LNM$_TABLE,  tblbuf, sizeof tblbuf -1, &tbllen), 
	    ITEMLIST_END };
	VMS_STS sts;
	int tries;
	unsigned int tran_attr = 0;	/* could be  LNM$M_CASE_BLIND */
	/* loop: ***tbs*** */
	strcpy (nambuf, name);
	for (tries = LNM$C_MAXDEPTH;  tries > 0;  --tries) {
	    EIF_REFERENCE p;
	    lnm_dx.dsc$w_length = strlen (lnm_dx.dsc$a_pointer);
	    sts = sys$trnlnm (&tran_attr, (void*)&tab_dx, &lnm_dx, 0, &items);
	    if (VMS_FAILURE(sts)) break;
	    if (name_attr & LNM$M_CONCEALED)
		return (char*) name;
	    valbuf[vallen] = '\0';
	    if ( !(p = strchr (valbuf, ':')) )
		break;
	    lnm_dx.dsc$w_length = p - valbuf;
	    strncpy (nambuf, valbuf, lnm_dx.dsc$w_length);
	    nambuf[lnm_dx.dsc$w_length] = '\0';
	}
    }
#ifdef moose
    /* simple hack: if translation contains a ":", assume its a path and return the name. */
    if (crtval && *crtval && strchr (crtval, ':'))
	return (char*)name;	/* const_cast<char*>(name) */
#endif
    return crtval;
}

#ifdef EIF_VMS_OLD
/*	**********************************************	    */
/*	***   VMS specific function definitions.   ***	    */
/*	**********************************************	    */


/* VMS version of "putenv" (note - VMS V7 onward has a putenv (and a	*/
/* setenv as well); I'm not sure precisely what they do (that is, how	*/
/* they are is implemented).  This one creates a logical name		*/
/* definition in the PROCESS table (so that it's private to the current	*/
/* process and any subprocesses that are subsequently created) in USER	*/
/* mode (so that it doesn't outlive the currently running image).  This	*/
/* behavior is more akin to unix putenv, which doesn't permit a		*/
/* subprocess to modify a parent's environment.  This routine was	*/
/* pinched from the C/ipc/ipcshared/ipcvms.c version.			*/


rt_public int eif_vms_putenv (const char *envstring)
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
	printerr(EVMSERR, "eif_vms_putenv: error %%x%x from sys$crelnm(%s)\n-- %s",
		st, envstring, strerror(EVMSERR,st));
#endif /* DEBUG */
	return -1;
    }
    return 0;
} /* end putenv() */


rt_public int eif_vms_setenv (const char *name, const char *val, int overwrite) {
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
	printerr(EVMSERR, "eif_vms_setenv: error %%x%x from sys$crelnm(%s)=%s\n-- %s",
		st, name,val, strerror(EVMSERR,st));
	return -1;
    }
#endif /* DEBUG */
    return ( st & 1) - 1;
} /* end setenv() */


int eif_vms_unlink (const char *name)
{
    int err;
    err = remove(name);
    return err;
}

#else  /* (not) EIF_VMS_OLD */

rt_public int eif_vms_putenv (const char *envstring) {  
    extern int DECC$PUTENV (const char *envstring) ;
    int result = DECC$PUTENV (envstring);  
    return result;
}

rt_public int eif_vms_setenv (const char *name, const char *val, int overwrite) {  
    extern int DECC$SETENV (const char *name, const char *val, int overwrite) ;
    int result = DECC$SETENV (name, val, overwrite);  
    return result;
}

rt_public char* eif_vms_strdup (const char* str) {
    extern char* DECC$STRDUP (const char* str) ;
    char* result = DECC$STRDUP (str);
    return result;
}

rt_public int eif_vms_system (const char* cmd) {
    extern int DECC$SYSTEM (const char* cmd) ;
    int result = DECC$SYSTEM (cmd);
    if (getenv("EIF_TRACE_SYSTEM"))
	fprintf (stderr, "eif_vms_system (%s): result = %d\n", cmd, result);
    return result;
}

rt_public int eif_vms_unlink (const char *name) {
    extern int DECC$UNLINK (const char*name) ;
    int result = DECC$UNLINK (name);  
    return result;
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
