/*
	description: "[
			This file contains VMS platform specific code. 
			It is used by the Eiffel workbench daemon as well as Eiffel applications.
			Some of this code used to live in ipcvms.c and lmalloc.c
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="eifrtvms.c" version="$Id$" summary="VMS specific runtime tools">
*/

#ifdef __VMS		/* this runs for the rest of the module */

#pragma module EIFRTVMS	    // force uppercase module name
#include "eif_config.h"
#include "eif_portable.h"

#include <ctype.h>
#include <errno.h>

#include <lib$routines>
#include <clidef>
#include <dvidef>
#include <jpidef>
#include <ssdef>
#include <starlet>	/* vms system services */
#include <descrip>	/* descriptor data structures */
#include <lnmdef>	/* sys$crelnm, etc. LNM$ symbols */
#include <fab>		/* RMS FAB definitions */
#include <nam>		/* RMS NAM (name block) definitions */

/* Define some useful macros for dealing with descriptors		*/
/* (most are not portable because of aggregate initialization).		*/
#pragma message disable (NEEDCONSTEXT,ADDRCONSTEXT)  /* skip non-constant address warnings */
//#define DX_BUF(d,buf) DX d = { sizeof(buf), DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)&buf }
#define DX_BLD(d,ptr,len) DX d = { len, DSC$K_DTYPE_T, DSC$K_CLASS_S, (char*)ptr }
#define DX_STR(d,ptr) DX d = { strlen(ptr), DSC$K_DTYPE_T, DSC$K_CLASS_S, ptr }
#define DX_STRLIT(d,ptr) DX d = { sizeof(ptr)-1, DSC$K_DTYPE_T, DSC$K_CLASS_S, ptr }
#define DX_DYN(d) DX d = { 0, DSC$K_DTYPE_T, DSC$K_CLASS_D, 0 }
#define DX_ATOMIC(d,var,dtyp) DX d = { sizeof(var), dtyp, DSC$K_CLASS_S, &(var) }
/* access to descriptor components */
#define DXLEN(d) ( (d).dsc$w_length )
#define DXPTR(d) ( (d).dsc$a_pointer )

/* take care when using these, trailing semicolon is not desired */
#define RETURN_ERR(err)   { ipcvms_errno = errno = err; return -1; }
#define RETURN_VMSERR(st) { ipcvms_status = vaxc$errno = st; RETURN_ERR(EVMSERR) }



/* UNIX style dirname: returns the length of directory part of the path,    */
/* including final path delimiter; zero if none (path is file name only).   */
/* Unlike VMS C library dirname, this works for Unix or VMS paths.	    */
/* Note: this should work for all platforms, but is only tested on VMS.	    */
rt_public size_t eifrt_vms_dirname_len (const char* path)
{
    size_t result;
    const char *delim, *p, *lastp;
    const char delims[] = "/\\:]>";	/* set of all possible delimiters   */

    /* find rightmost delimiter in path */
    for (lastp = NULL, delim = delims;  *delim;  ++delim) {
	if (p = strrchr (path, *delim))
	    if (p > lastp)
		lastp = p;
    }
    if (lastp)
	result = lastp - path + 1;
    else result = 0;
    return result;
} /* end eifrt_vms_dirname_len() */


/* Returns full filename of current program image executable.  Places	    */
/* result in output buffer, which must be big enough, else output is	    */
/* truncated.  If output buffer NULL, returns pointer to static storage.    */
const char* eifrt_vms_imagename (char* buf, size_t bufsiz)
{
    const char* result;
    /* I think that 4098 is the new maximum long filename length on VMS; I can't find a symbolic definition. */
    static char imagename[4099]	 = {'\0'};	/* full image file name + nul  */

    if (*imagename == '\0') {   /* if we have not done this yet */
	VMS_STS st; 
	int32 item = JPI$_IMAGNAME;
	DX_BUF (imag_d, imagename);
	uint16 retlen = 0;
	st = lib$getjpi (&JPI$_IMAGNAME, NULL,NULL, NULL, &imag_d, &retlen);
	if (VMS_SUCCESS (st)) {
	    imagename[retlen] = '\0';	/* null terminate returned string */
	    result = imagename;
	} else	/* getjpi failed?? */
	    result = NULL;
    } else { /* been here, done this; return the previous result */
	result = imagename;
    }
    if (buf && result) {
	if (strlen(result) < bufsiz)
	    result = strcpy (buf, result);
	else {
	    strncpy (buf, result, --bufsiz);
	    buf[bufsiz] = '\0';
	    result = NULL;
	}
    }
    return (result);
} /* end eifrt_vms_imagename() */



/* Returns name of program image executing. Used for messages, etc.	*/
/* In UNIX terms, basename(argv[0]) 					*/
/* Returns result in output buffer, which must be big enough.		*/
/* If output buffer NULL, returns pointer to static storage.		*/

const char* eifrt_vms_get_progname (char* buf, size_t bufsiz)
{
    const char* result;
    /* I think that 4098 is the new maximum long filename length on VMS; I can't find a symbolic definition. */
    static char progname[FILENAME_MAX] = {'\0'};	/* like argv[0] - image file basename */
    //static const int filename_max = FILENAME_MAX;

    if (*progname == '\0') {   /* if we have not done this yet */
	char *p, imagename[4099];
	/* point to basename */
	p = (char*) eifrt_vms_imagename (NULL,0);
	p += eifrt_vms_dirname_len (p);
	result = strcpy (progname, p);
	/* hack: remove extension and version (***FIXME*** do a sys$parse(), the right way) */
	if ( (p = strrchr (progname, '.')) )
	    *p = '\0';
    } else { /* already been through here, return the previous result */
	result = progname;
    }
    if (buf && result) {
	if (strlen (result) < bufsiz)
	    result = strcpy (buf, result);
	else {
	    strncpy (buf, result, --bufsiz);
	    buf[bufsiz] = '\0';
	    result = NULL;
	}
    }
    return (result);
} /* end eifrt_vms_get_progname() */



