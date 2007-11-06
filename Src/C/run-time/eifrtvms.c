/*
	name: eifrtvms.c (C/run-time/eifrtvms.c)
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

#ifdef __VMS	/* this runs for the rest of the module */

#pragma module EIFRTVMS		// force uppercase module name

#if !defined NDEBUG
#define EIF_ASSERTIONS
#endif

#include "eif_config.h"
#include "eif_portable.h"
#include "rt_assert.h"

#include <ctype.h>
#include <errno.h>

#include <lib$routines>
#include <clidef>
#include <dvidef>
#include <jpidef>
#include <ssdef>
#include <starlet>	/* vms system services */
#include <lnmdef>	/* sys$trnlnm, etc. LNM$ symbols */
#include <fab>		/* RMS FAB definitions */
#include <nam>		/* RMS NAM (name block) definitions */


/* nested concatenation enables concatenation of macro values (instead of names) */
#define CAT22(x,y) CAT2(x,y)

/* define a global symbol to make the pointer size manifest in the object module */
#if defined __INITIAL_POINTER_SIZE
globalvalue CAT22(eifrt_vms__pointer_size__, __INITIAL_POINTER_SIZE) = __INITIAL_POINTER_SIZE;
#else
globalvalue eifrt_vms__pointer_size__DEFAULT = sizeof(void*);
#endif
globalvalue eifrt_vms__pointer_size = sizeof (void*);



rt_shared const char eifrt_vms_valid_filename_chars[]
	= "$_-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567890";
rt_shared const char eifrt_vms_path_terminators[] = "]>:";

/*
doc:	<attribute name="eifrt_vms_path_delimiters" return_type="char []" export="private">
doc:		<summary>VMS characters used for delimiters in pathnames. Period is excluded.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since statically initialized.</synchronization>
doc:	</attribute>
*/
rt_shared const char eifrt_vms_path_delimiters[] = ":[]<>";

/* does path p end in a VMS path delimiter? */
#define IS_VMS_PATH_TERMINATED(p) ( strchr (vms_path_delimiters, (p)[strlen(p) -1]) )

/* Is path p VMS or a UNIX filespec? */
/* NB. these are not complementary; a simple filename with no path delimiters is neither. */
#define IS_VMS_FILESPEC(p)  ( NULL != strpbrk ( ((char*)(p)), eifrt_vms_path_delimiters) )
#define IS_UNIX_FILESPEC(p) ( NULL != strchr  ( ((char*)(p)), '/') )






/* is `p' a VMS filespec (i.e. does it contain VMS-specific delimiters)? */
rt_public int eifrt_is_vms_filespec (const char* p)
{
    return (int)IS_VMS_FILESPEC(p);
}


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

/* does the path end in a VMS terminator (dev:[dir] or dev:)? Boolean result. */
rt_public int eifrt_vms_has_path_terminator (const char* path)
{
	if (path && *path) {
	if (strchr (eifrt_vms_path_delimiters, path[strlen(path) -1]))
		return 1;	/* TRUE (VMS delimiter found) */
	}
	return 0;	/* FALSE */
}

/* append a filename to a path (VMS or Unix file specification syntax) */
/* assumes path can accomodate appended name */
rt_public void eifrt_vms_append_file_name (char* path, const char* file)
{
	/* append unix separator iff no vms-specific delimiter at end of path */
	if (eifrt_vms_has_path_terminator (path))
	strcat (path, "/");
	strcat (path, file);
}

/* This is ugly (thread unsafe, too) but there's no other way to return the translated filespec. */
rt_private char stupid_vms_name[FILENAME_MAX +1] = { '\0' };
rt_private int stupid_vms_trick (char *name, int type)
{
	REQUIRE ("`name' is not too big", strlen(name) < sizeof stupid_vms_name);
	strcpy (stupid_vms_name, name);
	return 0;
}

/* convert a file specification to VMS syntax */
rt_public char* eifrt_vms_filespec (const char* filespec, char* buf)
{
	int is_unix = (strchr(filespec, '/') != NULL);	/* if filespec contains a '/' it might be a foreign filespec */
	int res = decc$to_vms (filespec, stupid_vms_trick, 0, 1);
	if (res) strcpy (buf, stupid_vms_name);
	else strcpy (buf, filespec);
	return buf;
}

