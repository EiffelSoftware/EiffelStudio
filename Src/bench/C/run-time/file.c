/*

 ######     #    #       ######           ####
 #          #    #       #               #    #
 #          #    #       #               #    
 #####      #    #       #####           #
 #          #    #       #               #
 #          #    #       #        ###    #    #
 #          #    ######  ######   ###     ####

	Externals for class FILE

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

#ifdef I_UTIME
#include <utime.h>
#endif

#ifdef I_SYSUTIME
#include <sys/utime.h>
#endif


#define FILE_TYPE_MAX  4	/* max size of fopen type string (like "a+b") */

#ifdef EIF_VMS
#include <assert.h>
static int err;  		/* for debugging - save errno value */
static char filnam[FILENAME_MAX +1];
struct utimbuf {
    time_t actime;      /* access time */
    time_t modtime;     /* modification time */
};
#include <lib$routines.h>
#include <descrip.h>
#include <rmsdef.h>
#include <unixlib.h>		/* for mkdir, geteuid, getegid,... */
#include <unixio.h>  		/* for access(),chown() */
#include <processes.h>		/* for system() */
#endif /* EIF_VMS */

#include "eif_err_msg.h"
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

#include "eif_except.h"
#include "eif_plug.h"
#include "eif_error.h"
#include "eif_dir.h"

#include "eif_file.h"
#include "eif_lmalloc.h"

#define FS_START	0			/* Beginning of file for `fseek' */
#define FS_CUR		1			/* Current position for `fseek' */
#define FS_END		2			/* End of file for `fseek' */
#define ST_MODE		0x0fff		/* Keep only permission mode */

#ifndef NAME_MAX
#define NAME_MAX	10			/* Maximum length for user/group name */
#endif

rt_public char *file_open_mode(int how, char mode);		/* Open file */
rt_private char *file_fopen(char *name, char *type);		/* Open file */
rt_private char *file_fdopen(int fd, char *type);	/* Open file descriptor (UNIX specific) */
rt_private char *file_freopen(char *name, char *type, FILE *stream);	/* Reopen file */
/*rt_private char *file_binary_fopen();*/		/* Open file */ /* %%zs undefined */
/*rt_private char *file_binary_fdopen();*/	/* Open file descriptor (UNIX specific) */ /* %%zs undefined */
/*rt_private char *file_binary_freopen();*/	/* Reopen file */ /* %%zs undefined */
rt_private void swallow_nl(FILE *f);		/* Swallow next character if new line */

#ifndef HAS_UTIME
/* rt_private int utime(); */ /* %%ss removed and replaced by below */
rt_private int utime(char *path, struct utimbuf *times);	/* %%ss */
#endif

#ifndef HAS_UNLINK
#ifndef unlink
rt_private int unlink(char *path);
#endif
#endif


/*
 * Opening a file.
 */

rt_public char *file_open_mode (int how, char mode)
{
	static char type [FILE_TYPE_MAX];

	type[3] = '\0';
	type[2] = '\0';
	if (how >= 10) how -= 10;
	switch (how) {
	case 0: 
	case 3: type[0] = 'r'; break;
	case 1:
	case 4: type[0] = 'w'; break;
	case 2:
	case 5: type[0] = 'a'; break;
	default: type[0] = 'r'; break;
	}
	type[1] = mode;
	switch (how) {
	case 3:
	case 4:
	case 5: if (mode == '\0') type[1] = '+';
			else type[2] = '+';
	}
	return type;
}

rt_public EIF_POINTER file_open(char *name, int how)
{
	/* Open file `name' with the corresponding type 'how'. */

#if defined EIF_WINDOWS || defined EIF_VMS
	if (how < 10)
		return (EIF_POINTER) file_fopen(name, file_open_mode(how,'t'));
	else
		return (EIF_POINTER) file_fopen(name, file_open_mode(how,'b'));
#else
	return (EIF_POINTER) file_fopen(name, file_open_mode(how,'\0'));
#endif
}

rt_public EIF_POINTER file_dopen(int fd, int how)
{
	/* Open file `fd' with the corresponding type 'how'. */

#ifdef EIF_WINDOWS
	if (how < 10)
		return (EIF_POINTER) file_fdopen(fd, file_open_mode(how,'t'));
	else
		return (EIF_POINTER) file_fdopen(fd, file_open_mode(how,'b'));
#else
	return (EIF_POINTER) file_fdopen(fd, file_open_mode(how,'\0'));
#endif
}

rt_public EIF_POINTER file_reopen(char *name, int how, FILE *old)
{
	/* Reopen file `name' with the corresponding type 'how' and substitute that
	 * to the old stream described by `old'. This is useful to redirect 'stdout'
	 * to another place, for instance.
	 */

#ifdef EIF_WINDOWS
	if (how < 10)
		return (EIF_POINTER) file_freopen(name, file_open_mode(how,'t'), old);
	else
		return (EIF_POINTER) file_freopen(name, file_open_mode(how,'b'), old);
#else
	return (EIF_POINTER) file_freopen(name, file_open_mode(how,'\0'), old);
#endif
}

