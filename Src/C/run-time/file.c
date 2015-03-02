/*
	description: "Externals for class FILE."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2012, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="file.c" header="eif_file.h" version="$Id$" summary="Externals for FILE class">
*/

#include "eif_portable.h"	/* must come before <errno.h> for VMS */
#include "eif_path_name.h"	/* for eifrt_vms_directory_file_name */

#include <string.h>

#ifdef _CRAY
#include <sys/param.h>
#endif
/* #include <stdio.h>	*/	/* %%zs here, moved <stdio.h> into file.h */
#include <errno.h>
#include <ctype.h>

#ifdef EIF_OS2
#include <io.h>
#include <direct.h>
#elif defined EIF_WINDOWS
	/* <unistd.h> doesn't exist under Windows */
#include <io.h>			/* %%ss added for access, chmod */
#include <direct.h>		/* %%ss added for (ch|mk|rm)dir */
#else
#include <unistd.h>
#endif

#ifdef I_TIME
#include <time.h>
#endif
#ifdef I_UTIME
#include <utime.h>
#endif

#ifdef I_SYSUTIME
#include <sys/utime.h>
#endif


#ifdef EIF_VMS
#include <assert.h>
rt_private int err;			/* for debugging - save errno value */
rt_private char filnam[FILENAME_MAX +1];
#ifndef HAS_UTIME
struct utimbuf {
	time_t actime;	/* access time */
	time_t modtime;	/* modification time */
};
#endif
#include <lib$routines.h>
#include <descrip.h>
#include <rmsdef.h>
#include <unixlib.h>		/* for mkdir, geteuid, getegid,... */
#include <unixio.h>			/* for access(),chown() */
#include <processes.h>		/* for system() */
#endif /* EIF_VMS */

#include "rt_err_msg.h"
#ifdef I_PWD
#include <pwd.h>
#endif
#ifdef I_GRP
#include <grp.h>
#endif

#ifdef I_TIME
#include <time.h>
#endif
#ifdef I_SYS_TIME
#include <sys/time.h>
#endif
#ifdef I_SYS_TIME_KERNEL
#define KERNEL
#include <sys/time.h>
#undef KERNEL
#endif

#ifdef I_FCNTL
#include <fcntl.h>
#endif
#ifdef I_SYS_FILE
#include <sys/file.h>
#endif

#include "rt_except.h"
#include "eif_plug.h"
#include "rt_error.h"
#include "eif_dir.h"

#include "rt_file.h"
#include "rt_out.h"
#include "rt_lmalloc.h"
#include "rt_constants.h"
#include "rt_assert.h"
#include "rt_globals_access.h"

#ifdef EIF_WINDOWS
/* Unfortunately Windows does not provide exactly the same type between utime and _wutime. */
#define utimbuf _utimbuf
#endif

#define FS_START	0			/* Beginning of file for `fseek' */
#define FS_CUR		1			/* Current position for `fseek' */
#define FS_END		2			/* End of file for `fseek' */
#define ST_MODE		0x0fff		/* Keep only permission mode */

rt_private EIF_FILENAME rt_file_open_mode (int how, char mode);
rt_private FILE *rt_file_fopen(EIF_FILENAME name, EIF_FILENAME type);		/* Open file */
rt_private FILE *rt_file_fdopen(int fd, EIF_FILENAME type);	/* Open file descriptor (UNIX specific) */
rt_private FILE *rt_file_freopen(EIF_FILENAME name, EIF_FILENAME type, FILE *stream);	/* Reopen file */
rt_private void rt_swallow_nl(FILE *f);		/* Swallow next character if new line */
rt_private int rt_rename(EIF_FILENAME from, EIF_FILENAME to);
rt_private int rt_rmdir(EIF_FILENAME path);
rt_private int rt_mkdir(EIF_FILENAME path, int mode);
rt_private int rt_unlink(EIF_FILENAME path);
rt_private int rt_utime(EIF_FILENAME path, struct utimbuf *times);

/* Some system routine calls can be interrupted by a signal, we reemit
 * them until they are not interrupted anymore . */
#define EIF_REPEAT_INTERRUPTED_CALL(status,func) \
	for (;;) { \
		errno = 0;					/* Reset error condition */ \
		status = (func);			/* Attempt function call */ \
		if (status == - 1) {		/* An error occurred */ \
			if (errno == EINTR) {	/* Interrupted by signal */ \
				continue;			/* Re-issue system call */ \
			} else { \
				esys();				/* Raise exception */ \
			} \
		} \
		break; \
	}

/*
 * Opening a file.
 */

/*
doc:	<routine name="rt_file_open_mode" return_type="EIF_FILENAME" export="public">
doc:		<summary>Given `how' the file is being opened and a `mode' create a platform specific character string (UTF-16 encoding on Windows and a byte sequence otherwise) that can be used by the underlying OS system call to open the mode in the proper mode (e.g. open append, read-write mode, ....)</summary>
doc:		<return>Platform specific character string describing how a file should be open.</return>
doc:		<param name="how" type="int">How are we opening the file (see class FILE for the constant value).</param>
doc:		<param name="mode" type="char">Are we open the file in binary or text mode or append mode.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_private EIF_FILENAME rt_file_open_mode (int how, char mode)
{
	RT_GET_CONTEXT
#ifndef EIF_THREADS
#ifdef EIF_WINDOWS
	static wchar_t file_type [FILE_TYPE_MAX];
#else
	static char file_type [FILE_TYPE_MAX];
#endif
#endif

	file_type[4] = '\0';
	file_type[3] = '\0';
	file_type[2] = '\0';
	if (how >= 10) how -= 10;
	switch (how) {
		case 0: 
		case 3: file_type[0] = 'r'; break;
		case 1:
		case 4: file_type[0] = 'w'; break;
		case 2:
		case 5: file_type[0] = 'a'; break;
		default: file_type[0] = 'r'; break;
	}
	file_type[1] = mode;
	switch (how) {
		case 3:
		case 4:
		case 5:
			if (mode == '\0') {
				file_type[1] = '+';
			} else {
				file_type[2] = '+';
			}
	}
#ifdef EIF_WINDOWS
	/* We make sure that files created in Eiffel are not inheritable
	 * by default as otherwise it makes things too complicated for the
	 * end user when spawing child processes. */
	if (file_type [1] == '\0') {
		file_type [1] = 'N';
	} else if (file_type [2] == '\0') {
		file_type [2] = 'N';
	} else {
		file_type [3] = 'N';
	}
#endif
	return file_type;
}