/* Given a VMS path (directory), return the directory file name (eg. dev:[dir.sub] ==> dev:[dir]sub.dir */
rt_public char* eifrt_vms_directory_file_name (const char* dir, char* buf)
{
	struct FAB fab = cc$rms_fab;
	struct NAM nam = cc$rms_nam;
	char esb[NAM$C_MAXRSS +1], rsb[NAM$C_MAXRSS +1];
	const char* dnm = "[ERROR__DIRECTORY_NOT_SPECIFIED]";
	VMS_STS sts;
	char vms_dir [PATH_MAX +1];

//	if (strchr(dir, '/')) {	    /* if dir contains a '/' it might be a Unix filespec */
		int res = decc$to_vms (dir, stupid_vms_trick, 0, 2);
		if (res) dir = strcpy (vms_dir, stupid_vms_name);
//	}
	/* perform a parse on the name supplied */
	/* ***VMS FIXME*** change to use NAML (64 bit) blocks to remove warnings and potential pointer truncation */
	fab.fab$l_dna = (char*)dnm; fab.fab$b_dns = strlen(dnm);
	fab.fab$l_fna = (char*)dir; fab.fab$b_fns = strlen(dir);
	fab.fab$l_nam = &nam;
	nam.nam$l_esa = esb; nam.nam$b_ess = sizeof esb -1;
	nam.nam$l_rsa = rsb; nam.nam$b_rss = sizeof rsb -1;
	/* VMS debug note: use nam.nam$r_nop_overlay. { nam$b_nop | nam$r_nop_bits } to examine. */
	nam.nam$b_nop |= NAM$M_SYNCHK;	/* request syntax check only, no lookup */
	sts = sys$parse (&fab);
	if (VMS_FAILURE(sts)) {
		/* parse failed; ensure expanded and resultant string length is zero */
		nam.nam$b_esl = nam.nam$b_rsl = 0;
	}
	/* if directory present and name, type, and version are missing (just delimiters) */
	if (nam.nam$b_dir && nam.nam$b_name == 0 && nam.nam$b_type <= 1 && nam.nam$b_ver <= 1) {
		char *dirend = nam.nam$l_dir + nam.nam$b_dir -1;	/* points to directory terminator */
		char dirdelim = *dirend;				/* save directory terminator (']' or '>') */
		char *subdir;
		int len;

		REQUIRE ("", nam.nam$l_dir + nam.nam$b_dir == nam.nam$l_name || !nam.nam$l_name);

		/* find the last [sub]directory name (.sub]) and make it the file name .DIR (]sub.DIR) */
		if (*(dirend -1) == '.') --dirend;	/* handle terminal . case ("[dir.]") */
		*dirend = '\0';				/* terminate after directory */
		subdir = strrchr (nam.nam$l_dir, '.');	/* find rightmost '.' in directory */
		if (!subdir) {				/* if no '.' found */
			/* only one (or none) directory name, insert top level directory [000000.<rest>] */
			const char* topdir = "000000.";
			const size_t topdir_len = strlen(topdir);
			len = dirend - nam.nam$l_dir;	/* debug: number of chars to shift */
			memmove (nam.nam$l_dir +1 + topdir_len, nam.nam$l_dir +1, dirend - nam.nam$l_dir);
			strncpy (nam.nam$l_dir +1, topdir, topdir_len);
			subdir = nam.nam$l_dir + topdir_len;
			dirend += topdir_len;
		}
		/* check for "[dir.][sub]" */
		*subdir++ = dirdelim;			/* insert directory delimiter (replace '.') */
		{
			int dbg1 = strcspn (subdir, eifrt_vms_valid_filename_chars);
			int dbg2 = strspn (subdir, eifrt_vms_path_delimiters);
		}
		if ( (len=strcspn (subdir, eifrt_vms_valid_filename_chars)) > 0) {
			int rem = strlen(subdir);	/* debug */
			memmove (subdir, subdir + len, strlen(subdir + len));
			dirend -= len;
		}
		strcpy (dirend, ".DIR");

		/* return result in caller buffer, allocate space if null. */
		CHECK ("", nam.nam$l_node == esb);
		if (!buf) 
			buf = malloc (strlen(esb) +1);
		if (buf)
			strcpy (buf, esb);
		return buf;
	}
	return NULL;
} /* end eifrt_vms_directory_file_name() */

