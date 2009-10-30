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


/* 'cause you've got... */
#define CARDINALITY(a)  ( sizeof(a) / sizeof((a)[0]) )

/* nested concatenation enables concatenation of macro values (instead of names) */
#define CAT22(x,y) CAT2(x,y)

/* define a global symbol to make the pointer size manifest in the object module */
#if defined __INITIAL_POINTER_SIZE
globalvalue CAT22(eifrt_vms__pointer_size__, __INITIAL_POINTER_SIZE) = __INITIAL_POINTER_SIZE;
#else
globalvalue eifrt_vms__pointer_size__DEFAULT = sizeof(void*);
#endif
globalvalue eifrt_vms__pointer_size = sizeof (void*);

#if __INITIAL_POINTER_SIZE <= 32
#define _strdup32(s) strdup(s)
#endif



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
rt_public char* eifrt_vms_directory_file_name (const char* a_dir, char* a_buf)
{
	struct FAB fab = cc$rms_fab;
	struct NAM nam = cc$rms_nam;
	char esb[NAM$C_MAXRSS +1], rsb[NAM$C_MAXRSS +1];
	const char* dnm = "[ERROR__DIRECTORY_NOT_SPECIFIED]";
	VMS_STS sts;
	char vms_dir [PATH_MAX +1];	// ***VMS FIXME*** not extended filespec compliant
#if __INITIAL_POINTER_SIZE > 32
	__char_ptr32 dir32 = NULL;
#endif

	//REQUIRE ("not a UNIX filespec", !strchr (a_dir, '/'));
	//if (strchr(a_dir, '/')) {	    /* if a_dir contains a '/' it might be a Unix filespec */
		int res = decc$to_vms (a_dir, stupid_vms_trick, 0, 2);
		if (res == 1) 
			a_dir = strcpy (vms_dir, stupid_vms_name);
	//}

	/* perform a parse on the name supplied */
#if __INITIAL_POINTER_SIZE > 32
	REQUIRE ("dnm is short pointer", $is_32bits(dnm));
#pragma message save
#pragma message disable (MAYHIDELOSS)    // checked: pointers are 32 bits
	fab.fab$l_dna = (char_ptr32)dnm;		// checked: pointer to static data must be 32 bits
	if ($is_32bits (a_dir)) {
	    fab.fab$l_fna = (char_ptr32)a_dir;		// checked: is 32 bit pointer
#pragma message restore
	    dir32 = NULL;
	} else {
	    fab.fab$l_fna = dir32 = _strdup32 (a_dir);
	    fab.fab$l_fna = dir32;
	}
#else
	fab.fab$l_dna = (char*)dnm; 
	fab.fab$l_fna = (char*)a_dir; 
#endif
	fab.fab$b_fns = strlen (a_dir);
	fab.fab$b_dns = strlen (dnm);	/* ***VMS FIXME*** change to use NAML (64 bit) blocks to allow extended filespecs */
	fab.fab$l_nam = &nam;
	nam.nam$l_esa = esb; nam.nam$b_ess = sizeof esb -1;
	//nam.nam$l_rsa = rsb; nam.nam$b_rss = sizeof rsb -1;
	/* VMS debug note: use nam.nam$r_nop_overlay. { nam$b_nop | nam$r_nop_bits } to examine. */
	nam.nam$b_nop |= NAM$M_SYNCHK;	/* request syntax check only, no lookup */
	sts = sys$parse (&fab);
#if __INITIAL_POINTER_SIZE > 32
	if (dir32 != NULL)
	    free (dir32);
	dir32 = NULL;
#endif
	if (VMS_FAILURE(sts)) {
		/* parse failed; ensure expanded and resultant string length is zero */
		nam.nam$b_esl = 0; nam.nam$b_rsl = 0;
	}
	/* if directory present and name, type, and version are missing (just delimiters) */
	if (nam.nam$b_dir && nam.nam$b_name == 0 && nam.nam$b_type <= 1 && nam.nam$b_ver <= 1) {
		char *dirend = nam.nam$l_dir + nam.nam$b_dir -1;	/* points to directory terminator */
		char dirdelim = *dirend;				/* save directory terminator (']' or '>') */
		char *subdir;
		int len;

		REQUIRE ("filename follows directory or else filename is absent", nam.nam$l_dir + nam.nam$b_dir == nam.nam$l_name || !nam.nam$l_name);

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

		CHECK ("", nam.nam$l_node == esb);
	} else {
		strcpy (esb, a_dir);
	}
	/* return result in caller buffer, allocate space if null. */
	if (!a_buf) 
		a_buf = malloc (strlen(esb) +1);
	if (a_buf)
		strcpy (a_buf, esb);
	return a_buf;
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
	    CHECK ("cmd does not overflow vms_cmd buffer", vms_file_len < sizeof vms_cmd);
	    cmd_count = 1;
	} else {
	    cmd = eifrt_vms_filespec (cmd_words[0], vms_cmd);
	    err = access (cmd, F_OK);	    // debug? what's this for?
	    vms_file_len = strlen (vms_cmd);
	    CHECK ("cmd does not overflow vms_cmd buffer", vms_file_len < sizeof vms_cmd);
	    for (cmd_count=1;  cmd_words[cmd_count];  ++cmd_count) {
		char *endp = vms_cmd + strlen (vms_cmd);
		*endp++ = ' ';
		if (a_flags & EIFRT_VMS_SPAWN_FLAG_TRANSLATE)
		    cmd = eifrt_vms_filespec (cmd_words[cmd_count], endp);
		else
		    strcpy (endp, cmd_words[cmd_count]);
		CHECK ("vms_cmd does not overflow buffer", strlen(vms_cmd) < sizeof vms_cmd);
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

/******************************************/
/*** I18N (Internationalization) stuff: ***/
/******************************************/
/*  Jackets for setlocale, nl_langinfo,   */
/*  iconv_ et. al.                        */
/******************************************/

//#define VMS_TRACE_SETLOCALE
//#define VMS_TRACE_NL_LANGINFO
//#define VMS_TRACE_ICONV_OPEN
//#define VMS_TRACE_ICONV


/* local forward references */
static const char* spaces (size_t len) ;
static const char* safe_string (const char* p) ;
static const char* locale_category_name (int category) ;
//static void* safe_ptr (void* p) ;
//static size_t safe_size (size_t *p) ;

#include <locale.h>
#define NeedFunction_Prototypes

/* jacket for setlocale: setlocale is 32-bit only */
char_ptr32 eifrt_vms_setlocale (int category, const char* locale)
{
    char_ptr32 res, res1;
    static uint once = FALSE;
    static const_char_ptr32 default_locale = NULL;
    char_ptr32 DECC$SETLOCALE (int category, const char* locale);
    char_ptr32 __XSETLOCALE (int category, const char* locale);

#ifdef VMS_TRACE_SETLOCALE
    printf ("eifrtvms: setlocale(%d (%s), \"%s\") called:\n", category, locale_category_name (category), safe_string(locale));
#endif
    if (!once) {
	once = TRUE;
	res = DECC$SETLOCALE (LC_ALL, NULL);
	default_locale = _strdup32 (res);
#ifdef VMS_TRACE_SETLOCALE
	printf ("  (first call to setlocale (LC_ALL, NULL) returns \"%s\" -- default locale).\n", default_locale);
#endif
    }
    res1 = DECC$SETLOCALE (category, locale);
#ifdef VMS_TRACE_SETLOCALE
    printf (" DECC$SETLOCALE returns \"%s\"\n", safe_string(res1));
#endif
    res = __XSETLOCALE (category, locale);
#ifdef VMS_TRACE_SETLOCALE
    printf (" returning \"%s\"\n", safe_string(res));
#endif
    return res;
}


#define CATEGORY_MAP_ITEM(cat) {cat, #cat}
typedef struct { int category; const char* name; } locale_category_map_item_t;
static locale_category_map_item_t locale_category_map[] = {
    CATEGORY_MAP_ITEM (LC_ALL), 
    CATEGORY_MAP_ITEM (LC_COLLATE), 
    CATEGORY_MAP_ITEM (LC_CTYPE), 
    CATEGORY_MAP_ITEM (LC_MESSAGES), 
    CATEGORY_MAP_ITEM (LC_MONETARY), 
    CATEGORY_MAP_ITEM (LC_NUMERIC), 
    CATEGORY_MAP_ITEM (LC_TIME),
};

static int locale_category_item_compare (int *cat1, locale_category_map_item_t *cat2)
{
    REQUIRE ("*int == *locale_category_map_item.category", offsetof (locale_category_map_item_t, category) == 0);
    if (*cat1 < cat2->category)
	return -1;
    else if (*cat1 == cat2->category)
	return 0;
    else
	return 1;
}

/* locale category name from `category' */
static const char* locale_category_name (int category)
{
    locale_category_map_item_t *itemp;
    const char* res = NULL;
    static int once = FALSE;

    if (!once) {
	once = TRUE;
	qsort (locale_category_map, CARDINALITY(locale_category_map), sizeof(locale_category_map[0]), 
		(int (*)(const void*, const void*))locale_category_item_compare);
    }
    itemp = bsearch ((void*)&category, locale_category_map, CARDINALITY(locale_category_map), sizeof(locale_category_map[0]), 
		(int (*)(const void*, const void*))locale_category_item_compare);
    if (itemp == NULL)
	res = "<unknown>";
    else res = itemp->name;
    return res;
}


#include <langinfo.h>

/*  Eiffel 6.4 Eiffel I18N library class {I18N_POSIX_CONSTANTS}			*/
/*	(ISE_EIFFEL:[library.i18n.locale.posix]i18n_posix_constants.e)		*/
/*  uses inline C to get platform defined values for nl_langinfo item codes,	*/
/*  where the Eiffel 6.3 version used hard-coded (Linux) values. 		*/
/*  These tables are used to map item codes to strings, and were formerly used	*/
/*  to map the hard coded values to the corresponding VMS symbolic values.	*/
#define NL_ENT(e,i,n,v)  { e, i, n, v }
#define NL_ITEM(itm, eifval)  NL_ENT (eifval, itm, #itm, )
#define NL_ITEM_DEF(itm, eifval, defval)  NL_ENT (eifval, itm, #itm, defval)
typedef struct { int32 eifval; nl_item vmsval; const char* nam; const char* def;} nl_item_map_entry_t;
static const nl_item_map_entry_t nl_item_map_source[] = {
	NL_ITEM (CODESET, 0), 
	NL_ITEM (ABDAY_1, 0x20000), NL_ITEM (ABDAY_2, 0x20001), NL_ITEM (ABDAY_3, 0x20002), NL_ITEM (ABDAY_4, 0x20003), 
	NL_ITEM (ABDAY_5, 0x20004), NL_ITEM (ABDAY_6, 0x20005), NL_ITEM (ABDAY_7, 0x20006), 
	NL_ITEM (DAY_1, 0x20007), NL_ITEM (DAY_2, 0x20008), NL_ITEM (DAY_3, 0x20009), NL_ITEM (DAY_4, 0x2000A), 
	NL_ITEM (DAY_5, 0x2000B), NL_ITEM (DAY_6, 0x2000C), NL_ITEM (DAY_7, 0x2000D), 
	NL_ITEM (ABMON_1, 0x2000E), NL_ITEM (ABMON_2, 0x2000F), NL_ITEM (ABMON_3, 0x20010), NL_ITEM (ABMON_4, 0x20011), 
	NL_ITEM (ABMON_5, 0x20012), NL_ITEM (ABMON_6, 0x20013), NL_ITEM (ABMON_7, 0x20014), NL_ITEM (ABMON_8, 0x20015),  
	NL_ITEM (ABMON_9, 0x20016), NL_ITEM (ABMON_10, 0x20017), NL_ITEM (ABMON_11, 0x20018), NL_ITEM (ABMON_12, 0x20019), 
	NL_ITEM (MON_1, 0x2001A), NL_ITEM (MON_2, 0x2001B), NL_ITEM (MON_3, 0x2001C), NL_ITEM (MON_4, 0x2001D), 
	NL_ITEM (MON_5, 0x2001E), NL_ITEM (MON_6, 0x2001F), NL_ITEM (MON_7, 0x20020), NL_ITEM (MON_8, 0x20021), 
	NL_ITEM (MON_9, 0x20022), NL_ITEM (MON_10, 0x20023), NL_ITEM (MON_11, 0x20024), NL_ITEM (MON_12, 0x20025), 
	NL_ITEM (AM_STR, 0x20026), NL_ITEM (PM_STR, 0x20027), 
	NL_ITEM (D_T_FMT, 0x20028), NL_ITEM (D_FMT, 0x20029), NL_ITEM (T_FMT, 0x2002A), 
	NL_ITEM (T_FMT_AMPM, 0x2002B), NL_ITEM_DEF (CRNCYSTR, 0x4000F, "-$")
#ifdef moose  /* these are currently unused in {I18N_POSIX_CONSTANTS} */
	NL_ITEM (RADIXCHAR, ), NL_ITEM (THOUSEP, ), 
	NL_ITEM (YESSTR, ), NL_ITEM (NOSTR, ), 
	NL_ITEM (ERA, ), NL_ITEM (ERA_D_FMT, ), 
	NL_ITEM (ALT_DIGITS, ), 
	NL_ITEM (YESEXPR, ), NL_ITEM (NOEXPR, ), 
	NL_ITEM (ERA_T_FMT, ), NL_ITEM (ERA_D_T_FMT, )
#endif
};
static nl_item_map_entry_t *nl_item_map_vmsval;

#define REMAP_EIFFEL_NL_ITEM_CODES
#ifdef REMAP_EIFFEL_NL_ITEM_CODES
static nl_item_map_entry_t *nl_item_map_eifval;
/* comparison routine used for sorting and searching nl_item_map: compare eifval values */
static int nl_item_compare_eifval (const nl_item_map_entry_t* p1, const nl_item_map_entry_t* p2)
{
    if (p1->eifval < p2->eifval)
	return -1;
    else if (p1->eifval == p2->eifval)
	return 0;
    else
	return 1;
}
#endif // REMAP_EIFFEL_NL_ITEM_CODES

/* comparison routine used for sorting and searching nl_item_map: compare vmsval values */
static int nl_item_compare_vmsval (const nl_item_map_entry_t* p1, const nl_item_map_entry_t* p2)
{
    if (p1->vmsval < p2->vmsval)
	return -1;
    else if (p1->vmsval == p2->vmsval)
	return 0;
    else
	return 1;
}

/* jacket for nl_langinfo () */
char_ptr32 eifrt_vms_nl_langinfo (nl_item eif_item)
{
    char_ptr32 result, orig;
    nl_item_map_entry_t item, *nlp;
    nl_item vms_item;		// remapped (if necessary) eif_item
    char_ptr32 DECC$NL_LANGINFO (nl_item item);
    static size_t num = CARDINALITY(nl_item_map_source);
    static size_t siz = sizeof(nl_item_map_entry_t);

    //REQUIRE ("eifval first element of nl_item_map_entry", offsetof (nl_item_map_entry_t, eifval) == 0);

    if (nl_item_map_vmsval == NULL) {
	nl_item_map_vmsval = calloc (num, siz);
	memcpy (nl_item_map_vmsval, nl_item_map_source, sizeof (nl_item_map_source));
	qsort (nl_item_map_vmsval, num, siz, (int (*)(const void*, const void*))nl_item_compare_vmsval);
#ifdef REMAP_EIFFEL_NL_ITEM_CODES
	nl_item_map_eifval = calloc (num, siz);
	memcpy (nl_item_map_eifval, nl_item_map_source, sizeof (nl_item_map_source));
	qsort (nl_item_map_eifval, num, siz, (int (*)(const void*, const void*))nl_item_compare_eifval);
#endif
    }

#define DEBUG
#ifdef DEBUG
    //result = DECC$NL_LANGINFO (vms_item);	// what was this for? 
    result = DECC$NL_LANGINFO (eif_item);	// what was this for? 
#endif

    item.vmsval = eif_item;
    item.eifval = eif_item;
    nlp = bsearch (&item, nl_item_map_vmsval, num, siz, (int (*)(const void*, const void*))nl_item_compare_vmsval);
    if (nlp) {
	vms_item = nlp->vmsval;
#ifdef VMS_TRACE_NL_LANGINFO
	printf ("eifrtvms: nl_langinfo(%d. [\"%s\", unmapped])\n", vms_item, safe_string (nlp->nam));
#endif
#ifdef REMAP_EIFFEL_NL_ITEM_CODES
    } else {
	nlp = bsearch (&item, nl_item_map_eifval, num, siz, (int (*)(const void*, const void*))nl_item_compare_eifval);
	if (nlp) {
	    vms_item = nlp->eifval;
#ifdef VMS_TRACE_NL_LANGINFO
	    printf ("eifrtvms: nl_langinfo(%d. [\"%s\", mapped from 0x%x])\n", vms_item, safe_string (nlp->nam), eif_item, eif_item);
#endif // VMS_TRACE_NL_LANGINFO
	}
#endif // REMAP_EIFFEL_NL_ITEM_CODES
    }

    if (!nlp) {
	vms_item = eif_item;
#ifdef VMS_TRACE_NL_LANGINFO
       printf ("eifrtvms: nl_langinfo (%d. [0x%x, unknown item code])\n", vms_item, vms_item);
#endif
    }
    orig = result = DECC$NL_LANGINFO (vms_item);
    if (vms_item == CODESET && result && !strcmp (result, "ASCII")) {
	result = "ISO8859-1";
#ifdef VMS_TRACE_NL_LANGINFO
	printf ("  returning \"%s\" (substituted for \"ASCII\")\n", safe_string(result), safe_string (orig));
#endif
    } else if (vms_item == CRNCYSTR && (result == NULL || *result == '\0')) {
	result = "$";
#ifdef VMS_TRACE_NL_LANGINFO
	printf ("  returning \"%s\" (substituted for \"%s\")\n", safe_string (result), safe_string(orig));
#endif
    } else {
#ifdef VMS_TRACE_NL_LANGINFO
	printf ("  returning \"%s\"\n", safe_string(result));
#endif
    }
    return result;
}


/*** ICONV jackets ***/

#undef iconv
#undef iconv_open
#undef iconv_close

#define IS_64BIT(p) ( (p) != NULL && !$is_32bits(*(p)) )
#define SAFE_PTR(p)   ( (p) ? *p : NULL )
#define SAFE_SIZE(p)  ( (p) ? *p : 0 )
/* VMS iconv() is 32 bit only. This is the current prototype in <iconv.h>, under a  #pragma __pointer_size 32:
**	size_t iconv (iconv_t cd, const char** inpbuf, size_t *inpbytesleft, char** outbuf, size_t *outbytesleft) ;
*/
size_t eifrt_vms_iconv (iconv_t a_cd, const char **a_inpbuf, size_t *a_inpbytesleft, char **a_outbuf, size_t *a_outbytesleft)
{
    size_t result;
    char_ptr32 inpbuf32, inpbuf32_orig, *foopp32;
    char_ptr32 outbuf32, outbuf32_orig;
    char_ptr_ptr32 inpbufpp, outbufpp;
    size_t inpbytesleftx, outbytesleftx, outbytescount;
    size_t DECC$ICONV (iconv_t cd, char_ptr_ptr32 inpbf, size_t_ptr32 inpbytleft, char_ptr_ptr32 outbf, size_t_ptr32 outbytleft);
    int err, erv;

#ifdef VMS_TRACE_ICONV
    char* outbuf_orig = SAFE_PTR (a_outbuf);
    printf ("eifrt_vms_iconv (cd=0x%08Lp, *inpbuf=0x%08Lp, *inpbytesleft=%d, *outbuf=0x%08Lp, *outbytesleft=%d)\n", 
		a_cd, SAFE_PTR (a_inpbuf), SAFE_SIZE (a_inpbytesleft), SAFE_PTR (a_outbuf), SAFE_SIZE (a_outbytesleft));
    if (a_inpbuf && a_inpbytesleft)
	printf ("    **inpbuf: \"%.*s\"\n", *a_inpbytesleft, *a_inpbuf);
#endif

#if __INITIAL_POINTER_SIZE > 32
    /* copy input to 32 bit space if necessary */
    if (a_inpbytesleft != NULL && *a_inpbytesleft != 0 && IS_64BIT (a_inpbuf)) {
	inpbuf32 = inpbuf32_orig = _malloc32 (*a_inpbytesleft);
	memcpy (inpbuf32, *a_inpbuf, *a_inpbytesleft);
	inpbufpp = &inpbuf32;
    } else {
	inpbuf32_orig = NULL;
#pragma message save
#pragma message disable (MAYHIDELOSS)    // checked: a_inpbuf is clearly 32 bits here or else we don't care
	inpbufpp = (char_ptr_ptr32)a_inpbuf;
#pragma message restore
}

    /* point output to 32 bit space if necessary */
    if (a_outbytesleft != NULL && *a_outbytesleft != 0 && IS_64BIT(a_outbuf)) {
	outbuf32 = outbuf32_orig = _malloc32 (*a_outbytesleft);
	outbufpp = &outbuf32;
    } else {
	outbuf32_orig = NULL;
#pragma message save
#pragma message disable (MAYHIDELOSS)    // checked: a_outbuf is 32 bits here or it doesn't matter
	outbufpp = (char_ptr_ptr32)a_outbuf;
#pragma message restore
    }

    inpbytesleftx = SAFE_SIZE (a_inpbytesleft);
    outbytesleftx = SAFE_SIZE (a_outbytesleft);
    result = DECC$ICONV (a_cd, inpbufpp, &inpbytesleftx, outbufpp, &outbytesleftx);
    err = errno; erv = vaxc$errno;
    if (a_outbytesleft) 
	outbytescount = *a_outbytesleft - outbytesleftx;	// count of bytes written to output buffer
    else outbytescount = 0;

#else // __INITIAL_POINTER_SIZE
#error incomplete
    result = DECC$ICONV (a_cd, a_inpbuf, a_inpbytesleft, a_outbuf, a_outbytesleft);
    err = errno; erv = vaxc$errno;
#endif // __INITIAL_POINTER_SIZE

#ifdef VMS_TRACE_ICONV
    printf ("  iconv(32) returned %d, *inpbytesleft: %d, *outbytesleft: %d)\n", 
	    result, inpbytesleftx, outbytesleftx);
    if (outbytescount)
	printf ("    **outbuf: \"%.*s\"\n", outbytescount, *outbufpp - outbytescount);
    if (errno)
	printf ("  errno: %d %s\n", err, strerror (err));
#endif

    /* update the pointer arguments post-conversion */
    if (inpbuf32_orig)
	*a_inpbuf += SAFE_SIZE (a_inpbytesleft) - inpbytesleftx;
	free (inpbuf32_orig);
    if (a_inpbytesleft) 
	*a_inpbytesleft = inpbytesleftx;

    /* copy the output from 32 bit space to caller's 64 bit space if necessary */
    //if (!$is_32bits(*a_outbuf)) {
    if (outbuf32_orig) {
	CHECK ("outbuf consistent", outbuf32_orig == outbuf32 - outbytescount);
	memcpy (*a_outbuf, outbuf32_orig, outbytescount);
	*a_outbuf += outbytescount;
	free (outbuf32_orig);
    }
    if (a_outbytesleft)
	*a_outbytesleft = outbytesleftx;

#ifdef VMS_TRACE_ICONVxxx
    printf ("  returning %d (*outbuf: \"%.*s\"),\n\t updated *inpbuf=0x%08Lp, inpbytesleft= %d, *outbuf=0x%08Lp, *outbytesleft=%d)\n", 
	    result, outbytescount, outbuf_orig, *a_inpbuf, *a_inpbytesleft, *a_outbuf, *a_outbytesleft);
#endif

    return result;
}


int eifrt_vms_iconv_close (iconv_t cd)
{
    int DECC$ICONV_CLOSE (iconv_t);
    static int level = 1;

#ifdef VMS_TRACE_ICONV_OPEN
    printf ("eifrtvms: %siconv_close (0x%08Lp)\n", spaces(level), cd);
#endif
    return DECC$ICONV_CLOSE (cd);
}


iconv_t eifrt_vms_iconv_open (const char *tocode, const char *fromcode)
{   
    iconv_t result;
    int err, erv;
    static const char *altcode = "ISO8859-1";
    static int level = 0;
    iconv_t DECC$ICONV_OPEN (const char* tocode, const char* fromcode);

    ++level;
#ifdef VMS_TRACE_ICONV_OPEN
    printf ("eifrtvms: %siconv_open (\"%s\", \"%s\")\n", spaces(level), safe_string (tocode), safe_string (fromcode));
#endif
    result = DECC$ICONV_OPEN (tocode, fromcode);
    if (result == (iconv_t)-1) {
	err = errno;
	erv = vaxc$errno;
	if (!strcasecmp (fromcode, "ASCII")) {
#ifdef VMS_TRACE_ICONV_OPEN
	    printf (" %sfailed, retrying with (\"%s\", \"%s\")\n", spaces(level), safe_string (tocode), safe_string (altcode));
#endif
	    result = eifrt_vms_iconv_open (tocode, altcode);
	} else if (!strcasecmp (tocode, "ASCII")) {
#ifdef VMS_TRACE_ICONV_OPEN
	    printf (" %sfailed, retrying with (\"%s\", \"%s\")\n", spaces(level), safe_string (tocode), safe_string (altcode));
#endif
	    result = eifrt_vms_iconv_open (altcode, fromcode);
	}
    }
    if (result == (iconv_t)-1) {
	err = errno;
	erv = vaxc$errno;
iconv_open_failure: // label for debugging
#ifdef VMS_TRACE_ICONV_OPEN
	printf (" %siconv_open failed, errno: %d [%s]\n", spaces(level), errno == EVMSERR ? vaxc$errno : errno, strerror (errno, vaxc$errno));
#endif
    } else {
#ifdef VMS_TRACE_ICONV_OPEN
	if (level == 1) 
	    printf (" %siconv_open succeeded (return 0x%08Lp.\n", spaces(level), result);
#endif
    }
    --level;
    return result;
}


/* cached string of spaces of length `len' */
static char* spacedup (size_t len) ;
static const char* spaces (size_t len)
{
    char* result;
    size_t cur;
    static char* cachep = NULL;

    if (cachep == NULL) 
	result = cachep = spacedup (cur = len);
    else if (len <= (cur = strlen(cachep))) 
	result = cachep + cur - len;
    else {
	free (cachep);
	result = cachep = spacedup (len);
	}
    return result;
}

/* allocate a string of length `len' filled with spaces */
static char* spacedup (size_t len)
{
    char* result;
    result = malloc (len + 1);
    memset (result, ' ', len);
    result[len] = '\0';
    return result;
}

static const char* safe_string (const char* p)
{
    if (p == NULL)
	return "<NULL>";
    else return p;
}

static void* safe_ptr (void *p)
{
    if (p == NULL)
	return p;
    else return *(void**)p;
}

static size_t safe_size (size_t *p)
{
    if (p == NULL)
	return 0;
    else return *p;
}


#ifdef TEST
#include <stdio.h>
#include <ssdef.h>
#include <errno.h>
#include <starlet.h>		/* for sys$getmsg() */

main (int argc, char* argv[]) 
{
    int err, erv;
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

#ifdef moose2
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
#endif /* moose2 */


    // test iconv and related stuff 
    iconv_t cd;
    char inpbuf[100], outbuf[200], *inp, *outp;

    cd = eifrt_vms_iconv_open ("UTF-8", "ISO8859-1");
    err = errno; erv = vaxc$errno;
    size_t siz, inpsiz, outsiz;

    // test iconv wrapper with all null/0 args, which `ENCODING_IMP.c_iconv' does (in Eiffel library/encoding/implementation/unix/encoding_imp.e)
    siz = eifrt_vms_iconv (cd, NULL, NULL, NULL, NULL);
    err = errno; erv = vaxc$errno;
    // test iconv wrapper with a straightforward string
    inp = strcpy (inpbuf, "HelloDummy");
    inpsiz = 5;
    outp = outbuf;
    outsiz = sizeof(outbuf);
    siz = eifrt_vms_iconv (cd, (const char**) &inp, &inpsiz, &outp, &outsiz);
    err = errno; erv = vaxc$errno;
    eifrt_vms_iconv_close (cd);


    if (argc < 2) {
	printf ("Usage: %s <eiffel_i18n_posix_value>...\n", argv[0]);
    } else {
	for (ii=1;  ii < argc;  ++ii) {
	    p = argv[ii];
	    // ***tbs***
	} /* end for */
    }

}
#endif	/* TEST */

#endif /* __VMS */

/*
doc:</file>
*/