/*
doc:	<routine name="eif_file_open" return_type="EIF_POINTER" export="public">
doc:		<summary>Open file `name' with the corresponding type `how'.</summary>
doc:		<return>Descriptor of the open file or NULL on failure.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="how" type="int">See `rt_file_open_mode'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_file_open(EIF_FILENAME name, int how)
{
#if defined EIF_WINDOWS || defined EIF_VMS
	return (EIF_POINTER) rt_file_fopen(name, rt_file_open_mode(how, (how < 10 ? 't' : 'b')));
#else
	return (EIF_POINTER) rt_file_fopen(name, rt_file_open_mode(how,'\0'));
#endif
}

/*
doc:	<routine name="eif_file_dopen" return_type="EIF_POINTER" export="public">
doc:		<summary>Open file descriptor `fd' with the corresponding type `how'.</summary>
doc:		<return>Descriptor of the open file or NULL on failure.</return>
doc:		<param name="fd" type="int">File descriptor</param>
doc:		<param name="how" type="int">See `rt_file_open_mode'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_file_dopen(int fd, int how)
{
#ifdef EIF_WINDOWS
	return (EIF_POINTER) rt_file_fdopen(fd, rt_file_open_mode(how, (how < 10 ? 't' : 'b')));
#else
	return (EIF_POINTER) rt_file_fdopen(fd, rt_file_open_mode(how,'\0'));
#endif
}

/*
doc:	<routine name="eif_file_reopen" return_type="EIF_POINTER" export="public">
doc:		<summary>Reopen file `name' with the corresponding type `how' and substitute that to the old stream described by `old'. This is useful to redirect 'stdout' to another place, for instance.</summary>
doc:		<return>Descriptor of the open file or NULL on failure.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="how" type="int">See `rt_file_open_mode'.</param>
doc:		<param name="old" type="FILE *">Old file stream.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_file_reopen(EIF_FILENAME name, int how, FILE *old)
{
#ifdef EIF_WINDOWS
	return (EIF_POINTER) rt_file_freopen(name, rt_file_open_mode(how, (how < 10 ? 't' : 'b')), old);
#else
	return (EIF_POINTER) rt_file_freopen(name, rt_file_open_mode(how,'\0'), old);
#endif
}

/*
doc:	<routine name="eif_file_binary_open" return_type="EIF_POINTER" export="public">
doc:		<summary>Open file `name' with the corresponding type 'how' in binary mode.</summary>
doc:		<return>Descriptor of the open file or NULL on failure.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="how" type="int">See `rt_file_open_mode'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_file_binary_open(EIF_FILENAME name, int how)
{
#if defined EIF_WINDOWS || defined EIF_OS2 || defined EIF_VMS
	return (EIF_POINTER) rt_file_fopen(name, rt_file_open_mode(how,'b'));
#else
	return (EIF_POINTER) rt_file_fopen(name, rt_file_open_mode(how,'\0'));
#endif
}

/*
doc:	<routine name="eif_file_binary_dopen" return_type="EIF_POINTER" export="public">
doc:		<summary>Open file descriptor `fd' with the corresponding type `how' in binary mode.</summary>
doc:		<return>Descriptor of the open file or NULL on failure.</return>
doc:		<param name="fd" type="int">File descriptor</param>
doc:		<param name="how" type="int">See `rt_file_open_mode'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_file_binary_dopen(int fd, int how)
{
#if defined EIF_WINDOWS || defined EIF_OS2
	return (EIF_POINTER) rt_file_fdopen(fd, rt_file_open_mode(how,'b'));
#else
	return (EIF_POINTER) rt_file_fdopen(fd, rt_file_open_mode(how,'\0'));
#endif
}

/*
doc:	<routine name="eif_file_binary_reopen" return_type="EIF_POINTER" export="public">
doc:		<summary>Reopen file `name' with the corresponding type `how' and substitute that to the old stream described by `old' in binary mode. This is useful to redirect 'stdout' to another place, for instance.</summary>
doc:		<return>Descriptor of the open file or NULL on failure.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="how" type="int">See `rt_file_open_mode'.</param>
doc:		<param name="old" type="FILE *">Old file stream.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_POINTER eif_file_binary_reopen(EIF_FILENAME name, int how, FILE *old)
{
#if defined  EIF_WINDOWS || defined EIF_OS2
	return (EIF_POINTER) rt_file_freopen(name, rt_file_open_mode(how,'b'), old);
#else
	return (EIF_POINTER) rt_file_freopen(name, rt_file_open_mode(how,'\0'), old);
#endif
}

#ifdef EIF_VMS
#ifndef USE_VMS_JACKETS
#undef fopen	/* remove fopen jacket */
#define fopen DECC$FOPEN
FILE* DECC$FOPEN (char *name, char*type, ...) ;
#endif /* VMS_JACKETS */
/* copies type to vms_type, removing 't' if present. returns TRUE if 't' was present, else FALSE. */
rt_private int vms_file_open_type (const char* type, char* vms_type)
{
	char *p;
	strcpy (vms_type, type);
	if (p = strchr(vms_type,'t')) {	/* if 't' present in copied string */
		strcpy (p, p+1);		/* then remove it */
	}
	return (p != NULL);
} /* end vms_file_open_type () */
#endif /* EIF_VMS */

/*
doc:	<routine name="rt_file_fopen" return_type="FILE *" export="private">
doc:		<summary>Perform underlying operating system call to open a file with name `name' in the mode `type' and raise an exception on failure.</summary>
doc:		<return>Descriptor of the open file (FILE *).</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="type" type="EIF_FILENAME">Open mode. See man page for `fopen'. Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_private FILE *rt_file_fopen(EIF_FILENAME name, EIF_FILENAME type)
{
	FILE *fp;

	errno = 0;
#ifdef EIF_VMS
	{
		char vms_type[FILE_TYPE_MAX+4];	/* must be at least as big as static char type[] in rt_file_open_mode() */
		assert (strlen(type) < sizeof vms_type);
		vms_file_open_type (type, vms_type);
		if (vms_file_open_type (type, vms_type) && type[0] == 'w' && 0) {
				/* text file open for write (create): force stream_lf */
#ifdef USE_VMS_JACKETS
				/* define VMS_OPEN_ARGS_1 " ", "ctx=stm" */
			fp = fopen (name, vms_type, "rat=cr","rfm=stmlf", "shr=get");
#else
			fp = fopen (name, vms_type, "rat=cr","rfm=stmlf", "shr=get");
#endif
		} else {
				/* binary, or text file for read: force stream access */
			fp = fopen (name, vms_type, "ctx=stm", "shr=get");
		}
		err = (errno == EVMSERR ? vaxc$errno : errno);
	}
#elif defined EIF_WINDOWS
	fp = _wfopen(name, type);
#else
	fp = fopen(name, type);
#endif
	if (!fp) {
		esys();				/* Open failed, raise exception */
	}
	return fp;
}

/*
doc:	<routine name="rt_file_fdopen" return_type="FILE *" export="private">
doc:		<summary>Perform underlying operating system call to open a file using a file descriptor `fd' in the mode `type' and raise an exception on failure.</summary>
doc:		<return>Descriptor of the open file (FILE *).</return>
doc:		<param name="fd" type="int">File descriptor for which a FILE pointer is requested.</param>
doc:		<param name="type" type="EIF_FILENAME">Open mode. See man page for `fopen'. Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_private FILE *rt_file_fdopen(int fd, EIF_FILENAME type)
{
	FILE *fp;

	errno = 0;
#ifdef EIF_WINDOWS
	fp = _wfdopen(fd, type);
#else
	fp = fdopen(fd, type);
#endif
#ifdef EIF_VMS
	err = (errno == EVMSERR ? vaxc$errno : errno);
	if (fp == NULL && errno == EINVAL) {
		/* VMS: **TBS** - if errno=emode, remove 'b' and try again */
		char *p = strchr(type, 'b');
		if (p) {
			off_t len = p - type;
			char vms_type[FILE_TYPE_MAX+4];	/* must be at least as big as static char type[] in rt_file_open_mode() */
			strncpy (vms_type, type, len);
			strcpy (vms_type + len, ++p);
			fp = rt_file_fdopen (fd, vms_type);
		}
	}
#endif
	if (!fp) {
		esys();				/* Open failed, raise exception */
	}

	return fp;
}

/*
doc:	<routine name="rt_file_freopen" return_type="FILE *" export="private">
doc:		<summary>Opens the file whose name is `name' and associates the stream pointed to by stream with it. The original stream (if it exists) is closed. The mode `type' argument is used just as in the `rt_file_open' function. The primary use of this function is to change the file associated with a standard text stream (stderr, stdin, or stdout).</summary>
doc:		<return>Descriptor of the open file (FILE *).</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="type" type="EIF_FILENAME">Open mode. See man page for `fopen'. Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="stream" type="FILE *">Stream being reused to open file `name'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_private FILE *rt_file_freopen(EIF_FILENAME name, EIF_FILENAME type, FILE *stream)
{
	FILE *fp;

	errno = 0;
#ifdef EIF_WINDOWS
	fp = _wfreopen(name, type, stream);
#else
	fp = freopen(name, type, stream);
#endif
	if (!fp) {
		esys();				/* Open failed, raise exception */
	}

	return fp;
}

/*
 * Dealing with a file.
 */

/*
doc:	<routine name="eif_file_close" return_type="void" export="public">
doc:		<summary>Close file `fp'.</summary>
doc:		<param name="fp" type="FILE_ *">File pointer we wish to close.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_close(FILE *fp)
{
	errno = 0;
	if (0 != fclose(fp)) {
		esys();				/* Close failed, raise exception */
	}
}

/*
doc:	<routine name="eif_file_flush" return_type="void" export="public">
doc:		<summary>Flush data held in file `fp'.</summary>
doc:		<param name="fp" type="FILE_ *">File pointer we wish to flush.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_flush (FILE *fp)
{
	errno = 0;
	if (0 != fflush(fp)) {
		esys();				/* Flush failed, raise exception */
	}

#ifdef EIF_WINDOWS
		/* On Windows, it does not write directly to disk, so we have to force it. See KB66052:
		 * http://support.microsoft.com/kb/66052
		 * We ignore bad file descriptor case, as it is most likely when calling it on one of the standard
		 * input/outputs. */
	if ((0 != _commit(fileno(fp))) && (errno != EBADF)) {
		esys();
	}

#elif defined(EIF_VMS)
		/* VMS: flush RMS buffers (shouldn't this be done on other platforms also?) */
	if (0 != fsync(fileno(fp))) {
		err = (errno == EVMSERR ? vaxc$errno : errno);
		esys();
	}
#endif
}

rt_public EIF_INTEGER eif_file_size (FILE *fp)
{
	rt_stat_buf buf;
#ifdef EIF_VMSxxx
	int current_pos;
	int fd;
#endif

	errno = 0;

#ifdef EIF_VMSxxx	/* disable this questionable hack, for now --- dss */
	/* handle vms bug by positioning to end before fsync-ing --mark howard*/
	fd = fileno (fp);
	current_pos = lseek(fd,0,SEEK_CUR);
	lseek(fd,0,SEEK_END);
	if (0 != fsync (fd))	/* have to flush all the way! */
		esys();
	lseek(fd,current_pos,SEEK_SET);	
#endif
	if (0 != fflush (fp))		/* Without a flush the information */
		esys();					/* is not up to date */
#ifdef EIF_VMS
	/* for VMS, must also flush RMS buffers to file system */
	if (0 != fsync(fileno(fp))) {
	    err = (errno == EVMSERR ? vaxc$errno : errno);
	    esys();
	}
#endif

	if (rt_fstat (fileno(fp), &buf) == -1)
		esys();		/* An error occurred: raise exception */
		/* FIXME: This code should be upgraded to use 64-bit */
	return (EIF_INTEGER) buf.st_size;
}