rt_public EIF_POINTER file_binary_open(char *name, int how)
{
	/* Open file `name' with the corresponding type 'how'. */

#if defined EIF_WINDOWS || defined EIF_OS2 || defined EIF_VMS
	return (EIF_POINTER) file_fopen(name, file_open_mode(how,'b'));
#else
	return (EIF_POINTER) file_fopen(name, file_open_mode(how,'\0'));
#endif
}

rt_public EIF_POINTER file_binary_dopen(int fd, int how)
{
	/* Open file `fd' with the corresponding type 'how'. */

#if defined EIF_WINDOWS || defined EIF_OS2
	return (EIF_POINTER) file_fdopen(fd, file_open_mode(how,'b'));
#else
	return (EIF_POINTER) file_fdopen(fd, file_open_mode(how,'\0'));
#endif
}

rt_public EIF_POINTER file_binary_reopen(char *name, int how, FILE *old)
{
	/* Reopen file `name' with the corresponding type 'how' and substitute that
	 * to the old stream described by `old'. This is useful to redirect 'stdout'
	 * to another place, for instance.
	 */

#if defined  EIF_WINDOWS || defined EIF_OS2
	return (EIF_POINTER) file_freopen(name, file_open_mode(how,'b'), old);
#else
	return (EIF_POINTER) file_freopen(name, file_open_mode(how,'\0'), old);
#endif
}

#ifdef EIF_WINDOWS
#include <windows.h>
#endif

#ifdef EIF_VMS
/* copies type to vms_type, removing 't' if present. returns TRUE if 't' was present, else FALSE. */
rt_private int file_open_type_text (const char* type, char* vms_type)
{
    char *p;
    strcpy (vms_type, type);
    if ( (p=strchr(vms_type,'t')) ) {	/* if 't' present in copied string */
	strcpy (p, p+1);		/* then remove it */
	return 1;
    }
    else return 0;
} /* end file_open_type_text () */
#endif /* EIF_VMS */

rt_private char *file_fopen(char *name, char *type)
{
	/* Issue the fopen() call and raise exception if it fails, or return the
	 * file pointer when sucessful.
	 */

	FILE *fp;

	errno = 0;
#ifdef EIF_VMS
	{
	    char vms_type[FILE_TYPE_MAX+4];  /* must be at least as big as static char type[] in file_open_mode()  */
	    assert (strlen(type) < sizeof vms_type);
	    if (file_open_type_text (type, vms_type) && (type[0] == 'w' || 1))
		 fp = fopen (name, vms_type, "rat=cr","rfm=stmlf", "shr=get");
	    else fp = fopen (name, vms_type, "shr=get");
	    err = (errno == EVMSERR ? vaxc$errno : errno);
	}
#else
	fp = (FILE *) fopen(name, type);
#endif
	if (fp == (FILE *) 0)
		esys();				/* Open failed, raise exception */
	return (char *) fp;
}

rt_private char *file_fdopen(int fd, char *type)
{
	/* Issue the fdopen() call and raise exception if it fails, or return the
	 * file pointer when sucessful.
	 */

	FILE *fp;

	errno = 0;
	fp = (FILE *) fdopen(fd, type);
#ifdef EIF_VMS
	err = (errno == EVMSERR ? vaxc$errno : errno);
	if (fp == NULL && errno == EINVAL) {
	    /* VMS: **TBS** - if errno=emode, remove 'b' and try again */
	    char *p = strchr(type, 'b');
	    if (p) {
		off_t len = p - type;
		char vms_type[FILE_TYPE_MAX+4];  /* must be at least as big as static char type[] in file_open_mode()  */
		strncpy (vms_type, type, len);
		strcpy (vms_type + len, ++p);
		fp = (FILE*)file_fdopen (fd, vms_type);
	    }
	}
#endif
	if (fp == (FILE *) 0)
		esys();				/* Open failed, raise exception */

	return (char *) fp;
}

rt_private char *file_freopen(char *name, char *type, FILE *stream)
{
	/* Issue the freopen() call and raise exception if it fails, or return the
	 * file pointer when sucessful.
	 */

	FILE *fp;

	errno = 0;
	fp = (FILE *) freopen(name, type, stream);
	if (fp == (FILE *) 0)
		esys();				/* Open failed, raise exception */

	return (char *) fp;
}

/*
 * Dealing with a file.
 */

rt_public void file_close(FILE *fp)
{
	/* Close the file */

	errno = 0;
	if (0 != fclose(fp))
		esys();				/* Close failed, raise exception */
}