/* eifrt_vms_spawn - used to issue an asynchronous "system" command.	*/
int eifrt_vms_spawn (const char *cmd, int async)
{
    int result;
    char vms_cmd[NAML$C_MAXRSS * 2 + 1];
    DX_BLD (cmd_d, NULL, 0);
    DX_STRLIT (inp_d, "nla0:");	    /* thats /dev/null to you */
    VMS_STS sts;
    uint32 flags = 0;
    static int err, erv;
    struct FAB fab = cc$rms_fab;
    struct NAM nam = cc$rms_nam;
    char esb[NAM$C_MAXRSS +1], rsb[NAM$C_MAXRSS +1];
    static const char* dnm = ".*";

    err = access (cmd, F_OK);
    flags = 0;
    if (async) 
	flags |= CLI$M_NOWAIT;

    /* ensure we have a VMS filespec */
    cmd = eifrt_vms_filespec (cmd, vms_cmd);

    /* if 'vms_cmd' is a command procedure (.com file), prepend "@" */
    /* perform a parse on the name supplied */
    fab.fab$l_dna = (char*)dnm; fab.fab$b_dns = strlen(dnm);
    fab.fab$l_fna = (char*)vms_cmd; fab.fab$b_fns = strlen(vms_cmd);
    fab.fab$l_nam = &nam;
    nam.nam$l_esa = esb; nam.nam$b_ess = sizeof esb -1;
    nam.nam$l_rsa = rsb; nam.nam$b_rss = sizeof rsb -1;
    /* VMS debug note: use nam.nam$r_nop_overlay. { nam$b_nop | nam$r_nop_bits } to examine. */
    nam.nam$b_nop |= NAM$M_SYNCHK;	/* request syntax check only, no lookup */
    sts = sys$parse (&fab);
    if (VMS_SUCCESS(sts))
	sts = sys$search (&fab);
    if (VMS_SUCCESS(sts)) {
	if (!strncasecmp (nam.nam$l_type, ".COM", nam.nam$b_type)) {
	    /* prepend "@" to vms_cmd */
	    memmove (vms_cmd+1, vms_cmd, strlen(vms_cmd)+1);
	    vms_cmd[0] = '@';
	}
    }
    DXPTR(cmd_d) = vms_cmd;
    DXLEN(cmd_d) = strlen(vms_cmd);
    sts = lib$spawn(&cmd_d, 0,0, &flags);
    if (VMS_SUCCESS(sts))
	result = err = erv = 0;
    else {
    	errno = err = EVMSERR;
	vaxc$errno = erv = sts;
	result = -1;
    }
    return result;
} /* end eifrt_vms_spawn */

/* Problem: Unix-centric programs often check each element of a path name for		*/
/* environment variables ($-prefixed names) and translate them in place, emulating	*/
/* shell processing. On VMS, logical names are made to appear as environment variables	*/
/* by the VMS DECC RTL implementation of getenv().  Many VMS DECC RTL functions, and	*/
/* getenv() in particular, do not respect the "concealed" attribute of a logical name.	*/
/* Concealed logical names may be used as "rooted" directory names, which are		*/
/* pseudo device names that represent a device and a top level directory and are used	*/
/* syntactically as device names. For example, EIFFEL4 is a concealed logical name	*/
/* that represents the top level of the Eiffel installation device/directory tree.	*/
/* This causes a problem in using translated names to build Unix-style file		*/
/* specifications - they can end up with mixed VMS- and UNIX- filespecs.		*/
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
    if (crtval && strlen(name) <= LNM$C_NAMLENGTH) {
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
	strcpy (nambuf, name);
	/* loop: iteratively translate the name (up to MAXDEPTH times)	*/
	/* until a translated value has the CONCEALED attribute.	*/
	/* Each successive iteration attempts to translate the device	*/
	/* name prefix (before the colon) of the previous value.	*/
	/* If a CONCEALED value is seen, return the original name	*/
	/* (colon terminated) as the value of the function.		*/
	for (tries = LNM$C_MAXDEPTH;  tries > 0;  --tries) {
	    EIF_REFERENCE p;
	    lnm_dx.dsc$w_length = strlen (lnm_dx.dsc$a_pointer);
	    sts = sys$trnlnm (&tran_attr, (void*)&tab_dx, &lnm_dx, 0, &items);
	    if (VMS_FAILURE(sts)) break;
	    if (name_attr & LNM$M_CONCEALED) {
#ifdef moose	/* this was a bad idea, it causes all sorts of other problems. */
		/* return colon terminated name */
		static char badidea[LNM$C_NAMLENGTH +2];    /* NOT THREAD SAFE! */
		if (!strchr (strcpy (badidea, name), ':'))
		    strcat (badidea, ":");
		return badidea;
#endif
		/* return the (untranslated) name */
		return (char*) name;
	    }
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
} /* end eif_vms_getenv() */


/* Special version of getenv() that bypasses the hack above.		*/
/* This is intended to be used for programs that really want the	*/
/* value of the environment variable (logical name) for reporting	*/
/* purposes. It is called by a variant of get in EXECUTION_ENVIRONMENT.	*/
/*									*/
/* For non-VMS platforms, it is the same as eif_getenv().		*/
rt_public char* eif_getenv_ (const char* name)
{
    char* crtval = getenv (name);	/* call the real getenv() */
    return crtval;
} /* end eif_getenv_() */


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
/* pinched from the C/ipc/shared/ipcvms.c version.			*/


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

#endif /* __VMS */

/*
doc:</file>
*/