rt_public EIF_BOOLEAN eif_file_feof(FILE *fp) 
{
	return (EIF_BOOLEAN) (feof(fp) != 0);	/* End of file? */
}

/*
 * I/O routines (output).
 */

rt_public void eif_file_pi(FILE *f, EIF_INTEGER number)
{
	/* Write `number' on `f' */

	errno = 0;
	if (0 > fprintf(f, "%d", number))
		eise_io("FILE: unable to write INTEGER value.");
}

rt_public void eif_file_pr(FILE *f, EIF_REAL_32 number)
{
	RT_GET_CONTEXT
		/* Write `number' on `f' */
	int res;
	res = c_buffero_outr32(number);
	if (res >= 0) {
		errno = 0;
		res = fprintf(f, "%s", buffero);
	}
	if (res < 0) {
		eise_io("FILE: unable to write REAL_32 value.");
	}
}

rt_public void eif_file_pib(FILE *f, EIF_INTEGER number)
{
	/* Write `number' on `f' */

	errno = 0;
	if (1 != fwrite(&number, sizeof(EIF_INTEGER),1, f))
		eise_io("FILE: unable to write INTEGER value.");
}

rt_public void eif_file_prb(FILE *f, EIF_REAL_32 number)
{
	/* Write `number' on `f' */

	errno = 0;
    if (1 != fwrite(&number, sizeof(EIF_REAL_32),1, f))
		eise_io("FILE: unable to write REAL_32 value.");
}

rt_public void eif_file_ps(FILE *f, char *str, EIF_INTEGER len)
{
	/* Write string `str' on `f' */

	if (len == 0)		/* Empty string */
		return;			/* Nothing to be done */

	errno = 0;
#ifdef EIF_VMS
	getname (fileno(f), filnam);		/* DEBUG */
	/* on VMS, fwrite to a "record" (non-stream) file will cause an entire record to be written.  */
	/* Though we try to make stream files for text (see rt_file_fopen), we may be writing to a	      */
	/* text record file (eg. a log file) created by some other agency.			      */
	{
	    int res, l = strlen (str);
	    /* assert (len <= l); */
	    err = (errno == EVMSERR ? vaxc$errno : errno);
	    if (l == len) 
		res = fputs (str, f);
	    else if (len < l) 
		res = fprintf (f, "%.*s", len, str);
	    else 
		res = DECC$RECORD_WRITE (f, str, len);
	    err = (errno == EVMSERR ? vaxc$errno : errno);
	    if (res < 0)
		eise_io("FILE: unable to write STRING object.");
	}
#else
	if (1 != fwrite(str, sizeof (char) * len, 1, f))
		eise_io("FILE: unable to write STRING object.");
#endif
}

rt_public void eif_file_pc(FILE *f, char c)
{
	/* Write character `c' on `f' */

	errno = 0;
	if (EOF == putc(c, f))
		eise_io("FILE: unable to write CHARACTER value.");
}

rt_public void eif_file_pd(FILE *f, EIF_REAL_64 val)
{
	RT_GET_CONTEXT
	/* Write double `val' onto `f' */
	int res;
	res = c_buffero_outr64(val);
	if (res >= 0) {
		errno = 0;
		res = fprintf(f, "%s", buffero);
	}
	if (res < 0) {
		eise_io("FILE: unable to write REAL_64 value.");
	}
}

rt_public void eif_file_pdb(FILE *f, EIF_REAL_64 val)
{
	/* Write double `val' onto `f' */

	errno = 0;
	if (1 != fwrite (&val, sizeof(double), 1, f))
		eise_io("FILE: unable to write REAL_64 value.");
}

rt_public void eif_file_tnwl(FILE *f)
{
	/* Put new_line onto `f' */

	errno = 0;
	if (EOF == putc('\n', f))
		eise_io("FILE: unable to write new line.");
}

rt_public void eif_file_append(FILE *f, FILE *other, EIF_INTEGER l)
        			/* Target file */
            		/* Source file */
              		/* Amount of bytes from `other' to be appended */
{
	/*	Append a copy of `other' to `f' */

	char buffer[BUFSIZ];
	size_t amount;

	errno = 0;
    if (0 != fseek(other, 0, FS_START))
		esys();
    if (0 != fseek(f, 0, FS_END))
		esys();

	while (l > 0) {
		amount = l;
		if (l < BUFSIZ)
			amount = l;
		else
			amount = BUFSIZ;
		if (amount != fread(buffer, sizeof(char), amount, other))
			eise_io("FILE: unable to read appended file.");
		l = (l - (EIF_INTEGER) amount);
		if (amount != fwrite(buffer, sizeof(char), amount, f))
			eise_io("FILE: unable to write appended file.");
	}
}

/*
 * I/O routines (input).
 */

rt_private void rt_swallow_nl(FILE *f)
{
	/* Swallow next character if it is a new line */

		/* getc() cannot be used as it doesn't set the EOF flag */

	if (f != stdin) {
		if (fscanf (f, "\n") == EOF && ferror(f)) {
			eise_io ("FILE: error during reading the end of the file,");
		}
	} else {
		int c;

		errno = 0;
		c = getc(f);
		if (c == EOF && ferror(f))
			eise_io("FILE: error during reading the end of the file.");

		if (c != '\n' && EOF == ungetc(c, f))
			eise_io("FILE: End of file.");
	}
}
			
rt_public void eif_file_tnil(FILE *f)
{
	/* Read upto next input line */

	int	c;

	errno = 0;
	while ((c = getc(f)) != '\n' && c != EOF)
		;
	if (c == EOF && ferror(f))
		eise_io("FILE: error during reading the end of the file.");
}

rt_public EIF_INTEGER eif_file_gi(FILE *f)
{             
	/* Get an integer from `f' */

	EIF_INTEGER i;     

	errno = 0;
	if (0 > fscanf(f, "%d", &i))
		eise_io("FILE: unable to read INTEGER value.");
	rt_swallow_nl(f);

	return i;
}

rt_public EIF_REAL_32 eif_file_gr(FILE *f)
{             
	/* Get a real from `f' */

	EIF_REAL_32 r;     

	errno = 0;
	if (0 > fscanf(f, "%f", &r))
		eise_io("FILE: unable to read REAL_32 value.");
	rt_swallow_nl(f);

	return r;
}

rt_public EIF_REAL_64 eif_file_gd(FILE *f)
{             
	/* Get a double from `f' */

	EIF_REAL_64 d;     

	errno = 0;
	if (0 > fscanf(f, "%lf", &d))
		eise_io("FILE: unable to read REAL_64 value.");
	rt_swallow_nl(f);

	return d;
}
rt_public EIF_INTEGER eif_file_gib(FILE *f)
{             
	/* Get an integer from `f' */

	EIF_INTEGER i;     

	errno = 0;
	if (1 != fread (&i, sizeof (EIF_INTEGER), 1, f))
		eise_io("FILE: unable to read INTEGER value.");

	return i;
}

rt_public EIF_REAL_32 eif_file_grb(FILE *f)
{             
	/* Get a real from `f' */

	EIF_REAL_32 r;     

	errno = 0;
	if (1 != fread (&r, sizeof (EIF_REAL_32), 1, f))
		eise_io("FILE: unable to read REAL_32 value.");

	return r;
}

rt_public EIF_REAL_64 eif_file_gdb(FILE *f)
{             
	/* Get a double from `f' */

	EIF_REAL_64 d;     

	errno = 0;
	if (1 != fread (&d, sizeof(EIF_REAL_64), 1, f))
		eise_io("FILE: unable to read REAL_64 value.");

	return d;
}

rt_public EIF_CHARACTER_8 eif_file_gc(FILE *f)
{
	/* Get a character from `f' */

	int c;

	errno = 0;
	c = getc(f);
	if (c == EOF && ferror(f))
		eise_io("FILE: unable to read CHARACTER value.");

	return (EIF_CHARACTER_8) c;
}