rt_public void file_flush (FILE *fp)
{
	/* Flush data held in stdio buffer */

	errno = 0;
	if (0 != fflush(fp))
	    esys();				/* Flush failed, raise exception */
#ifdef EIF_VMS	/* VMS: flush RMS buffers (shouldn't this be done on other platforms also?) */
	if (0 != fsync(fileno(fp))) {
	    err = (errno == EVMSERR ? vaxc$errno : errno);
	    esys();
	}
#endif
}

rt_public  EIF_INTEGER file_size (FILE *fp)
{
	struct stat buf;
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
	if (0 != fflush (fp))   	/* Without a flush the information */
		esys();					/* is not up to date */
#ifdef EIF_VMS
	/* for VMS, must also flush RMS buffers to file system */
	if (0 != fsync(fileno(fp))) {
	    err = (errno == EVMSERR ? vaxc$errno : errno);
	    esys();
	}
#endif

	if (fstat (fileno(fp), &buf) == -1)
		esys();		/* An error occurred: raise exception */
	return (EIF_INTEGER) buf.st_size;
}

rt_public EIF_BOOLEAN file_feof(FILE *fp) 
{
	return (EIF_BOOLEAN) (feof(fp) != 0);	/* End of file? */
}

/*
 * I/O routines (output).
 */

rt_public void file_pi(FILE *f, EIF_INTEGER number)
{
	/* Write `number' on `f' */

	errno = 0;
	if (0 > fprintf(f, "%d", number))
		eise_io("FILE: unable to write INTEGER value.");
}

rt_public void file_pr(FILE *f, EIF_REAL number)
{
	/* Write `number' on `f' */

	errno = 0;
    if (0 > fprintf (f, "%g", number))
		eise_io("FILE: unable to write REAL value.");
}

rt_public void file_pib(FILE *f, EIF_INTEGER number)
{
	/* Write `number' on `f' */

	errno = 0;
	if (1 != fwrite(&number, sizeof(EIF_INTEGER),1, f))
		eise_io("FILE: unable to write INTEGER value.");
}

rt_public void file_prb(FILE *f, EIF_REAL number)
{
	/* Write `number' on `f' */

	errno = 0;
    if (1 != fwrite(&number, sizeof(EIF_REAL),1, f))
		eise_io("FILE: unable to write REAL value.");
}

rt_public void file_ps(FILE *f, char *str, EIF_INTEGER len)
{
	/* Write string `str' on `f' */

	if (len == 0)		/* Empty string */
		return;			/* Nothing to be done */

	errno = 0;
#ifdef EIF_VMS
	getname (fileno(f), filnam);		/* DEBUG */
	/* on VMS, fwrite to a "record" (non-stream) file will cause an entire record to be written.  */
	/* Though we try to make stream files for text (see file_fopen), we may be writing to a	      */
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
		res = decc$record_write (f, str, len);
	    err = (errno == EVMSERR ? vaxc$errno : errno);
	    if (res < 0)
		eise_io("FILE: unable to write STRING object.");
	}
#else
	if (1 != fwrite(str, sizeof (char) * len, 1, f))
		eise_io("FILE: unable to write STRING object.");
#endif
}

rt_public void file_pc(FILE *f, char c)
{
	/* Write character `c' on `f' */

	errno = 0;
	if (EOF == putc(c, f))
		eise_io("FILE: unable to write CHARACTER value.");
}

rt_public void file_pd(FILE *f, EIF_DOUBLE val)
{
	/* Write double `val' onto `f' */

	errno = 0;
	if (0 > fprintf(f, "%.17g", val))
		eise_io("FILE: unable to write DOUBLE value.");
}

rt_public void file_pdb(FILE *f, EIF_DOUBLE val)
{
	/* Write double `val' onto `f' */

	errno = 0;
	if (1 != fwrite (&val, sizeof(double), 1, f))
		eise_io("FILE: unable to write DOUBLE value.");
}

rt_public void file_tnwl(FILE *f)
{
	/* Put new_line onto `f' */

	errno = 0;
	if (EOF == putc('\n', f))
		eise_io("FILE: unable to write new line.");
}

rt_public void file_append(FILE *f, FILE *other, EIF_INTEGER l)
        			/* Target file */
            		/* Source file */
              		/* Amount of bytes from `other' to be appended */
{
	/*	Append a copy of `otherile' to `f' */

	static char buffer[BUFSIZ];
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
		l -= amount;
		if (amount != fwrite(buffer, sizeof(char), amount, f))
			eise_io("FILE: unable to write appended file.");
	}
}

/*
 * I/O routines (input).
 */

rt_private void swallow_nl(FILE *f)
{
	/* Swallow next character if it is a new line */

		/* getc() cannot be used as it doesn't set the EOF flag */

	if (f != stdin)
		fscanf (f, "\n");
	else {
   		int c;

		errno = 0;
		c = getc(f);
		if (c == EOF && ferror(f))
			eise_io("FILE: error during reading the end of the file.");

		if (c != '\n' && EOF == ungetc(c, f))
			eise_io("FILE: End of file.");
	}
}
			