/* Returns full filename of current program image executable.  Places	    */
/* result in output buffer, which must be big enough, else output is	    */
/* truncated.  If output buffer NULL, returns pointer to static storage.    */
const char* eifrt_vms_imagename (char* buf, size_t bufsiz)
{
    const char* result;
    static char imagename[NAML$C_MAXRSS +1] = {'\0'};	/* full image file name + nul  */

    if (*imagename == '\0') {   /* if we have not done this yet */
	VMS_STS st; 
	int32 item = JPI$_IMAGNAME;
	DX_BUF (imag_d, imagename);
	uint16 retlen = 0;
	st = lib$getjpi (&JPI$_IMAGNAME, NULL,NULL, NULL, &imag_d, &retlen);
	if (VMS_SUCCESS (st)) {
	    imagename[retlen] = '\0';	/* null terminate returned string */
	    result = imagename;
	} else	/* getjpi failed??? */
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


/* eifrt_vms_spawn - execute a [a]synchronous system command).			*/
/* Command can be a DCL command or symbol, a DCL script (command procedure),	*/
/* or an executable (RUN command).						*/
/*										*/
/* This is a functional replacement for the standard C library  system()	*/
/* call, but handles "commands" that are the names of executables or shell	*/
/* scripts (which works on UNIX but not on VMS because VMS requires different	*/
/* syntax for executing images or DCL command procedures [shell scripts]).	*/
/* This emulation is not quite complete; it does not handle running an		*/
/* executable image specified with a path name and arguments (that would	*/
/* require stripping the path and defining DCL$PATH here).			*/
/*										*/
/* Flags:  EIFRT_VMS_SPAWN_FLAG_<name>						*/
/* mask value									*/
/*  1	_ASYNC (_NOWAIT) 	asynchronous					*/
/*  2	_TRANSLATE		translate arguments from Unix to VMS syntax	*/
/*  4	_ECHO			echo command to stdout				*/
/*  8	_SET_MELT_PATH		reserved					*/
/*  128	_UNTRUSTED (don't worry if you don't know what it means).		*/
/*										*/
/* Returns error indicator: 0 = success, -1 = error; if error then errno is	*/
/* set to EVMSERR and vaxc$errno is set to VMS error code.			*/
/* Note: this indicates the success or failure of the spawn request, not the	*/
/* actual spawned command.							*/
int eifrt_vms_spawn (const char *a_cmd, int a_flags)
{
    int result;
    VMS_STS sts;
    static int err, erv;
    size_t vms_file_len;
    char vms_cmd[NAML$C_MAXRSS * 3 + 1];

    {
    	/* split a_cmd into words, translate 1st word to VMS, translate or append remaining words */
	char **cmd_words;
	char *cmd;
	int cmd_count;
	extern char** ipc_shword (const char *cmd);	// in C/ipc/shared/shword.c
	extern void shfree(void);			// ditto

	cmd_words = ipc_shword (a_cmd);
	if (!cmd_words[0]) {
	    cmd = eifrt_vms_filespec (a_cmd, vms_cmd);
	    vms_file_len = strlen (cmd);
	    assert (vms_file_len < sizeof vms_cmd);
	    cmd_count = 1;
	} else {
	    cmd = eifrt_vms_filespec (cmd_words[0], vms_cmd);
	    err = access (cmd, F_OK);	    // debug? what's this for?
	    vms_file_len = strlen (vms_cmd);
	    assert (vms_file_len < sizeof vms_cmd);
	    for (cmd_count=1;  cmd_words[cmd_count];  ++cmd_count) {
		char *endp = vms_cmd + strlen (vms_cmd);
		*endp++ = ' ';
		if (a_flags & EIFRT_VMS_SPAWN_FLAG_TRANSLATE)
		    cmd = eifrt_vms_filespec (cmd_words[cmd_count], endp);
		else
		    strcpy (endp, cmd_words[cmd_count]);
		assert (strlen (vms_cmd) < sizeof vms_cmd);
	    }
	    shfree();   
	}
    }

    {
	/* if 'vms_cmd' is a command procedure (.com file), prepend "@" */
	/* if an executable (.exe file), prepend "RUN " ***tbs***	    */
	/* perform a parse on the name supplied, then search for a .EXE or a .COM file */
	struct FAB fab = cc$rms_fab;
	struct NAM nam = cc$rms_nam;
	char esb[NAM$C_MAXRSS +1], rsb[NAM$C_MAXRSS +1];
	static const char* dnm = ".*";

#pragma message save
#pragma message disable (MAYHIDELOSS)    // checked: pointer is 32 bits (static decl)
	fab.fab$l_dna = (__char_ptr32)dnm; fab.fab$b_dns = strlen(dnm);
#pragma message restore
	fab.fab$l_fna = vms_cmd; fab.fab$b_fns = vms_file_len;
	fab.fab$l_nam = &nam;
	nam.nam$l_esa = esb; nam.nam$b_ess = sizeof esb -1;
	nam.nam$l_rsa = rsb; nam.nam$b_rss = sizeof rsb -1;
	/* VMS debug note: use nam.nam$r_nop_overlay. { nam$b_nop | nam$r_nop_bits } to examine. */
	nam.nam$b_nop |= NAM$M_SYNCHK;	/* request syntax check only, no lookup */
	sts = SYS$PARSE (&fab);
	if (VMS_SUCCESS(sts)) {
	    for (sts = sys$search(&fab);  VMS_SUCCESS(sts);  sts = sys$search(&fab)) {
		if (!strncasecmp (nam.nam$l_type, ".exe", nam.nam$b_type))
		    break;
		else if (!strncasecmp (nam.nam$l_type, ".COM", nam.nam$b_type)) {
		    /* prepend "@" to vms_cmd */
		    memmove (vms_cmd+1, vms_cmd, strlen(vms_cmd)+1);
		    vms_cmd[0] = '@';
		    break;
		}
	    }
	}
    }

    {
	DX_BLD (dx, vms_cmd, 0);	    /* descriptor for vms_cmd */
	$DESCRIPTOR (nuldev_d, "nl:");	    /* the null device; /dev/null to you */
	uint32 flags = 0;

	if (a_flags & EIFRT_VMS_SPAWN_FLAG_ECHO || 1)	// debug: always echo
	    puts (vms_cmd);
	if (a_flags & EIFRT_VMS_SPAWN_FLAG_ASYNC) 
	    flags |= CLI$M_NOWAIT;
	if (!(a_flags & EIFRT_VMS_SPAWN_FLAG_UNTRUSTED)) 
	    flags |= CLI$M_TRUSTED;
	DX_SET(dx, vms_cmd, strlen(vms_cmd));
	sts = LIB$SPAWN (&dx, &nuldev_d, 0, &flags);
	if (VMS_SUCCESS(sts)) {
	    result = errno = err = erv = vaxc$errno = 0;
	} else {
	    result = -1;
	    errno = err = EVMSERR;
	    vaxc$errno = erv = sts;
	}
    }
    return result;
} /* end eifrt_vms_spawn */

/* Problem 1: Unix-centric programs often check each element of a path name for		*/
/* environment variables ($-prefixed names) and translate them in place, emulating	*/
/* shell processing. On VMS, logical names are made to appear as environment variables	*/
/* by the VMS C RTL implementation of getenv().  Many VMS C RTL functions, and		*/
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
/* Note: this is a kludge. A far better solution would be to implement this		*/
/* functionality only when the name is being used as (the first element of) a pathname.	*/
/*											*/
/* Problem 2: Beginning with Eiffel 5.7, the Eiffel compiler uses Unix semantics to	*/
/* to determine if a filespec is an absolute or relative. Any path beginning with a VMS */
/* concealed logical name is absolute. In order to workaround this, we will have to	*/
/* return a concealed logical names with a leading "/" to make it look absolute.	*/
/*											*/
/* This is an even bigger kludge than the first one, and is thread unsafe to boot, 	*/
/* because it uses a local static buffer. It is expected to be temporary.		*/
/*											*/

#undef getenv
#define getenv #error calling jacket
rt_public char* eifrt_vms_getenv (const char* name)
{
    const char **p;
    static char hackbuf[1025];		/* ***VMS FIXME*** replace this with a circular buffer ring */
    char* crtval = DECC$GETENV (name);	/* call the real getenv() */

    if (crtval && strlen(name) <= LNM$C_NAMLENGTH) {
	static const $DESCRIPTOR (tab_dx, "LNM$FILE_DEV");   /* standard default table name */
	char nambuf[LNM$C_NAMLENGTH +1];	/* buffer for logical name: documented max length +1 for terminator */
	char valbuf[LNM$C_NAMLENGTH +1];	/* ditto for equivalence (value) */
#ifdef DEBUG
	char tblbuf[LNM$C_TABNAMLEN +1]; 
#endif
	DX_BLD (lnm_dx, nambuf, 0);
	ile_retlen_t vallen, tbllen;
	long name_attr, max_index;
	ITEM_LIST items = { 
	    ITEM_LIST_ENTRY (LNM$_STRING, valbuf, sizeof valbuf -1, &vallen), 
	    ITEM_LIST_ENTRY (LNM$_ATTRIBUTES, &name_attr, sizeof name_attr, NULL),
#ifdef DEBUG
	    ITEM_LIST_ENTRY (LNM$_MAX_INDEX, &max_index, sizeof max_index, NULL),	// debug/info
	    ITEM_LIST_ENTRY (LNM$_TABLE,  tblbuf, sizeof tblbuf -1, &tbllen),		// debug/info
#endif
	    ITEM_LIST_END };
	VMS_STS sts;
	int tries;
	unsigned int tran_attr = LNM$M_CASE_BLIND;
	strcpy (nambuf, name);
	/* loop: iteratively translate the name (up to MAXDEPTH times)	*/
	/* until a translated value has the CONCEALED attribute.	*/
	/* Each successive iteration attempts to translate the device	*/
	/* name prefix (before the colon) of the previous value.	*/
	/* If a CONCEALED value is seen, return the original name	*/
	/* as the value of the function.				*/
	for (tries = LNM$C_MAXDEPTH;  tries > 0;  --tries) {
	    EIF_REFERENCE p;
	    DX_SETLEN (lnm_dx, strlen (DX_PTR(lnm_dx)));
	    sts = sys$trnlnm (&tran_attr, (void*)&tab_dx, &lnm_dx, 0, &items);
	    if (VMS_FAILURE(sts)) break;
	    valbuf[vallen] = '\0';
	    if (name_attr & LNM$M_CONCEALED /*** || strchr (valbuf, ':') ***/ ) {
#ifdef moose	/* this was a bad idea, it causes all sorts of other problems; it is preserved here as a reminder. */
		/* return colon terminated name */
		static char badidea[LNM$C_NAMLENGTH +2];    /* NOT THREAD SAFE! */
		if (!strchr (strcpy (badidea, name), ':'))
		    strcat (badidea, ":");
		return badidea;
#endif
		/* return the original name, prefixed by "/" */
		if (*name == '/')
		    return (char*)name;
		else {
		    strcpy (hackbuf +1, name);
		    *hackbuf = '/';
		    return hackbuf;
		}
	    }
	    /* retranslate the result */
//	    if ( !(p = strchr (valbuf, ':')) )
//		break;
//	    DX_SETLEN(lnm_dx, p - valbuf);
	    DX_SETLEN(lnm_dx, vallen);
	    strncpy (nambuf, valbuf, DX_LEN(lnm_dx));
	    nambuf[DX_LEN(lnm_dx)] = '\0';
	}
    }
    return crtval;	    /* return real getenv() result */
} /* end eifrt_vms_getenv() */


/* Special version of getenv() that bypasses the hack above.		*/
/* This is intended to be used for programs that really want the	*/
/* value of the environment variable (logical name) for reporting	*/
/* purposes. It is called by a variant of get in EXECUTION_ENVIRONMENT.	*/
/*									*/
/* For non-VMS platforms, it is the same as eif_getenv().		*/
rt_public char* eifrt_vms_getenv_native (const char* name)
{
    char* res = DECC$GETENV (name);	/* call the real getenv() */
    return res;
} /* end eif_getenv_native() */


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


rt_public int eifrt_vms_putenv (const char *envstring)
{
    VMS_STS st;
    char *eq;
    DX_BLD(nam_d,0,0);
    const $DESCRIPTOR(tabnam_d, "LNM$PROCESS");
    ITEM_LIST lnm_list = { ITEM(LNM$_STRING, NULL, 0, NULL), ITEM_LIST_END };

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
	printerr(EVMSERR, "eifrt_vms_putenv: error %%x%x from sys$crelnm(%s)\n-- %s",
		st, envstring, strerror(EVMSERR,st));
#endif /* DEBUG */
	return -1;
    }
    return 0;
} /* end eifrt_vms_putenv() */


rt_public int eifrt_vms_setenv (const char *name, const char *val, int overwrite) {
    VMS_STS st;
    DX_BLD(nam_d,0,0);
    const $DESCRIPTOR(tabnam_d, "LNM$PROCESS");
    ITEM_LIST lnm_list = { ITEM(LNM$_STRING, NULL, 0, NULL), ITEM_LIST_END };

    /* **FIXME** - dss --- don't create name if overwrite == 0 and already exists */
    DXPTR(nam_d) = (char*)name;
    DXLEN(nam_d) = strlen(name);
    lnm_list[0].bufadr = (char*)val;
    lnm_list[0].buflen = strlen(val);
    st = sys$crelnm(0, (void*)&tabnam_d, &nam_d, 0, &lnm_list);
#ifdef DEBUG
    if (VMS_FAILURE(st)) {
	printerr(EVMSERR, "eifrt_vms_setenv: error %%x%x from sys$crelnm(%s)=%s\n-- %s",
		st, name,val, strerror(EVMSERR,st));
	return -1;
    }
#endif /* DEBUG */
    return ( st & 1) - 1;
} /* end eifrt_vms_setenv() */


int eifrt_vms_unlink (const char *name)
{
    int err;
    err = remove(name);
    return err;
}

#else  /* (not) EIF_VMS_OLD */

rt_public int eifrt_vms_putenv (const char *envstring) {  
    int result;
    /* DECC CRTL Ref Man says putenv cannot take a 64 bit address.  */
    extern int DECC$PUTENV (__const_char_ptr32 envstring) ;

#if __INITIAL_POINTER_SIZE > 32
    if ($is_32bits(envstring))
#pragma message save
#pragma message disable (MAYHIDELOSS)    // checked: pointer is 32 bits
	result = DECC$PUTENV ((__const_char_ptr32)envstring);
#pragma message restore
    else
	/* this causes a small memory leak, but it cannot be avoided */
	result = DECC$PUTENV (_strdup32 (envstring));
#else
    result = DECC$PUTENV (envstring);
#endif
    return result;
}


rt_public int eifrt_vms_setenv (const char *name, const char *val, int overwrite) {  
    extern int DECC$SETENV (const char *name, const char *val, int overwrite) ;
    int result = DECC$SETENV (name, val, overwrite);  
    return result;
}

#ifdef moose	// these are now supported directly by VMS C Runtime Library

rt_public char* eifrt_vms_strdup (const char* str) {
    extern char* DECC$STRDUP (const char* str) ;
    char* result = DECC$STRDUP (str);
    return result;
}

rt_public int eifrt_vms_system (const char* cmd) {
    extern int DECC$SYSTEM (const char* cmd) ;
    int result = DECC$SYSTEM (cmd);
    if (DECC$GETENV("EIF_TRACE_SYSTEM"))
	fprintf (stderr, "eifrt_vms_system (%s): result = %d\n", cmd, result);
    return result;
}

rt_public int eifrt_vms_unlink (const char *name) {
    extern int DECC$UNLINK (const char*name) ;
    int result = DECC$UNLINK (name);  
    return result;
}
#endif // moose
#endif  /* EIF_VMS_OLD */


#ifdef TEST
#include <stdio.h>
#include <ssdef.h>
#include <errno.h>
#include <starlet.h>		/* for sys$getmsg() */

main (int argc, char* argv[]) 
{
#ifdef moose
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
#endif // moose

	int ii;
	const char* p;

    if (argc < 2) {
	printf ("Usage: %s <environment_variable>...\n", argv[0]);
    } else {
	for (ii=1;  ii < argc;  ++ii) {
	    p = DECC$GETENV (argv[ii]);
	    if (!p) 
		printf ("%s not defined\n", argv[ii]);
	    else {
		printf ("getenv(\"%s\") = \"%s\"\n", argv[ii], p);
		p = eifrt_vms_getenv (argv[ii]);
		printf ("eifrt_vms_getenv() returns \"%s\"\n", p);
	    }
	}
    }

}
#endif	/* TEST */

#endif /* __VMS */

/*
doc:</file>
*/