rt_public EIF_INTEGER eif_file_gs(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
                  		/* Amount of characters already held in buffer */
{
	/* Get a string from `f' and fill it into `s' (at most `bound' characters),
	 * with `start' being the amount of bytes already stored within s. This
	 * means we really have to read (bound - start) characters.
	 */

	EIF_INTEGER amount;	/* Amount of bytes to be read */
	int c = '\0';			/* Last char read */
	EIF_INTEGER read;		/* Number of characters read */

	amount = bound - start;		/* Characters to be read */
	s += start;					/* Where read characters are written */
	errno = 0;					/* No error, a priori */
	read = 0;

	while (amount-- > 0) {
		if ((c = getc(f)) == '\n' || c == EOF)
			break;
		*s++ = (char) c;
		read++;
	}
	
	if (c == EOF && ferror(f))	/* An I/O error occurred */
		eise_io("FILE: unable to read current line.");					/* Raise exception */

	/* If we managed to get the whole string, return the number of characters
	 * read. Otherwise, return (bound - start + 1) to indicate an error
	 * condition.
	 */

	if ((c == EOF) || (c == '\n')) {
#ifdef EIF_WINDOWS
		if ((read > 0) && (*(s-1) == '\r')) {
			return read - 1;
		} else {
			return read;
		}
#else
		return read;
#endif
	}
	if (amount == -1)
		return (read + 1);

	return bound - start + 1;			/* Error condition */
}

rt_public EIF_INTEGER eif_file_gss(FILE *f, char *s, EIF_INTEGER bound)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
{
	/* Read min (bound, remaining bytes in file) characters into `s' and
	 * return the number of characters read.
	 */

	size_t amount = fread(s, sizeof(char), (size_t) bound, f);

	if (ferror(f)) {	/* An I/O error occurred */
		eise_io("FILE: unable to read stream.");					/* Raise exception */
	}

	return (EIF_INTEGER) amount;	/* Number of characters read */
}

rt_public EIF_INTEGER eif_file_gw(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
                  		/* Amount of characters already held in buffer */
{
	/* Get a word from `f' and fill it into `s' (at most `bound' characters),
	 * with `start' being the amount of bytes already stored within s. This
	 * means we really have to read (bound - start) characters. Any leading
	 * spaces are skipped.
	 */

	EIF_INTEGER amount;	/* Amount of bytes to be read */
	int c = 0;			/* Last char read */

	amount = bound - start;		/* Characters to be read */
	s += start;					/* Where read characters are written */
	errno = 0;					/* No error, a priori */

	if (start == 0)	{			/* First call */
		while ((c = getc(f)) != EOF)
			if (!isspace(c))
				break;
		if (c == EOF && ferror(f))	/* An I/O error occurred */
			eise_io("FILE: unable to read word.");					/* Raise exception */
		if (c == EOF)
			return (EIF_INTEGER) 0;				/* Reached EOF before word */
		else if (EOF == ungetc(c, f))
			eise_io("FILE: unable to read word.");
	}

	while (amount-- > 0) {
		c = getc(f);
		if (c == EOF)
			break;
		if (isspace(c)) {
			if (EOF == ungetc(c, f))
				eise_io("FILE: unable to read word.");
			break;
		}
		*s++ = (char) c;
	}
	
	if (c == EOF && ferror(f))	/* An I/O error occurred */
		eise_io("FILE: unable to read word.");					/* Raise exception */

	/* If we managed to get the whole string, return the number of characters
	 * read. Otherwise, return (bound - start + 1) to indicate an error
	 * condition.
	 */
	
	if (c == EOF || isspace(c))
		return bound - start - amount - 1;	/* Number of characters read */

	return bound - start + 1;			/* Error condition */
}

rt_public EIF_CHARACTER_8 eif_file_lh(FILE *f)
{
	/* Look ahead one character. If EOF, return 0 */

	int c;

	errno = 0;
	c = getc(f);
	if (c == EOF && ferror(f))
		eise_io("FILE: error when reading a character ahead.");

	if (c != EOF && EOF == ungetc(c, f))
		eise_io("FILE: error when reading a character ahead.");

	return (EIF_CHARACTER_8) (c == EOF ? (char) 0 : (char) c);
}

/*
 * Accessing/changing inode.
 */

/*
doc:	<routine name="eif_file_chown" return_type="void" export="public">
doc:		<summary>Change owner of file `name' to `uid'.</summary>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="uid" type="int">UID that will be used to set owner of `name'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_chown(EIF_FILENAME name, int uid)
{
#ifdef HAS_CHOWN
	int gid;					/* Current Group ID */
	int status;					/* System call status */
	rt_stat_buf buf;			/* Buffer to get file statistics */
	
	rt_file_stat(name, &buf);
	gid = buf.st_gid;					/* Get GID on file */

	EIF_REPEAT_INTERRUPTED_CALL(status, chown(name, uid, gid));
#endif
}

/*
doc:	<routine name="eif_file_chgrp" return_type="void" export="public">
doc:		<summary>Change the group of file `name' to `gid'.</summary>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="uid" type="int">GID that will be used to set group of `name'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_chgrp(EIF_FILENAME name, int gid)
{
#ifdef HAS_CHOWN
	/* Change the group of the file to `gid' */

	int uid;					/* Current Owner ID */
	int status;					/* System call status */
	rt_stat_buf buf;			/* Buffer to get file statistics */
	
	rt_file_stat(name, &buf);
	uid = buf.st_uid;					/* Get UID on file */

	EIF_REPEAT_INTERRUPTED_CALL(status, chown(name, uid, gid));
#endif
}

/*
doc:	<routine name="eif_file_stat" return_type="int" export="public">
doc:		<summary>Query information about a file. If `follow' is non-zero then it tries to follow the symbolic link, otherwise it doesn't.</summary>
doc:		<param name="path" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="buf" type="rt_stat_buf *">Buffer collecting the info about the file.</param>
doc:		<param name="follow" type="int">Should we follow symbolic links?</param>
doc:		<return>0 if it succeeds, -1 otherwise. Upon failure `errno' is set with the reason code.</return>
doc:		<thread_safety>Re-entrant</thread_safety>
doc:	</routine>
*/
rt_public int eif_file_stat (EIF_FILENAME path, rt_stat_buf *buf, int follow) {
	int status;			/* System call status */
	
	for (;;) {
		errno = 0;						/* Reset error condition */
#ifdef HAS_LSTAT
		status = rt_lstat(path, buf);
		if ((status == 0) && (follow) && (S_ISLNK(buf->st_mode))) {
				/* We found a file which is a symbolic link and we are asked to
				 * follow the link to fetch properties on the link location.
				 * We call `rt_stat' to make sure the link is valid. It is going to
				 * slow down current call by stating twice the info, but this
				 * case is quite rare and there is a benefit in using `lstat'
				 * over `rt_stat' the first time as more than 90% of the files
				 * we stat are not symlink. */
			status = rt_stat (path, buf);
		}
#else
		status = rt_stat (path, buf);		/* Get file statistics */
#endif
		if ((status == -1) && (errno == EINTR)) {
				/* Call was interrupted by a signal we re-issue it. */
			continue;
		}
		break;
	}
#if defined EIF_VMS && defined _VMS_V6_SOURCE
	buf->st_uid &= 0x0000FFFF ;		/* VMS: mask out group id */
#endif

	return status;
}

/*
doc:	<routine name="rt_file_stat" return_type="void" export="shared">
doc:		<summary>Get information about specified file `path' by always following the symbolic links.</summary>
doc:		<param name="path" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="buf" type="rt_stat_buf *">Buffer to put information.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_shared void rt_file_stat (EIF_FILENAME path, rt_stat_buf *buf)
{
		/* To preserve compatibility we always follow symbolic links and raise an exception upon failure. */
	if (eif_file_stat(path, buf, 1) == -1) {
		esys();
	}
}

/*
doc:	<routine name="eif_file_info" return_type="EIF_INTEGER" export="public">
doc:		<summary>Access various information held by `buf'</summary>
doc:		<param name="buf" type="rt_stat_buf *">Buffer to put information.</param>
doc:		<param name="op" type="int">Type of information requested.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_file_info (rt_stat_buf *buf, int op)
{
    switch (op) {
	case 0:	/* File permission mode */
		return (EIF_INTEGER) (buf->st_mode & ST_MODE);
	case 1:	/* Inode number */
#ifdef EIF_VMS
		return (EIF_INTEGER) *(int*)buf->st_ino;	/* VMS: return 32 bits of 40/48 bit inode */
		/*** VMS: **TBS** assert (buf->st_ino[2] == 0? );  */
#else
		return (EIF_INTEGER) buf->st_ino;
#endif
	case 2:	/* Device inode resides on */
		return (EIF_INTEGER) buf->st_dev;
	case 3:	/* Device type */
		return (EIF_INTEGER) buf->st_rdev;
	case 4:	/* UID of file */
		return (EIF_INTEGER) buf->st_uid;
	case 5:	/* GID of file */
		return (EIF_INTEGER) buf->st_gid;
	case 6:	/* Size of file, in bytes */
			/* FIXME: This code should be upgraded to use 64-bit */
		return (EIF_INTEGER) buf->st_size;
	case 7:	/* Last modification time on file */
			/* FIXME: This code should be upgraded to use 64-bit */
		return (EIF_INTEGER) buf->st_mtime;
	case 8:	/* Last access made on file */
			/* FIXME: This code should be upgraded to use 64-bit */
		return (EIF_INTEGER) buf->st_atime;
	case 9:	/* Last status change */
			/* FIXME: This code should be upgraded to use 64-bit */
		return (EIF_INTEGER) buf->st_ctime;
	case 10: /* Number of links */
		return (EIF_INTEGER) buf->st_nlink;
	case 11: /* File type */
		return (EIF_INTEGER) (buf->st_mode & S_IFMT);
	case 12: /* Is file a directory */
		return (EIF_INTEGER) S_ISDIR(buf->st_mode);
	case 13: /* Is file a regular (plain) one */
		if (S_ISREG(buf->st_mode) || (0 == (buf->st_mode & S_IFMT)))
			return (EIF_INTEGER) EIF_TRUE;
		return (EIF_INTEGER) 0;
	case 14: /* Is file a device, ie character or block device. */
		return (S_ISCHR(buf->st_mode) || S_ISBLK(buf->st_mode));
	case 15: /* Is file a character device */
		return (EIF_INTEGER) S_ISCHR(buf->st_mode);
	case 16: /* Is file a block device */
		return (EIF_INTEGER) S_ISBLK(buf->st_mode);
	case 17: /* Is file a FIFO */
		return (EIF_INTEGER) S_ISFIFO(buf->st_mode);
	case 18: /* Is file a symbolic link */
		return (EIF_INTEGER) S_ISLNK(buf->st_mode);
	case 19: /* Is file a socket */
		return (EIF_INTEGER) S_ISSOCK(buf->st_mode);
	default:
		eif_panic(MTC "illegal stat request");
    }
	/* NOTREACHED */
	return 0; /* to avoid a warning */
}