rt_public void file_tnil(FILE *f)
{
	/* Read upto next input line */

	int	c;

	errno = 0;
	while ((c = getc(f)) != '\n' && c != EOF)
		;
	if (c == EOF && ferror(f))
		eise_io("FILE: error during reading the end of the file.");
}

rt_public EIF_INTEGER file_gi(FILE *f)
{             
	/* Get an integer from `f' */

	EIF_INTEGER i;     

	errno = 0;
	if (0 > fscanf(f, "%d", &i))
		eise_io("FILE: unable to read INTEGER value.");
	swallow_nl(f);

	return i;
}

rt_public EIF_REAL file_gr(FILE *f)
{             
	/* Get a real from `f' */

	EIF_REAL r;     

	errno = 0;
	if (0 > fscanf(f, "%f", &r))
		eise_io("FILE: unable to read REAL value.");
	swallow_nl(f);

	return r;
}

rt_public EIF_DOUBLE file_gd(FILE *f)
{             
	/* Get a double from `f' */

	EIF_DOUBLE d;     

	errno = 0;
	if (0 > fscanf(f, "%lf", &d))
		eise_io("FILE: unable to read DOUBLE value.");
	swallow_nl(f);

	return d;
}
rt_public EIF_INTEGER file_gib(FILE *f)
{             
	/* Get an integer from `f' */

	EIF_INTEGER i;     

	errno = 0;
	if (1 != fread (&i, sizeof (EIF_INTEGER), 1, f))
		eise_io("FILE: unable to read INTEGER value.");

	return i;
}

rt_public EIF_REAL file_grb(FILE *f)
{             
	/* Get a real from `f' */

	EIF_REAL r;     

	errno = 0;
	if (1 != fread (&r, sizeof (EIF_REAL), 1, f))
		eise_io("FILE: unable to read REAL value.");

	return r;
}

rt_public EIF_DOUBLE file_gdb(FILE *f)
{             
	/* Get a double from `f' */

	EIF_DOUBLE d;     

	errno = 0;
	if (1 != fread (&d, sizeof(EIF_DOUBLE), 1, f))
		eise_io("FILE: unable to read DOUBLE value.");

	return d;
}

rt_public EIF_CHARACTER file_gc(FILE *f)
{
	/* Get a character from `f' */

	int c;

	errno = 0;
	c = getc(f);
	if (c == EOF && ferror(f))
		eise_io("FILE: unable to read CHARACTER value.");

	return (EIF_CHARACTER) c;
}

rt_public EIF_INTEGER file_gs(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
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
		*s++ = c;
		read++;
	}
	
	if (c == EOF && ferror(f))	/* An I/O error occurred */
		eise_io("FILE: unable to read current line.");					/* Raise exception */

	/* If we managed to get the whole string, return the number of characters
	 * read. Otherwise, return (bound - start + 1) to indicate an error
	 * condition.
	 */

	if (c == EOF || c == '\n')
#ifdef EIF_WINDOWS
		if ((read > 0) && (*(s-1) == '\r'))
			return read - 1;
		else
			return read;
#else
		return read;
#endif
	if (amount == -1)
		return (read + 1);

	return bound - start + 1;			/* Error condition */
}

rt_public EIF_INTEGER file_gss(FILE *f, char *s, EIF_INTEGER bound)
        		/* File stream descriptor */
        		/* Target buffer where read characters are written */
                  		/* Size of the target buffer */
{
	/* Read min (bound, remaining bytes in file) characters into `s' and
	 * return the number of characters read.
	 */

	EIF_INTEGER amount = bound;	/* Number of characters to be read */
	int c;					/* Last char read */
	
	while (amount-- > 0) {
		c = getc(f);
		if (c == EOF)
			break;
		*s++ = c;
	}

	if (c == EOF && ferror(f))	/* An I/O error occurred */
		eise_io("FILE: unable to read stream.");					/* Raise exception */

	return bound - amount - 1;	/* Number of characters read */
}

rt_public EIF_INTEGER file_gw(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start)
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
	int c;			/* Last char read */

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
		*s++ = c;
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

rt_public EIF_CHARACTER file_lh(FILE *f)
{
	/* Look ahead one character. If EOF, return 0 */

	int c;

	errno = 0;
	c = getc(f);
	if (c == EOF && ferror(f))
		eise_io("FILE: error when reading a character ahead.");

	if (c != EOF && EOF == ungetc(c, f))
		eise_io("FILE: error when reading a character ahead.");

	return (EIF_CHARACTER) (c == EOF ? (char) 0 : (char) c);
}

/*
 * Accessing/changing inode.
 */