/*
doc:	<routine name="eif_file_eaccess" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Check file permissions using effective UID and effective GID. The current permission mode is held in the st_mode field of the `rt_stat_buf' buffer structure `buf'.</summary>
doc:		<return>TRUE if access granted, FALSE otherwise.</return>
doc:		<param name="buf" type="rt_stat_buf *"></param>
doc:		<param name="op" type="int"></param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_file_eaccess(rt_stat_buf *buf, int op)
{
	int mode = buf->st_mode & ST_MODE;	/* Current mode */
#if defined HAS_GETEUID || defined HAS_GETUID
	uid_t uid = buf->st_uid;				/* File owner */
	gid_t gid = buf->st_gid;				/* File group */
#endif
#ifdef HAS_GETEUID
	uid_t euid, egid;						/* Effective user and group */
#endif

    switch (op) {
	case 0: /* Is file readable */
#if defined EIF_WINDOWS || defined EIF_OS2
	return (EIF_BOOLEAN)((mode & S_IREAD) ? '\01' : '\0');
#elif defined HAS_GETEUID
		euid = geteuid();
		egid = getegid();

		if (euid == 0)
			return (EIF_BOOLEAN) '\01';
		else if (uid == euid)
			return (EIF_BOOLEAN) ((mode & S_IRUSR) ? '\01' : '\0');
		else if (gid == egid)
			return (EIF_BOOLEAN) ((mode & S_IRGRP) ? '\01' : '\0');
#ifdef HAS_GETGROUPS
		else if (eif_group_in_list(gid))
			return (EIF_BOOLEAN) ((mode & S_IRGRP) ? '\01' : '\0');
#endif
		else
			return (EIF_BOOLEAN) ((mode & S_IROTH) ? '\01' : '\0');
#endif
	case 1: /* Is file writable */
#if defined EIF_WINDOWS || defined EIF_OS2
	return (EIF_BOOLEAN) ((mode & S_IWRITE) ? '\01' : '\0');
#elif defined HAS_GETEUID
		euid = geteuid();
		egid = getegid();

		if (euid == 0)
			return (EIF_BOOLEAN) '\01';
		else if (uid == euid)
			return (EIF_BOOLEAN) ((mode & S_IWUSR) ? '\01' : '\0');
		else if (gid == egid)
			return (EIF_BOOLEAN) ((mode & S_IWGRP) ? '\01' : '\0');
#ifdef HAS_GETGROUPS
		else if (eif_group_in_list(gid))
			return (EIF_BOOLEAN) ((mode & S_IWGRP) ? '\01' : '\0');
#endif
		else
			return (EIF_BOOLEAN) ((mode & S_IWOTH) ? '\01' : '\0');
#endif
	case 2: /* Is file executable */
#if defined EIF_WINDOWS || defined EIF_OS2
	return (EIF_BOOLEAN) '\01';
#elif defined HAS_GETEUID
		euid = geteuid();
		egid = getegid();

		if (euid == 0)
			return (EIF_BOOLEAN) '\01';
		else if (uid == euid)
			return (EIF_BOOLEAN) ((mode & S_IXUSR) ? '\01' : '\0');
		else if (gid == egid)
			return (EIF_BOOLEAN) ((mode & S_IXGRP) ? '\01' : '\0');
#ifdef HAS_GETGROUPS
		else if (eif_group_in_list(gid))
			return (EIF_BOOLEAN) ((mode & S_IXGRP) ? '\01' : '\0');
#endif
		else
			return (EIF_BOOLEAN) ((mode & S_IXOTH) ? '\01' : '\0');
#endif
	case 3: /* Is file setuid */
#if defined EIF_WINDOWS || defined EIF_OS2
		return (EIF_BOOLEAN) ('\0');
#else
		return (EIF_BOOLEAN) ((mode & S_ISUID) ? '\01' : '\0');
#endif
	case 4: /* Is file setgid */
#if defined EIF_WINDOWS || defined EIF_OS2
		return (EIF_BOOLEAN) ('\0');
#else
		return (EIF_BOOLEAN) ((mode & S_ISGID) ? '\01' : '\0');
#endif
	case 5: /* Is file sticky */
#if defined EIF_WINDOWS || defined EIF_OS2 || defined VXWORKS
		return (EIF_BOOLEAN) ('\0');
#else
		return (EIF_BOOLEAN) ((mode & S_ISVTX) ? '\01' : '\0');
#endif
	case 6: /* Is file owned by effective UID */
#ifdef HAS_GETEUID
		return (EIF_BOOLEAN) ((uid == geteuid()) ? '\01' : '\0');
#else
		return (EIF_BOOLEAN) '\01';
#endif
	case 7: /* Is file owned by real UID */
#ifdef HAS_GETEUID
		return (EIF_BOOLEAN) ((uid == getuid()) ? '\01' : '\0');
#else
		return (EIF_BOOLEAN) '\01';
#endif
	default:
		eif_panic(MTC "illegal access request");
	}
	/* NOTREACHED */
	return 0;
}

/*
doc:	<routine name="eif_file_access" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Check wheter access permission `op' are possible on file `name' using real UID and real GID. This is probably only useful for setuid or setgid programs.</summary>
doc:		<return>TRUE if access granted, FALSE otherwise.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/

rt_public EIF_BOOLEAN eif_file_access(EIF_FILENAME name, EIF_INTEGER op)
{
#ifdef VXWORKS
	return ('\01');
#else
	switch (op) {
	case 0: /* Does file exist? */
		return (EIF_BOOLEAN) ((-1 != rt_access(name, F_OK)) ? '\01' : '\0');
	case 1: /* Test for search permission */
		return (EIF_BOOLEAN) ((-1 != rt_access(name, X_OK)) ? '\01' : '\0');
	case 2: /* Test for write permission */
		return (EIF_BOOLEAN) ((-1 != rt_access(name, W_OK)) ? '\01' : '\0');
	case 3: /* Test for read permission */
		return (EIF_BOOLEAN) ((-1 != rt_access(name, R_OK)) ? '\01' : '\0');
	default:
		eif_panic(MTC "illegal access request");
		return ('\0');	/* NOT REACHED */
	}

#endif
}

/*
doc:	<routine name="eif_file_exists" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Test whether file exists or not. If `name' represents a symbolic link, it will check that pointed file does exist.</summary>
doc:		<return>TRUE if file exists, FALSE otherwise.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_file_exists(EIF_FILENAME name)
{
	int status;					/* System call status */
	rt_stat_buf buf;			/* Buffer to get file statistics */

	status = eif_file_stat (name, &buf, 1);
	
#if (EIF_OS == EIF_OS_SUNOS) || (EIF_OS == EIF_OS_LINUX)
	if (status == -1) {
			/* If the file is larger than what our file routines can handle
			 * it does not mean that the file does not exist. It does but we
			 * cannot handle it.
			 * This is needed to be able to check existence of file bigger than 2GB.
			 */
		return (errno == EOVERFLOW ? EIF_TRUE : EIF_FALSE);
	} else {
		return EIF_TRUE;
	}
#else
	return (status == -1 ? EIF_FALSE : EIF_TRUE);
#endif
}

/*
doc:	<routine name="eif_file_path_exists" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Test whether file exists or not. If `name' represents a symbolic link, it will not follow the link, simply check that the symbolic link does exist.</summary>
doc:		<return>TRUE if file exists, FALSE otherwise.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_file_path_exists(EIF_FILENAME name)
{
	int status;					/* System call status */
	rt_stat_buf buf;			/* Buffer to get file statistics */

	status = eif_file_stat (name, &buf, 0);
	
#if (EIF_OS == EIF_OS_SUNOS) || (EIF_OS == EIF_OS_LINUX)
	if (status == -1) {
			/* If the file is larger than what our file routines can handle
			 * it does not mean that the file does not exist. It does but we
			 * cannot handle it.
			 * This is needed to be able to check existence of file bigger than 2GB.
			 */
		return (errno == EOVERFLOW ? EIF_TRUE : EIF_FALSE);
	} else {
		return EIF_TRUE;
	}
#else
	return (status == -1 ? EIF_FALSE : EIF_TRUE);
#endif
}

/*
doc:	<routine name="eif_file_date_for" return_type="EIF_INTEGER" export="private">
doc:		<summary>Access time of a file.</summary>
doc:		<return>Seconds since epoch (01 January 1970) in UTC or 0 if time cannot be retrieved.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="mode" type="int">Mode of operation: non-zero for modification and zero for access time.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_private EIF_INTEGER eif_file_date_for (EIF_FILENAME name, int mode)
{
	EIF_INTEGER result = 0;
#ifdef EIF_WINDOWS
		/* On NTFS file system, windows store UTC file stamps in 100 of nanoseconds
		 * starting from January 1st 0. Converted in seconds, this time is greater
		 * than 232 therefore we substract the EPOCH date January 1st 1970 to get
		 * a 32 bits representation of the date.
		 * FIXME: Manu 01/28/2004: On FAT file system, the date is in local time,
		 * meaning that the code below does not compensate if you change your timezone
		 * and will return a different date value for the same stamp just because
		 * you are in different time zone.
		 */
		 
		 /* WARNING: This is using the Ansi version of the Win32 API. Remember
		  * that if you are doing any change below.
		  */

	WIN32_FIND_DATAW l_find_data;
	HANDLE l_file_handle;
	ULARGE_INTEGER l_date;

	l_file_handle = FindFirstFileW (name, &l_find_data);
	if (l_file_handle != INVALID_HANDLE_VALUE) {
			/* We do not need the file handle anymore, so we close it to
			 * avoid handle leak. */
		FindClose (l_file_handle);
		if (mode) {
			l_date.LowPart = l_find_data.ftLastWriteTime.dwLowDateTime;
			l_date.HighPart = l_find_data.ftLastWriteTime.dwHighDateTime;
		} else {
			l_date.LowPart = l_find_data.ftLastAccessTime.dwLowDateTime;
			l_date.HighPart = l_find_data.ftLastAccessTime.dwHighDateTime;
		}
			/* Convert 100-nanosecond intervals to seconds
			 * and ajust "1 Jan 1601" to "1 Jan 1970".
			 * The difference between "1 Jan 1601" and "1 Jan 1970"
			 * can be precomputed using the following code:
			 *	SYSTEMTIME epoch = {1970, 1, 0, 1, 0, 0, 0, 0};
			 *	FILETIME epoch_file;
			 *	ULARGE_INTEGER epoch_date;
			 *	SystemTimeToFileTime (&epoch, &epoch_file);
			 *	epoch_date.LowPart = epoch_file.dwLowDateTime;
			 *	epoch_date.HighPart = epoch_file.dwHighDateTime;
			 * time_shift = epoch_date.QuadPart / 10000000UL; // 11644473600
			 */
		result = (EIF_INTEGER) (l_date.QuadPart / RTU64C(10000000) - RTU64C(11644473600));
	}
#else
	rt_stat_buf	info;
	if (-1 != eif_file_stat (name, &info, 1)) {
		result = (mode ?  (EIF_INTEGER) info.st_mtime: (EIF_INTEGER) info.st_atime);
	}
#endif
	return result;
}

/*
doc:	<routine name="eif_file_date" return_type="EIF_INTEGER" export="public">
doc:		<summary>Modification time of a file.</summary>
doc:		<return>Seconds since epoch (01 January 1970) in UTC or 0 if time cannot be retrieved.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_file_date (EIF_FILENAME name)
{
	return eif_file_date_for (name, 1);
}

/*
doc:	<routine name="eif_access_file_date" return_type="EIF_INTEGER" export="public">
doc:		<summary>Access time of a file.</summary>
doc:		<return>Seconds since epoch (01 January 1970) in UTC or 0 if time cannot be retrieved.</return>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_file_access_date (EIF_FILENAME name)
{
	return eif_file_date_for (name, 0);
}

/*
 * Interfacing with file system.
 */

/*
doc:	<routine name="eif_file_rename" return_type="void" export="public">
doc:		<summary>Rename file.</summary>
doc:		<param name="from" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="to" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_rename(EIF_FILENAME from, EIF_FILENAME to)
{
	int status;			/* System call status */

#if defined EIF_WINDOWS || defined EIF_OS2
	if (eif_file_exists (to)) {
			/* To have the same behavior as Unix, we need to remove the destination file if it exists.
			 * Of course we can do this only if `from' and `to' do not represent the same file.
			 * To check this, we use `CreateFile' to open both file, and then using the information
			 * returned by `GetFileInformationByHandle' we can check whether or not they are indeed
			 * the same. */
		BY_HANDLE_FILE_INFORMATION l_to_info, l_from_info;
		HANDLE l_from_file = CreateFileW (from, GENERIC_READ, FILE_SHARE_READ, NULL,
			OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
		HANDLE l_to_file = CreateFileW (to, GENERIC_READ, FILE_SHARE_READ, NULL,
				OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

		if ((l_from_file == INVALID_HANDLE_VALUE) || (l_to_file == INVALID_HANDLE_VALUE)) {
				/* We do not need the handles anymore, simply close them. Since Microsoft
				 * API accepts INVALID_HANDLE_VALUE we don't check the validity of arguments. */
			CloseHandle(l_from_file);
			CloseHandle(l_to_file);

				/* For some reasons we cannot open the file. This should not happen, maybe the OS has
				 * removed `from' or `to'. In that case, we simply try to remove destination as we were
				 * doing in former revision of `file_rename'. */
			_wremove (to);
		} else {
			BOOL success = GetFileInformationByHandle (l_from_file, &l_from_info);
			if (success) {
				success = GetFileInformationByHandle (l_to_file, &l_to_info);
					/* We do not need the handles anymore, simply close them. */
				CloseHandle(l_from_file);
				CloseHandle(l_to_file);
				if (success) {
						/* Check that `from' and `to' do not represent the same file. */
					if
						((l_from_info.dwVolumeSerialNumber != l_to_info.dwVolumeSerialNumber) ||
						(l_from_info.nFileIndexLow != l_to_info.nFileIndexLow) ||
						(l_from_info.nFileIndexHigh != l_to_info.nFileIndexHigh))
					{
						_wremove (to);
					} else {
							/* Files are identical, nothing to be done */
						return;
					}
				} else {
						/* An error occurred while retrieving the information about `from' and `to'. Like
						 * for the case where `l_from_file' and `l_to_file' are invalid, we try to remove
						 * the file. */
					_wremove (to);
				}
			} else {
					/* We do not need the handles anymore, simply close them. */
				CloseHandle(l_from_file);
				CloseHandle(l_to_file);
					/* An error occurred while retrieving the information about `from' and `to'. Like
					 * for the case where `l_from_file' and `l_to_file' are invalid, we try to remove
					 * the file. */
				_wremove (to);
			}
		}
	}
#endif	/* (platform) */
	EIF_REPEAT_INTERRUPTED_CALL(status, rt_rename(from, to));
}

/*
doc:	<routine name="eif_file_link" return_type="void" export="public">
doc:		<summary>Create a symbolic link on platforms that supports it from file `from' to file `to'.</summary>
doc:		<param name="from" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="to" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/

rt_public void eif_file_link(EIF_FILENAME from, EIF_FILENAME to)
{
#ifdef HAS_LINK
	int status;			/* System call status */
	EIF_REPEAT_INTERRUPTED_CALL(status, link(from, to));
#endif
}

rt_public void eif_file_mkdir(EIF_FILENAME path)
{
	/* Create directory `path' */

	int status;			/* System call status */

#if !defined EIF_VMS
	EIF_REPEAT_INTERRUPTED_CALL(status, rt_mkdir(path, 0777));
#else

	char vms_path [PATH_MAX +1];
#ifdef EIF_VMS_V6_ONLY
	char duplicate[PATH_MAX];
	strcpy(duplicate,path);
#endif
	
	for (;;) {
		errno = 0;			/* Reset error condition */
		status = mkdir(path, 0777);	/* Create directory `path' */
		if (status == -1) {		/* An error occurred */
			if (errno == EINTR)	/* Interrupted by signal */
				continue;	/* Re-issue system call */
			else
				esys();		/* Raise exception */
		}

		/* Under VMS, mkdir will not grant delete privelege by default
		 * on directory just created. However if no delete priv then
		 * then VMS access() thinks the project isn't writable. 
		 * For now (till we fix the writability check that uses access)
		 * Now set delete protection on dir file */
#ifdef EIF_VMS_V6_ONLY
		status = chmod(dir_dot_dir(duplicate),0777);
		err = errno;
		if (status == -1) {
			esys();
		}
#else
		err = (errno == EVMSERR ? vaxc$errno : errno);
		status = chmod (path, 0777);
		err = (errno == EVMSERR ? vaxc$errno : errno);
		if (eifrt_vms_directory_file_name (path, vms_path)) {
		    status = chmod (vms_path, 0777);
		    err = (errno == EVMSERR ? vaxc$errno : errno);
		}
#endif
		break;
	}
#endif
}