rt_public void file_chown(char *name, int uid)
{
#ifdef HAS_CHOWN
	/* Change the owner of the file to `uid' */

	int gid;					/* Current Group ID */
	int status;					/* System call status */
	struct stat buf;			/* Buffer to get file statistics */
	
	file_stat(name, &buf);
	gid = buf.st_gid;					/* Get GID on file */

	for (;;) {
		errno = 0;						/* Reset error condition */
		status = chown(name, uid, gid);	/* Attempt change */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
#endif
}

rt_public void file_chgrp(char *name, int gid)
{
#ifdef HAS_CHOWN
	/* Change the group of the file to `gid' */

	int uid;					/* Current Owner ID */
	int status;					/* System call status */
	struct stat buf;			/* Buffer to get file statistics */
	
	file_stat(name, &buf);
	uid = buf.st_uid;					/* Get UID on file */

	for (;;) {
		errno = 0;						/* Reset error condition */
		status = chown(name, uid, gid);	/* Attempt change */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
#endif
}

rt_public void file_stat (char *path, struct stat *buf)
           				/* Path name */
                 		/* Structure to fill in */
{
	/* This is an encapsulation of the stat() system call. The routine either
	 * succeeds and returns or fails and raises the appropriate exception.
	 */

	int status;			/* System call status */
	
	for (;;) {
		errno = 0;						/* Reset error condition */
#ifdef HAS_LSTAT
	/* We do not use lstat anymore -- Fred */
		status = stat(path, buf);		/* Watch for symbolic links */
#else
		status = stat(path, buf);		/* Get file statistics */
#endif
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
#if defined EIF_VMS && defined _VMS_V6_SOURCE
	buf->st_uid &= 0x0000FFFF ;		/* VMS: mask out group id */
#endif
}

rt_public EIF_INTEGER file_info (struct stat *buf, int op)
{
	/* Perform the field dereferencing from the appropriate stat structure,
	 * which Eiffel cannot do directly.
	 */

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
		return (EIF_INTEGER) buf->st_size;
	case 7:	/* Last modification time on file */
		return (EIF_INTEGER) buf->st_mtime;
	case 8:	/* Last access made on file */
		return (EIF_INTEGER) buf->st_atime;
	case 9:	/* Last status change */
		return (EIF_INTEGER) buf->st_ctime;
	case 10: /* Number of links */
		return (EIF_INTEGER) buf->st_nlink;
	case 11: /* File type */
		return (EIF_INTEGER) (buf->st_mode & ~ST_MODE);
	case 12: /* Is file a directory */
		return (EIF_INTEGER) (buf->st_mode & S_IFDIR);
	case 13: /* Is file a regular (plain) one */
		if (buf->st_mode & S_IFREG || 0 == (buf->st_mode & ~ST_MODE))
			return (EIF_INTEGER) S_IFREG;
		return (EIF_INTEGER) 0;
	case 14: /* Is file a device */
		if (buf->st_mode & S_IFCHR)
			return (EIF_INTEGER) S_IFCHR;
		if (buf->st_mode & S_IFBLK)
			return (EIF_INTEGER) S_IFBLK;
		return (EIF_INTEGER) 0;
	case 15: /* Is file a character device */
		return (EIF_INTEGER) (buf->st_mode & S_IFCHR);
	case 16: /* Is file a block device */
		return (EIF_INTEGER) (buf->st_mode & S_IFBLK);
	case 17: /* Is file a FIFO */
		return (EIF_INTEGER) (buf->st_mode & S_IFIFO);
	case 18: /* Is file a symbolic link */
		return (EIF_INTEGER) (buf->st_mode & S_IFLNK);
	case 19: /* Is file a socket */
		return (EIF_INTEGER) (buf->st_mode & S_IFSOCK);
	default:
		eif_panic(MTC "illegal stat request");
    }
	/* NOTREACHED */
	return 0; /* to avoid a warning */
}

rt_public EIF_BOOLEAN file_eaccess(struct stat *buf, int op)
{
	/* Check file permissions using effective UID and effective GID. The
	 * current permission mode is held in the st_mode field of the stat()
	 * buffer structure `buf'.
	 */

	int mode = buf->st_mode & ST_MODE;	/* Current mode */
#if defined HAS_GETEUID || defined HAS_GETUID
	int uid = buf->st_uid;				/* File owner */
	int gid = buf->st_gid;				/* File group */
#endif
#ifdef HAS_GETEUID
	int euid, egid;						/* Effective user and group */
#endif

    switch (op) {
	case 0: /* Is file readable */
#if defined EIF_WIN32 || defined EIF_OS2
	return (EIF_BOOLEAN)((mode && S_IREAD) ? '\01' : '\0');
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
#endif
			return (EIF_BOOLEAN) ((mode & S_IROTH) ? '\01' : '\0');
	case 1: /* Is file writable */
#if defined EIF_WIN32 || defined EIF_OS2
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
#endif
			return (EIF_BOOLEAN) ((mode & S_IWOTH) ? '\01' : '\0');
	case 2: /* Is file executable */
#if defined EIF_WIN32 || defined EIF_OS2
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
#endif
			return (EIF_BOOLEAN) ((mode & S_IXOTH) ? '\01' : '\0');
	case 3: /* Is file setuid */
#if defined EIF_WIN32 || defined EIF_OS2
		return (EIF_BOOLEAN) ('\0');
#else
		return (EIF_BOOLEAN) ((mode & S_ISUID) ? '\01' : '\0');
#endif
	case 4: /* Is file setgid */
#if defined EIF_WIN32 || defined EIF_OS2
		return (EIF_BOOLEAN) ('\0');
#else
		return (EIF_BOOLEAN) ((mode & S_ISGID) ? '\01' : '\0');
#endif
	case 5: /* Is file sticky */
#if defined EIF_WIN32 || defined EIF_OS2 || defined VXWORKS
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

rt_public EIF_BOOLEAN file_access(char *name, EIF_INTEGER op)
{
	/* Check whether access permission 'op' are possible on file 'name' using
	 * real UID and real GID. This is probably only useful to setuid or setgid
	 * programs.
	 */

#ifdef VXWORKS
	return ('\01');
#else

	switch (op) {
	case 0: /* Does file exist? */
		return (EIF_BOOLEAN) ((-1 != access(name, F_OK)) ? '\01' : '\0');
	case 1: /* Test for search permission */
		return (EIF_BOOLEAN) ((-1 != access(name, X_OK)) ? '\01' : '\0');
	case 2: /* Test for write permission */
		return (EIF_BOOLEAN) ((-1 != access(name, W_OK)) ? '\01' : '\0');
	case 3: /* Test for read permission */
		return (EIF_BOOLEAN) ((-1 != access(name, R_OK)) ? '\01' : '\0');
	default:
		eif_panic(MTC "illegal access request");
		return ('\0');	/* NOT REACHED */
	}
#endif
}

rt_public EIF_BOOLEAN file_exists(char *name)
{
	/* Test whether file exists or not by checking the return from the stat()
	 * system call, hence letting the kernel run all the tests. Return true
	 * if the file exists.
	 * Stat is called directly, because failure is allowed here obviously.
	 */

	int status;					/* System call status */
	struct stat buf;			/* Buffer to get file statistics */
	

	status = stat(name, &buf);	/* Attempt to stat file */

	return (EIF_BOOLEAN) (status == -1 ? '\0' : '\01');
}

/*
 * Interfacing with file system.
 */

rt_public void file_rename(char *from, char *to)
{
	/* Rename file `from' into `to' */

	int status;			/* System call status */
	
	for (;;) {
#if defined EIF_WINDOWS || defined EIF_OS2
		if (file_exists (to))			/* To have the same behavior as Unix */
			remove (to);
#endif
		errno = 0;						/* Reset error condition */
		status = rename(from, to);		/* Rename file or directory */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
}

rt_public void file_link(char *from, char *to)
{
#ifdef HAS_LINK
	/* Link file `from' into `to' */

	int status;			/* System call status */
	
	for (;;) {
		errno = 0;						/* Reset error condition */
		status = link(from, to);		/* Make both files the same */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
#endif
}

rt_public void file_mkdir(char *path)
{
	/* Create directory `path' */

	int status;			/* System call status */
#ifdef EIF_VMS
	char vms_path [PATH_MAX +1];
#ifdef EIF_VMS_V6_ONLY
	char duplicate[PATH_MAX];
	strcpy(duplicate,path);
#endif
#endif
	
	for (;;) {
		errno = 0;			/* Reset error condition */
#ifdef EIF_OS2 
		status = mkdir(path);		/* Create directory `path' */
#elif defined EIF_WIN32 || defined VXWORKS
		status = mkdir(path);		/* Create directory `path' */ /* %%ss above line added */
#else
		status = mkdir(path, 0777);	/* Create directory `path' */
#endif
		if (status == -1) {		/* An error occurred */
			if (errno == EINTR)	/* Interrupted by signal */
				continue;	/* Re-issue system call */
			else
				esys();		/* Raise exception */
		}

#ifdef EIF_VMS
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
#endif	/* vms */
		break;
	}
}

rt_public void file_unlink(char *name)
{
	/* Delete file or directory `name' */

	struct stat buf;				/* File statistics */
	int status;						/* Status from system call */

	file_stat(name, &buf);				/* Side effect: ensure file exists */

	for (;;) {
		errno = 0;						/* Reset error condition */
		if (buf.st_mode & S_IFDIR)		/* Directory */
			status = rmdir(name);		/* Remove only if empty */
		else
			status = unlink(name);		/* Not a directory */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
}

rt_public void file_touch(char *name)
{
	/* Touch file `name' by setting both access and modification time to the
	 * current time stamp. This external function exists only because there
	 * is no way within UNIX_FILE to get the current time stamp--RAM. Otherwise,
	 * we could simply call file_utime.
	 */

    file_utime(name, time((Time_t *) 0), 2);
}

/*
 * Inode manipulations.
 */

rt_public void file_utime(char *name, time_t stamp, int how)
           		/* File name */
             	/* Time stamp */
        		/* How should the time stamp be applied */
{
	/* Modify the modification and/or the access time stored in the file's
	 * inode. The 'how' parameter tells which attributes should be set.
	 */

	struct utimbuf tp;	/* Time array */
	struct stat buf;	/* File statistics */
	int status;			/* System call status */

	if (how < 2) {				/* Need to fetch time from inode */
		file_stat(name, &buf);
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
	
	for (;;) {
		errno = 0;						/* Reset error condition */
		status = utime(name, &tp);		/* Attempt time stamp change */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
}

rt_public void file_perm(char *name, char *who, char *what, int flag)
           		/* The file name */
          		/* User (u), group (g) or other (o) */
           		/* Which permission to change: rwx, s (for ug) or t (for o) */
         		/* Add (1) or remove (0) permissions */
{

/* FIXME: allow several combinations in `who' */
/* + add `a' ? */

	/* Change permissions of file `name', using an interface like chmod(1).
	 * The flag is true if permissions are to be added, 0 to remove them.
	 */

	int fmode;					/* File mode to be altered */
	struct stat buf;			/* File statistics */

	file_stat(name, &buf);
	fmode = (int) buf.st_mode;	/* Fetch current file mode */

	switch (*who) {
	case 'u':
		while (*what)
			switch (*what++) {
#if defined EIF_WIN32
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
#if defined EIF_WIN32 || defined EIF_OS2
#else
				if (flag) fmode |= S_ISGID; else fmode &= ~S_ISGID;
#endif
				break;
			case 'r':
				if (flag) fmode |= S_IRGRP; else fmode &= ~S_IRGRP;
				break;
			case 'w':
				if (flag) fmode |= S_IWGRP; else fmode &= ~S_IWGRP;
				break;
			case 'x':
				if (flag) fmode |= S_IXGRP; else fmode &= ~S_IXGRP;
				break;
			default:
				eraise("invalid group permission", EN_EXT);
			}
		break;
	case 'o':
		while (*what)
			switch (*what++) {
			case 't':
#if defined EIF_WIN32 || defined EIF_OS2 || defined VXWORKS
#else
				if (flag) fmode |= S_ISVTX; else fmode &= ~S_ISVTX;
#endif
				break;
			case 'r':
				if (flag) fmode |= S_IROTH; else fmode &= ~S_IROTH;
				break;
			case 'w':
				if (flag) fmode |= S_IWOTH; else fmode &= ~S_IWOTH;
				break;
			case 'x':
				if (flag) fmode |= S_IXOTH; else fmode &= ~S_IXOTH;
				break;
			default:
				eraise("invalid other permission", EN_EXT);
			}
		break;
	default:
		eraise("invalid permission target", EN_EXT);
	}
#ifndef VXWORKS
    file_chmod(name, fmode);
#endif
}

#ifndef VXWORKS
rt_public void file_chmod(char *path, int mode)
{
	/* Change permission mode on file `path' */

	int status;				/* Status from system call */

	for (;;) {
		errno = 0;						/* Reset error condition */
		status = chmod(path, mode);		/* Change permissions on file */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
}
#endif

/*
 * File cursor management.
 */

rt_public EIF_INTEGER file_tell(FILE *f)
{
	/* Current position within file */

	if (f == (FILE *) 0)
		eraise("invalid file pointer", EN_EXT);
	
	return (EIF_INTEGER) ftell(f);
}

rt_public void file_go(FILE *f, EIF_INTEGER pos)
{
	/* Go to absolute position 'pos' counted from start */

	errno = 0;							/* Reset error condition */
	if (0 != fseek(f, pos, FS_START))	/* Go there */
		esys();							/* Problem occurred, raise exception */
	clearerr(f);						/* Clear error status and EOF */
}

rt_public void file_recede(FILE *f, EIF_INTEGER pos)
{
	/* Go to absolute position 'pos' counted from end */

	errno = 0;							/* Reset error condition */
	if (0 != fseek(f, -pos, FS_END))	/* Go there */
		esys();							/* Problem occurred, raise exception */
	clearerr(f);						/* Clear error status and EOF */
}

rt_public void file_move(FILE *f, EIF_INTEGER pos)
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

	return (EIF_INTEGER) sizeof(struct stat);
}

rt_public EIF_BOOLEAN file_creatable(char *path, EIF_INTEGER length)
{
	/* Check whether the file `path' may be created: we need write permissions
	 * in the parent directory and there must not be any file bearing that name
	 * with no write permissions...
	     VMS: **TBS** (on VMS, there can be an unwritable file because a new version is created)
	 */

	struct stat buf;			/* Buffer to get parent directory statistics */
	char *temp = NULL;
	char *ptr;

#ifdef EIF_VMS
	/* You can't do a stat() on a directory under VMS
	 * Just return true for now, fix this later!
	 */
	return (EIF_BOOLEAN) '\1';

/* Manu: 09/10/2001: commented out non-executed code */
/*	ptr = rindex(temp, ']') + 1;	locate the end of the dir path */
/*	if (ptr != (char *) 0)
		*ptr = '\0';		now truncate the file name */
/*	else
	should use a function like dir_current() here? */
/*		strcpy (temp, "[]"); */
#else	/* vms */

	temp = (char *) eif_malloc (length + 1);
	strcpy (temp, path);
#if defined EIF_WINDOWS || defined EIF_OS2
	ptr = rindex(temp, '\\');
#else
	ptr = rindex(temp, '/');
#endif
	if (ptr != (char *) 0) {
		*ptr = '\0';
#if defined EIF_WINDOWS || defined EIF_OS2
		if ((ptr == temp) || (*(ptr -1) == ':'))
				/* path is of the form a:\bbb or \bbb, parent is a:\ or \ */
			strcat (ptr, "\\");
#endif
		}
	else
		strcpy (temp, ".");

		/* Does the parent exist? */
	if (!file_exists(temp)) {
		eif_free (temp);
		return (EIF_BOOLEAN) '\0';
	}

	file_stat(temp, &buf);
	eif_free (temp);

	if (buf.st_mode & S_IFDIR)	/* Is parent a directory? */
		if (file_eaccess(&buf, 1)) {	/* Check for write permissions */
				/* Check if a non writable file `path' exists */
			if (file_exists(path)) {
				file_stat(path, &buf);
				if (buf.st_mode & S_IFDIR)
				  	return (EIF_BOOLEAN) '\0';	/* is a directory */
				return (file_eaccess(&buf, 1)); /* Check for write permissions to re create it */
			}

			return (EIF_BOOLEAN) '\01';
		}

	return (EIF_BOOLEAN) '\0';
#endif	/* vms */
}

rt_public EIF_INTEGER file_fd(FILE *f)
{
	/* Return the associated file descriptor */

	if (f == (FILE *) 0)
		eraise("invalid file pointer", EN_EXT);

	return (EIF_INTEGER) fileno(f);	/* Might be an int */
}

rt_public char *file_owner(int uid)
{
	/* Return the Eiffel string filled in with the name associated with 'uid'
	 * if found in /etc/passwd. Otherwise, return fill it in with the numeric
	 * value.
	 */

	char str[NAME_MAX];
#ifdef HAS_GETPWUID
	struct passwd *pp; /* %%ss moved frm above */

	pp = getpwuid(uid);
	if (pp == (struct passwd *) 0)
		sprintf(str, "%d", uid);		/* Not available: use UID */
	else
		strcpy(str, pp->pw_name);		/* Available: fetch login name */
#else
	sprintf(str, "%d", uid);			/* Not available: use UID */
#endif
	
	return makestr(str, strlen(str));
}

rt_public char *file_group(int gid)
{
	/* Return the Eiffel string filled in with the name associated with 'gid'
	 * if found in /etc/group. Otherwise, return fill it in with the numeric
	 * value.
	 */

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

rt_public EIF_BOOLEAN eif_group_in_list(int gid)
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

#ifndef HAS_RENAME
rt_public int rename(char *from, char *to)
		/* Orginal name */
		/* Target name */
{

	/* Emulates the system call rename() */

	(void) unlink(to);
	if (-1 == link(from, to))
		return -1;
	if (-1 == unlink(from))
		return -1;
}
#endif

#ifndef HAS_RMDIR
rt_public int rmdir(const char *path)
{
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
#endif	/* vms */
}
#endif

#ifndef HAS_MKDIR
rt_public int mkdir(char *path)
{
	/* Emulates the mkdir() system call */

	char cmd[BUFSIZ];
	int status;			/* Status from the shell */

	errno = 0;			/* In case system() cannot fork */
	sprintf(cmd, "/bin/mkdir %s", path);
	status = system(cmd);
	if (errno != 0 || status != 0)
		return -1;
	
	return 0;
}
#endif

#ifndef HAS_UTIME
rt_private int utime(char *path, struct utimbuf *times)
{
	/* Emulation of utime */
#ifdef EIF_VMS
	return -1;
#elif defined EIF_OS2
	return -1;
#else
	...
#endif  /* platform */

}
#endif  /* HAS_UTIME */


#ifndef HAS_UNLINK
#ifndef unlink

int unlink(char *path)
{
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
}

#endif		/* unlink */
#endif		/* HAS_UNLINK */