/*
doc:	<routine name="eif_file_unlink" return_type="void" export="public">
doc:		<summary>Delete file or directory pointed by `name'.</summary>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_unlink(EIF_FILENAME name)
{
	rt_stat_buf buf;				/* File statistics */
	int status;						/* Status from system call */

		/* No need to follow links since `rt_unlink' does not follow them anyway. */
	status = eif_file_stat(name, &buf, 0);
	if (status == -1 ) {
		esys();
	} else {
		if (S_ISDIR(buf.st_mode)) {		/* Directory */
				/* Remove directory only if it is empty. */
			EIF_REPEAT_INTERRUPTED_CALL(status, rt_rmdir(name));
		} else {
			EIF_REPEAT_INTERRUPTED_CALL(status, rt_unlink(name));
		}
	}
}

/*
doc:	<routine name="eif_file_unlink" return_type="void" export="public">
doc:		<summary>Touch file `name' by setting both access and modification time to the current time stamp. This external function exists only because there is no way within UNIX_FILE to get the current time stamp--RAM. Otherwise, we could simply call file_utime.</summary>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/

rt_public void eif_file_touch(EIF_FILENAME name)
{
    eif_file_utime(name, time((Time_t *) 0), 2);
}

/*
 * Inode manipulations.
 */

/*
doc:	<routine name="eif_file_utime" return_type="void" export="public">
doc:		<summary>Modify the modification and/or the access time stored in the file's inode. The `how' parameter tells which attributes should be set.</summary>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="stamp" type="time_t">Time stamp.</param>
doc:		<param name="how" type="int">Any of 0 (Access time), 1 (Modification time), or 2 (Access and Modification time).</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_utime(EIF_FILENAME name, time_t stamp, int how)
{
	struct utimbuf tp;	/* Time array */
	rt_stat_buf buf;	/* File statistics */
	int status;			/* System call status */

	if (how < 2) {				/* Need to fetch time from inode */
		rt_file_stat(name, &buf);
		switch (how) {
		case 0:					/* Change only access time */
			tp.actime = stamp;
			tp.modtime = buf.st_mtime;
			break;
		case 1:					/* Change only modification time */
			tp.actime = buf.st_atime;
			tp.modtime = stamp;
			break;
		}
	} else
		tp.actime = tp.modtime = stamp;	/* Change both access and modification times */
	
	EIF_REPEAT_INTERRUPTED_CALL(status,rt_utime(name, &tp));
}

/*
doc:	<routine name="eif_file_perm" return_type="void" export="public">
doc:		<summary>Change permissions of file `name' using a simpler interface than `chmod'. If `flag' is true then permissions are added, otherwise they are removed.</summary>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="who" type="char *">String which represents the type of user which can be either be one of u (i.e User), g (i.e. Group) or o (i.e. Other).</param>
doc:		<param name="what" type="char *">String which represents the type of permission to change which can be `r', `w' or `x' for all type of users, `s' for Users and Groups, and `t' for Others.</param>
doc:		<fixme>We should allow all combinations of User, Group and Other, and add `a' for All.</fixme>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public void eif_file_perm(EIF_FILENAME name, char *who, char *what, int flag)
{
	int fmode;					/* File mode to be altered */
	rt_stat_buf buf;			/* File statistics */

		/* We need to follow links since `chmod' does follow them to change the permissions. */
	if (eif_file_stat(name, &buf, 1)) {
		esys();
	} else {
		fmode = (int) buf.st_mode;	/* Fetch current file mode */

		switch (*who) {
		case 'u':
			while (*what)
				switch (*what++) {
#if defined EIF_WINDOWS
				case 's': break;
				case 'r': break;
				case 'w': break;
				case 'x': break;
#elif defined EIF_OS2
				case 's': break;
				case 'r': break;
				case 'w': break;
				case 'x': break;
#else
				case 's':
					if (flag) fmode |= S_ISUID; else fmode &= ~S_ISUID;
					break;
				case 'r':
					if (flag) fmode |= S_IRUSR; else fmode &= ~S_IRUSR;
					break;
				case 'w':
					if (flag) fmode |= S_IWUSR; else fmode &= ~S_IWUSR;
					break;
				case 'x':
					if (flag) fmode |= S_IXUSR; else fmode &= ~S_IXUSR;
					break;
#endif
				default:
					eraise("invalid user permission", EN_EXT);
				}
			break;
		case 'g':
			while (*what)
				switch (*what++) {
				case 's':
#ifdef S_ISGID
					if (flag) fmode |= S_ISGID; else fmode &= ~S_ISGID;
#endif
					break;
				case 'r':
#ifdef S_IRGRP
					if (flag) fmode |= S_IRGRP; else fmode &= ~S_IRGRP;
#endif
					break;
				case 'w':
#ifdef S_IWGRP
					if (flag) fmode |= S_IWGRP; else fmode &= ~S_IWGRP;
#endif
					break;
				case 'x':
#ifdef S_IXGRP
					if (flag) fmode |= S_IXGRP; else fmode &= ~S_IXGRP;
#endif
					break;
				default:
					eraise("invalid group permission", EN_EXT);
				}
			break;
		case 'o':
			while (*what)
				switch (*what++) {
				case 't':
#ifdef S_ISVTX
					if (flag) fmode |= S_ISVTX; else fmode &= ~S_ISVTX;
#endif
					break;
				case 'r':
#ifdef S_IROTH
					if (flag) fmode |= S_IROTH; else fmode &= ~S_IROTH;
#endif
					break;
				case 'w':
#ifdef S_IWOTH
					if (flag) fmode |= S_IWOTH; else fmode &= ~S_IWOTH;
#endif
					break;
				case 'x':
#ifdef S_IXOTH
					if (flag) fmode |= S_IXOTH; else fmode &= ~S_IXOTH;
#endif
					break;
				default:
					eraise("invalid other permission", EN_EXT);
				}
			break;
		default:
			eraise("invalid permission target", EN_EXT);
		}
		eif_file_chmod(name, fmode);
	}
}

/*
doc:	<routine name="eif_file_perm" return_type="void" export="public">
doc:		<summary>Change permissions of file `name' using an interface like `chmod'.</summary>
doc:		<param name="name" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="mode" type="int">Encoded integer that specify the mode for file `name'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/

rt_public void eif_file_chmod(EIF_FILENAME path, int mode)
{
#ifndef VXWORKS
	int status;				/* Status from system call */
#ifdef EIF_WINDOWS
	EIF_REPEAT_INTERRUPTED_CALL(status, _wchmod(path, mode));
#else
	EIF_REPEAT_INTERRUPTED_CALL(status, chmod(path, mode));
#endif
#endif
}

/*
 * File cursor management.
 */

rt_public EIF_INTEGER eif_file_tell(FILE *f)
{
	/* Current position within file */
	long res;

	if (f == (FILE *) 0) {
		eraise("invalid file pointer", EN_EXT);
	}
	
	res = ftell(f);
	if (res == -1) {
		eraise("error occurred", EN_EXT);
	}
	return (EIF_INTEGER) res;
}

rt_public void eif_file_go(FILE *f, EIF_INTEGER pos)
{
	/* Go to absolute position 'pos' counted from start */

	errno = 0;							/* Reset error condition */
	if (0 != fseek(f, pos, FS_START))	/* Go there */
		esys();							/* Problem occurred, raise exception */
	clearerr(f);						/* Clear error status and EOF */
}

rt_public void eif_file_recede(FILE *f, EIF_INTEGER pos)
{
	/* Go to absolute position 'pos' counted from end */

	errno = 0;							/* Reset error condition */
	if (0 != fseek(f, -pos, FS_END))	/* Go there */
		esys();							/* Problem occurred, raise exception */
	clearerr(f);						/* Clear error status and EOF */
}

rt_public void eif_file_move(FILE *f, EIF_INTEGER pos)
{
	/* Go to absolute position 'pos' counted from current position */

	errno = 0;							/* Reset error condition */
	if (0 != fseek(f, pos, FS_CUR))		/* Go there */
		esys();							/* Problem occurred, raise exception */
	clearerr(f);						/* Clear error status and EOF */
}

/*
 * Miscellaneous routines.
 */

rt_public EIF_INTEGER stat_size(void)
{
	/* Size of the stat structure. This is used by the Eiffel side to create
	 * the area (special object) which will play the role of a stat buffer
	 * structure.
	 */

	return (EIF_INTEGER) sizeof(rt_stat_buf);
}

/*
doc:	<routine name="eif_file_creatable" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Check whether the file `path' may be created: we need write permissions in the parent directory and there must not be any file bearing that name with no write permissions. VMS: **TBS** (on VMS, there can be an unwritable file because a new version is created).</summary>
doc:		<return>TRUE if file can be created, FALSE otherwise.</return>
doc:		<param name="path" type="EIF_FILENAME">Null-terminated path in UTF-16 encoding on Windows and a byte sequence otherwise.</param>
doc:		<param name="nbytes" type="EIF_INTEGER">Number of bytes in `path'.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_file_creatable(EIF_FILENAME path, EIF_INTEGER nbytes)
{
	rt_stat_buf buf;			/* Buffer to get parent directory statistics */
	EIF_FILENAME temp = NULL;
	EIF_FILENAME ptr;
	size_t l_extra_bytes;

#ifdef EIF_VMS
	/* You can't do a `rt_stat' on a directory under VMS
	 * Just return true for now, fix this later!
	 */
	return (EIF_BOOLEAN) '\1';

#else
		/* Allocate one extra character, just to be sure since we might be appending characters. */
#ifdef EIF_WINDOWS
	l_extra_bytes = sizeof(wchar_t);
#else
	l_extra_bytes = sizeof(char);
#endif
	temp = (EIF_FILENAME) eif_malloc (nbytes + l_extra_bytes);
	if (!temp) {
		enomem();
	} else {
			/* Search the directory separator. */
#ifdef EIF_WINDOWS
		memcpy (temp, path, nbytes);
		ptr = wcsrchr (temp, '\\');
		if (!ptr) {
				/* On Windows we can have a forward slash as separator. */
			ptr = wcsrchr (temp, '/');
		}
#else
		strcpy (temp, path);
		ptr = strrchr (temp, '/');
#endif
		if (ptr) {
			*ptr = '\0';
#ifdef EIF_WINDOWS
			if ((ptr == temp) || (*(ptr -1) == ':')) {
					/* path is of the form a:\bbb or \bbb, parent is a:\ or \ */
				wcscat (ptr, L"\\");
			}
#endif
		} else {
#ifdef EIF_WINDOWS
			wcsncpy (temp, L".", 2);
#else
			strcpy (temp, ".");
#endif
		}

			/* Does the parent exist? */
		if (!eif_file_exists(temp)) {
			eif_free (temp);
			return (EIF_BOOLEAN) '\0';
		}

		rt_file_stat(temp, &buf);
		eif_free (temp);

		if (S_ISDIR(buf.st_mode)) {	/* Is parent a directory? */
			if (eif_file_eaccess(&buf, 1)) {	/* Check for write permissions */
					/* Check if a non writable file `path' exists */
				if (eif_file_exists(path)) {
					rt_file_stat(path, &buf);
					if (S_ISDIR(buf.st_mode)) {
							/* File exists and it is already a directory, thus we cannot create a file. */
						return (EIF_BOOLEAN) '\0';
					} else {
						return (eif_file_eaccess(&buf, 1)); /* Check for write permissions to re create it */
					}
				}

				return (EIF_BOOLEAN) '\01';
			}
		}
	}
	return (EIF_BOOLEAN) '\0';
#endif
}

/*
doc:	<routine name="eif_file_fd" return_type="void" export="public">
doc:		<summary>Return the associated file descriptor of `f'.</summary>
doc:		<param name="f" type="FILE_ *">File pointer we wish to get the file descriptor.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_INTEGER eif_file_fd(FILE *f)
{
	int res;
	if (!f) {
		res = 0;
		eraise("invalid file pointer", EN_EXT);
	} else {
		res = fileno(f);
		if (res == -1) {
			eraise("error occurred", EN_EXT);
		}
	}
	return (EIF_INTEGER) res;
}

/*
doc:	<routine name="eif_file_owner" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Return the Eiffel string filled in with the name associated with 'uid' if found in /etc/passwd. Otherwise, return fill it in with the numeric value.</summary>
doc:		<return>Eiffel string representing the owner if any, otherwise textual representation of `uid'.</return>
doc:		<param name="uid" type="int">Integer value of a UID.</param>
doc:		<fixme>Not implemented on all platforms.</fixme>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE eif_file_owner(int uid)
{

	char str[NAME_MAX];
#ifdef HAS_GETPWUID
#if defined(EIF_VMS) && __USE_64BIT_FUNCS
	struct __passwd64 *pp;	/* %%ss moved frm above */
#else
	struct passwd *pp; /* %%ss moved frm above */
#endif

	pp = getpwuid(uid);
#ifdef EIF_VMS
	if (pp == NULL)
#else
	if (pp == (struct passwd *) 0)
#endif
		sprintf(str, "%d", uid);		/* Not available: use UID */
	else
		strcpy(str, pp->pw_name);		/* Available: fetch login name */
#else
	sprintf(str, "%d", uid);			/* Not available: use UID */
#endif
	
	return makestr(str, strlen(str));
}

/*
doc:	<routine name="eif_file_group" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Return the Eiffel string filled in with the name associated with 'gid' if found in /etc/group. Otherwise, return fill it in with the numeric value.</summary>
doc:		<return>Eiffel string representing the owner if any, otherwise textual representation of `gid'.</return>
doc:		<param name="gid" type="int">Integer value of a UID.</param>
doc:		<fixme>Not implemented on all platforms.</fixme>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE eif_file_group(int gid)
{

	char str[NAME_MAX];
#ifdef HAS_GETGRGID
	struct group *gp; /* %%ss moved from above */

	gp = getgrgid(gid);
	if (gp == (struct group *) 0)
		sprintf(str, "%d", gid);		/* Not available: use GID */
	else
		strcpy(str, gp->gr_name);		/* Available: fetch login name */
#else
	sprintf(str, "%d", gid);			/* Not available: use UID */
#endif
	
	return makestr(str, strlen(str));
}

#ifdef HAS_GETGROUPS

/* Does the list of groups the user belongs to include `gid'? */
rt_shared EIF_BOOLEAN eif_group_in_list(gid_t gid)
{
	Groups_t group_list[NGROUPS_MAX];
	int i, nb_groups;

	if ((nb_groups = getgroups(NGROUPS_MAX, group_list)) == -1)
		xraise(EN_IO);

	for (i=0; i< nb_groups; i++)
		if (group_list[i] == gid)
			return (EIF_BOOLEAN) '\01';

	return (EIF_BOOLEAN) '\0';
}

#endif

/*
 * Emulation of possibly non-existent system calls.
 */

rt_private int rt_rename(EIF_FILENAME from, EIF_FILENAME to)
		/* Orginal name */
		/* Target name */
{
#ifndef HAS_RENAME
	(void) rt_unlink(to);
	if (-1 == link(from, to))
		return -1;
	if (-1 == rt_unlink(from))
		return -1;
#else
#ifdef EIF_WINDOWS
	return _wrename(from, to);
#else
	return rename(from, to);
#endif
#endif
}

rt_private int rt_rmdir(EIF_FILENAME path)
{
#ifndef HAS_RMDIR
#ifdef EIF_VMS
	printf("rmdir(\"%s\") not implemented under VMS yet.\n", path);
	return -1;
#else
	/* Emulates the rmdir() system call */

	char cmd[BUFSIZ];
	int status;			/* Status from the shell */

	errno = 0;			/* In case system() cannot fork */
	sprintf(cmd, "/bin/rmdir %s", path);
	status = system(cmd);
	if (errno != 0 || status != 0)
		return -1;
	
	return 0;
#endif
#else
#ifdef EIF_WINDOWS
	return _wrmdir(path);
#else
	return rmdir(path);
#endif
#endif
}

rt_private int rt_mkdir(EIF_FILENAME path, int mode)
{
#ifndef HAS_MKDIR
		/* Emulates the mkdir() system call */
	char cmd[BUFSIZ];
	int status;			/* Status from the shell */

	errno = 0;			/* In case system() cannot fork */
	sprintf(cmd, "/bin/mkdir %s", path);
	status = system(cmd);
	if (errno != 0 || status != 0)
		return -1;
	
	return 0;
#else
#ifdef EIF_WINDOWS
	return _wmkdir(path);
#else
	return mkdir(path, mode);
#endif
#endif
}

rt_private int rt_utime(EIF_FILENAME path, struct utimbuf *times)
{
#ifndef HAS_UTIME
	return -1;
#else
#ifdef EIF_WINDOWS
	return _wutime(path, times);
#else
	return utime(path, times);
#endif
#endif  /* HAS_UTIME */
}



rt_private int rt_unlink(EIF_FILENAME path)
{
#if !defined HAS_UNLINK && !defined unlink
#ifdef EIF_VMS
	int		status;
	struct dsc$descriptor_s		deldsc;

	deldsc.dsc$w_length = strlen(path);
	deldsc.dsc$a_pointer= path;
	deldsc.dsc$b_class = DSC$K_CLASS_S;
	deldsc.dsc$b_dtype = DSC$K_DTYPE_T;
	status  = lib$delete_file(&deldsc,
		/* default, related filespec */ 0,0,
		/* success,fail,confirm routines */ 0,0,0,
		/* user arg */ 0, /* result */ 0,/*context*/ 0);
	if ((status & 1) != 1) return -1;

	return 0;

#else  /* EIF_VMS */
	return -1;
#endif /* EIF_VMS */

#else
#ifdef EIF_WINDOWS
	return _wunlink(path);
#else
	return unlink(path);
#endif

#endif
}

/*
doc:</file>
*/
