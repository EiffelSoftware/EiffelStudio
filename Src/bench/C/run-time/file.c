/*

 ######     #    #       ######           ####
 #          #    #       #               #    #
 #####      #    #       #####           #
 #          #    #       #        ###    #
 #          #    #       #        ###    #    #
 #          #    ######  ######   ###     ####

	Externals for class FILE

*/

#include "config.h"
#include "portable.h"
#include "except.h"
#include "plug.h"

#include <stdio.h>
#include <errno.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <pwd.h>
#include <grp.h>

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

#include "file.h"

#define FS_START	0			/* Beginning of file for `fseek' */
#define FS_CUR		1			/* Current position for `fseek' */
#define FS_END		2			/* End of file for `fseek' */
#define ST_MODE		0x0fff		/* Keep only permission mode */
#define NAME_MAX	10			/* Maximum length for user/group name */

private char *file_fopen();		/* Open file */
private char *file_fdopen();	/* Open file descriptor (UNIX specific) */
private char *file_freopen();	/* Reopen file */
private void swallow_nl();		/* Swallow next character if new line */

extern int errno;				/* Kernel error report */
extern int esys();				/* Raise 'Operating system error' exception */
extern int eio();				/* Raise 'I/O error' exception */

/*
 * Opening a file.
 */

public fnptr file_open(name, how)
char *name;
int how;
{
	/* Open file `name' with the corresponding type 'how'. */

	char *type;

	switch (how) {					/* Opening mode code */
	case 0: type = "r"; break;		/* Open for reading */
	case 1: type = "w"; break;		/* Truncate/create for writing */
	case 2: type = "a"; break;		/* Open for writing at end of file */
	case 3: type = "r+"; break;		/* Open for reading & writing */
	case 4: type = "w+"; break;		/* Truncate/create for reading & writing */
	case 5: type = "a+"; break;		/* Reading anywhere, writing at the end */
	default: type = "r";
	}

	return (fnptr) file_fopen(name, type);
}

public fnptr file_dopen(fd, how)
int fd;
int how;
{
	/* Open file `fd' with the corresponding type 'how'. */

	char *type;

	switch (how) {					/* Opening mode code */
	case 0: type = "r"; break;		/* Open for reading */
	case 1: type = "w"; break;		/* Truncate/create for writing */
	case 2: type = "a"; break;		/* Open for writing at end of file */
	case 3: type = "r+"; break;		/* Open for reading & writing */
	case 4: type = "w+"; break;		/* UNUSED: does not make any sense--RAM */
	case 5: type = "a+"; break;		/* Reading anywhere, writing at the end */
	default: type = "r";
	}

	return (fnptr) file_fdopen(fd, type);
}

public fnptr file_reopen(name, how, old)
char *name;
int how;
FILE *old;
{
	/* Reopen file `name' with the corresponding type 'how' and substitute that
	 * to the old stream described by `old'. This is useful to redirect 'stdout'
	 * to another place, for instance.
	 */

	char *type;

	switch (how) {					/* Opening mode code */
	case 0: type = "r"; break;		/* Open for reading */
	case 1: type = "w"; break;		/* Truncate/create for writing */
	case 2: type = "a"; break;		/* Open for writing at end of file */
	case 3: type = "r+"; break;		/* Open for reading & writing */
	case 4: type = "w+"; break;		/* Truncate/create for reading & writing */
	case 5: type = "a+"; break;		/* Reading anywhere, writing at the end */
	default: type = "r";
	}

	return (fnptr) file_freopen(name, type, old);
}

private char *file_fopen(name, type)
char *name;
char *type;
{
	/* Issue the fopen() call and raise exception if it fails, or return the
	 * file pointer when sucessful.
	 */

	FILE *fp;

	errno = 0;
	fp = (FILE *) fopen(name, type);
	if (fp == (FILE *) 0)
		esys();				/* Open failed, raise exception */

	return (char *) fp;
}

private char *file_fdopen(fd, type)
int fd;
char *type;
{
	/* Issue the fdopen() call and raise exception if it fails, or return the
	 * file pointer when sucessful.
	 */

	FILE *fp;

	errno = 0;
	fp = (FILE *) fdopen(fd, type);
	if (fp == (FILE *) 0)
		esys();				/* Open failed, raise exception */

	return (char *) fp;
}

private char *file_freopen(name, type, stream)
char *name;
char *type;
FILE *stream;
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

public void file_close(fp)
FILE *fp;
{
	/* Close the file */

	errno = 0;
	if (0 != fclose(fp))
		esys();				/* Close failed, raise exception */
}

public void file_flush(fp)
FILE *fp;
{
	/* Flush data held in stdio buffer */

	errno = 0;
	if (0 != fflush(fp))
		esys();				/* Flush failed, raise exception */
}

public char file_feof(fp)
FILE *fp;      
{
	return (char) (feof(fp) != 0);	/* End of file? */
}            

/*
 * I/O routines (output).
 */

public void file_pi(f, number)
FILE *f;
int	number;
{
	/* Write `number' on `f' */

	errno = 0;
	if (0 > fprintf(f, "%d", number))
		eio();
}

public void file_pr(f, number)
FILE *f;
float number;
{
	/* Write `number' on `f' */

	errno = 0;
    if (0 > fprintf (f, "%g", number))
		eio();
}

public void file_ps(f, str, len)
FILE *f;
char *str;
int len;
{
	/* Write string `str' on `f' */

	if (len == 0)		/* Empty string */
		return;			/* Nothing to be done */

	errno = 0;
	if (1 != fwrite(str, len, 1, f))
		eio();
}

public void file_pc(f, c)
FILE *f;
char c;
{
	/* Write character `c' on `f' */

	errno = 0;
	if (EOF == putc(c, f))
		eio();
}

public void file_pd(f, val)
FILE *f;
double *val;
{
	/* Write double `val' onto `f' */

	errno = 0;
	if (0 > fprintf(f, "%.17g", val))
		eio();
}

public void file_tnwl(f)
FILE *f;
{
	/* Put new_line onto `f' */

	errno = 0;
	if (EOF == putc('\n', f))
		eio();
}

public void file_append(f, other, l)
FILE *f;			/* Target file */
FILE *other;		/* Source file */
int l;				/* Amount of bytes from `other' to be appended */
{
	/*	Append a copy of `otherile' to `f' */

	static char buffer[BUFSIZ];
	int amount;

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
			eio();
		l -= amount;
		if (amount != fwrite(buffer, sizeof(char), amount, f))
			eio();
	}
}

/*
 * I/O routines (input).
 */

private void swallow_nl(f)
FILE *f;
{
	/* Swallow next character if it is a new line */

	int c;

	errno = 0;
	c = getc(f);
	if (c == EOF && ferror(f))
		eio();
	if (c != '\n' && EOF == ungetc(c, f))
		eio();
}
			
public void file_tnil(f)
FILE *f;
{
	/* Read upto next input line */

	int	c;

	errno = 0;
	while ((c = getc(f)) != '\n' && c != EOF)
		;
	if (c == EOF && ferror(f))
		eio();
}

public long file_gi(f) 
FILE *f;     
{             
	/* Get an integer from `f' */

	long i;     

	errno = 0;
	if (0 > fscanf(f, "%ld", &i))
		eio();
	swallow_nl(f);

	return i;
}

public float file_gr(f) 
FILE *f;     
{             
	/* Get a real from `f' */

	float r;     

	errno = 0;
	if (0 > fscanf(f, "%f", &r))
		eio();
	swallow_nl(f);

	return r;
}

public double file_gd(f) 
FILE *f;     
{             
	/* Get a double from `f' */

	double d;     

	errno = 0;
	if (0 > fscanf(f, "%f", &d))
		eio();
	swallow_nl(f);

	return d;
}

public char	file_gc(f)
FILE *f;
{
	/* Get a character from `f' */

	int c;

	errno = 0;
	c = getc(f);
	if (c == EOF && ferror(f))
		eio();

	return (char) c;
}

public long file_gs(f, s, bound, start)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
long bound;		/* Size of the target buffer */
long start;		/* Amount of characters already held in buffer */
{
	/* Get a string from `f' and fill it into `s' (at most `bound' characters),
	 * with `start' being the amount of bytes already stored within s. This
	 * means we really have to read (bound - start) characters.
	 */

	long amount;	/* Amount of bytes to be read */
	int c;			/* Last char read */

	amount = bound - start;		/* Characters to be read */
	s += start;					/* Where read characters are written */
	errno = 0;					/* No error, a priori */

	while (amount-- > 0) {
		if ((c = getc(f)) == '\n' || c == EOF)
			break;
		*s++ = c;
	}
	
	if (c == EOF && ferror(f))	/* An I/O error occurred */
		eio();					/* Raise exception */

	/* If we managed to get the whole string, return the number of characters
	 * read. Otherwise, return (bound - start + 1) to indicate an error
	 * condition.
	 */
	
	if (++amount == 0 || c == EOF || c == '\n')
		return bound - start - amount;	/* Number of characters read */

	return bound - start + 1;			/* Error condition */
}

public long file_gss(f, s, bound)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
long bound;		/* Size of the target buffer */
{
	/* Read min (bound, remaining bytes in file) characters into `s' and
	 * return the number of characters read.
	 */

	long amount = bound;	/* Number of characters to be read */
	int c;					/* Last char read */
	
	while (amount-- > 0) {
		c = getc(f);
		if (c == EOF)
			break;
		*s++ = c;
	}

	if (c == EOF && ferror(f))	/* An I/O error occurred */
		eio();					/* Raise exception */

	return bound - amount - 1;	/* Number of characters read */
}

public long file_gw(f, s, bound, start)
FILE *f;		/* File stream descriptor */
char *s;		/* Target buffer where read characters are written */
long bound;		/* Size of the target buffer */
long start;		/* Amount of characters already held in buffer */
{
	/* Get a word from `f' and fill it into `s' (at most `bound' characters),
	 * with `start' being the amount of bytes already stored within s. This
	 * means we really have to read (bound - start) characters. Any leading
	 * spaces are skipped.
	 */

	long amount;	/* Amount of bytes to be read */
	int c;			/* Last char read */

	amount = bound - start;		/* Characters to be read */
	s += start;					/* Where read characters are written */
	errno = 0;					/* No error, a priori */

	if (start == 0)	{			/* First call */
		while ((c = getc(f)) != EOF)
			if (!isspace(c))
				break;
		if (c == EOF && ferror(f))	/* An I/O error occurred */
			eio();					/* Raise exception */
		if (c == EOF)
			return 0;				/* Reached EOF before word */
		else if (EOF == ungetc(c, f))
			eio();
	}

	while (amount-- > 0) {
		c = getc(f);
		if (c != EOF && isspace(c)) {
			if (EOF == ungetc(c, f))
				eio();
			break;
		}
		*s++ = c;
	}
	
	if (c == EOF && ferror(f))	/* An I/O error occurred */
		eio();					/* Raise exception */

	/* If we managed to get the whole string, return the number of characters
	 * read. Otherwise, return (bound - start + 1) to indicate an error
	 * condition.
	 */
	
	if (c == EOF || isspace(c))
		return bound - start - amount - 1;	/* Number of characters read */

	return bound - start + 1;			/* Error condition */
}

public char file_lh(f)
FILE *f;
{
	/* Look ahead one character. If EOF, return 0 */

	int c;

	errno = 0;
	c = getc(f);
	if (c == EOF && ferror(f))
		eio();

	if (c != EOF && EOF == ungetc(c, f))
		eio();

	return c == EOF ? (char) 0 : (char) c;
}

/*
 * Accessing/changing inode.
 */

public void file_chown(name, uid)
char *name;
int uid;
{
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
}

public void file_chgrp(name, gid)
char *name;
int gid;
{
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
}

public void file_stat (path, buf)
char *path;				/* Path name */
struct stat *buf;		/* Structure to fill in */
{
	/* This is an encapsulation of the stat() system call. The routine either
	 * succeeds and returns or fails and raises the appropriate exception.
	 */

	int status;			/* System call status */
	
	for (;;) {
		errno = 0;						/* Reset error condition */
#ifdef HAS_LSTAT
		status = lstat(path, buf);		/* Watch for symbolic links */
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
}

public long file_info (buf, op)
struct stat *buf;
int op;
{
	/* Perform the field dereferencing from the appropriate stat structure,
	 * which Eiffel cannot do directly.
	 */

    switch (op) {
	case 0:	/* File permission mode */
		return (long) (buf->st_mode & ST_MODE);
	case 1:	/* Inode number */
		return (long) buf->st_ino;
	case 2:	/* Device inode resides on */
		return (long) buf->st_dev;
	case 3:	/* Device type */
		return (long) buf->st_rdev;
	case 4:	/* UID of file */
		return (long) buf->st_uid;
	case 5:	/* GID of file */
		return (long) buf->st_gid;
	case 6:	/* Size of file, in bytes */
		return (long) buf->st_size;
	case 7:	/* Last modification time on file */
		return (long) buf->st_mtime;
	case 8:	/* Last access made on file */
		return (long) buf->st_atime;
	case 9:	/* Last status change */
		return (long) buf->st_ctime;
	case 10: /* Number of links */
		return (long) buf->st_nlink;
	case 11: /* File type */
		return (long) (buf->st_mode & ~ST_MODE);
	case 12: /* Is file a directory */
		return (long) (buf->st_mode & S_IFDIR);
	case 13: /* Is file a regular (plain) one */
		if (buf->st_mode & S_IFREG || 0 == (buf->st_mode & ~ST_MODE))
			return (long) S_IFREG;
		return (long) 0;
	case 14: /* Is file a device */
		if (buf->st_mode & S_IFCHR)
			return (long) S_IFCHR;
		if (buf->st_mode & S_IFBLK)
			return (long) S_IFBLK;
		return 0;
	case 15: /* Is file a character device */
		return (long) (buf->st_mode & S_IFCHR);
	case 16: /* Is file a block device */
		return (long) (buf->st_mode & S_IFBLK);
	case 17: /* Is file a FIFO */
		return (long) (buf->st_mode & S_IFIFO);
	case 18: /* Is file a symbolic link */
		return (long) (buf->st_mode & S_IFLNK);
	case 19: /* Is file a socket */
		return (long) (buf->st_mode & S_IFSOCK);
	default:
		panic("illegal stat request");
    }
}

public char file_eaccess(buf, op)
struct stat *buf;
int op;
{
	/* Check file permissions using effective UID and effective GID. The
	 * current permission mode is held in the st_mode field of the stat()
	 * buffer structure `buf'.
	 */

	int mode = buf->st_mode & ST_MODE;	/* Current mode */
	int uid = buf->st_uid;				/* File owner */
	int gid = buf->st_gid;				/* File group */

    switch (op) {
	case 0: /* Is file readable */
		if (uid == geteuid())
			return (mode & S_IRUSR) ? '\01' : '\0';
		else if (gid = getegid())
			return (mode & S_IRGRP) ? '\01' : '\0';
		else
			return (mode & S_IROTH) ? '\01' : '\0';
	case 1: /* Is file writable */
		if (uid == geteuid())
			return (mode & S_IWUSR) ? '\01' : '\0';
		else if (gid = getegid())
			return (mode & S_IWGRP) ? '\01' : '\0';
		else
			return (mode & S_IWOTH) ? '\01' : '\0';
	case 2: /* Is file executable */
		if (uid == geteuid())
			return (mode & S_IXUSR) ? '\01' : '\0';
		else if (gid = getegid())
			return (mode & S_IXGRP) ? '\01' : '\0';
		else
			return (mode & S_IXOTH) ? '\01' : '\0';
	case 3: /* Is file setuid */
		return (mode & S_ISUID) ? '\01' : '\0';
	case 4: /* Is file setgid */
		return (mode & S_ISGID) ? '\01' : '\0';
	case 5: /* Is file sticky */
		return (mode & S_ISVTX) ? '\01' : '\0';
	case 6: /* Is file owned by effective UID */
		return (uid == geteuid()) ? '\01' : '\0';
	case 7: /* Is file owned by real UID */
		return (uid == getuid()) ? '\01' : '\0';
	default:
		panic("illegal access request");
	}
}

public char file_access(name, op)
{
	/* Check whether access permission 'op' are possible on file 'name' using
	 * real UID and real GID. This is probably only useful to setuid or setgid
	 * programs.
	 */

	switch (op) {
	case 0: /* Does file exist? */
		return (-1 != access(name, F_OK)) ? '\01' : '\0';
	case 1: /* Test for search permission */
		return (-1 != access(name, X_OK)) ? '\01' : '\0';
	case 2: /* Test for write permission */
		return (-1 != access(name, W_OK)) ? '\01' : '\0';
	case 3: /* Test for read permission */
		return (-1 != access(name, R_OK)) ? '\01' : '\0';
	default:
		panic("illegal access request");
	}
}

public char file_exists(name)
char *name;
{
	/* Test whether file exists or not by checking the return from the stat()
	 * system call, hence letting the kernel run all the tests. Return true
	 * if the file exists.
	 * Stat is called directly, because failure is allowed here obviously.
	 */

	int status;					/* System call status */
	struct stat buf;			/* Buffer to get file statistics */
	

	status = stat(name, &buf);	/* Attempt to stat file */

	return status == -1 ? '\0' : '\01';
}

/*
 * Interfacing with file system.
 */

public void file_rename(from, to)
char *from;
char *to;
{
	/* Rename file `from' into `to' */

	int status;			/* System call status */
	
	for (;;) {
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

public void file_link(from, to)
char *from;
char *to;
{
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
}

public void file_mkdir(path)
char *path;
{
	/* Create directory `path' */

	int status;			/* System call status */
	
	for (;;) {
		errno = 0;						/* Reset error condition */
		status = mkdir(path, 0777);		/* Create directory `path' */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
}

public void file_unlink(name)
char *name;
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

public void file_touch(name)
char *name;
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

public void file_utime(name, stamp, how)
char *name;		/* File name */
Time_t stamp;	/* Time stamp */
int how;		/* How should the time stamp be applied */
{
	/* Modify the modification and/or the access time stored in the file's
	 * inode. The 'how' parameter tells which attributes should be set.
	 */

	Time_t tp[2];		/* Time array (0 = access time, 1 = modif time) */
	struct stat buf;	/* File statistics */
	int status;			/* System call status */

	if (how < 2) {				/* Need to fetch time from inode */
		file_stat(name, &buf);
		switch (how) {
		case 0:					/* Change only access time */
			tp[0] = stamp;
			tp[1] = buf.st_mtime;
			break;
		case 1:					/* Change only modification time */
			tp[0] = buf.st_atime;
			tp[1] = stamp;
			break;
		}
	} else
		tp[0] = tp[1] = stamp;	/* Change both access and modification times */
	
	for (;;) {
		errno = 0;						/* Reset error condition */
		status = utime(name, tp);		/* Attempt time stamp change */
		if (status == -1) {				/* An error occurred */
			if (errno == EINTR)			/* Interrupted by signal */
				continue;				/* Re-issue system call */
			else
				esys();					/* Raise exception */
		}
		break;
	}
}

public void file_perm(name, who, what, flag)
char *name;		/* The file name */
char *who;		/* User (u), group (g) or other (o) */
char *what;		/* Which permission to change: rwx, s (for ug) or t (for o) */
int flag;		/* Add (1) or remove (0) permissions */
{
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
			default:
				eraise("invalid user permission", EN_EXT);
			}
		break;
	case 'g':
		while (*what)
			switch (*what++) {
			case 's':
				if (flag) fmode |= S_ISGID; else fmode &= ~S_ISGID;
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
				if (flag) fmode |= S_ISVTX; else fmode &= ~S_ISVTX;
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

    file_chmod(name, fmode);
}

public void file_chmod(path, mode)
char *path;
int mode;
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

/*
 * File cursor management.
 */

public long file_tell(f)
FILE *f;
{
	/* Current position within file */

	if (f == (FILE *) 0)
		eraise("invalid file pointer", EN_EXT);
	
	return ftell(f);
}

public void file_go(f, pos)
FILE *f;
int pos;
{
	/* Go to absolute position 'pos' counted from start */

	errno = 0;							/* Reset error condition */
	if (0 != fseek(f, pos, FS_START))	/* Go there */
		esys();							/* Problem occurred, raise exception */
	clearerr(f);						/* Clear error status and EOF */
}

public void file_recede(f, pos)
FILE *f;
int pos;
{
	/* Go to absolute position 'pos' counted from end */

	errno = 0;							/* Reset error condition */
	if (0 != fseek(f, -pos, FS_END))	/* Go there */
		esys();							/* Problem occurred, raise exception */
	clearerr(f);						/* Clear error status and EOF */
}

public void file_move(f, pos)
FILE *f;
int pos;
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

public long stat_size()
{
	/* Size of the stat structure. This is used by the Eiffel side to create
	 * the area (special object) which will play the role of a stat buffer
	 * structure.
	 */

	return (long) sizeof(struct stat);
}

public char file_creatable(path)
char *path;
{
	/* Check whether the file `path' may be created: we need write permissions
	 * in the parent directory and there must not be any file bearing that name
	 * with no write permissions...
	 */

	/* FIXME */
}

public long file_fd(f)
FILE *f;
{
	/* Return the associated file descriptor */

	if (f == (FILE *) 0)
		eraise("invalid file pointer", EN_EXT);

	return (long) fileno(f);	/* Might be an int */
}

public char *file_owner(uid)
int uid;
{
	/* Return the Eiffel string filled in with the name associated with 'uid'
	 * if found in /etc/passwd. Otherwise, return fill it in with the numeric
	 * value.
	 */

	char str[NAME_MAX];
	struct passwd *pp;
	extern struct passwd *getpwuid();

	pp = getpwuid(uid);
	if (pp == (struct passwd *) 0)
		sprintf(str, "%d", uid);		/* Not available: use UID */
	else
		strcpy(str, pp->pw_name);		/* Available: fetch login name */
	
	return makestr(str, strlen(str));
}

public char *file_group(gid)
int gid;
{
	/* Return the Eiffel string filled in with the name associated with 'gid'
	 * if found in /etc/group. Otherwise, return fill it in with the numeric
	 * value.
	 */

	char str[NAME_MAX];
	struct group *gp;
	extern struct group *getgrgid();

	gp = getgrgid(gid);
	if (gp == (struct group *) 0)
		sprintf(str, "%d", gid);		/* Not available: use GID */
	else
		strcpy(str, gp->gr_name);		/* Available: fetch login name */
	
	return makestr(str, strlen(str));
}

public char *file_def(file)
int file;
{
	/* Convert the integer `i' into the corresponding
     * inpout output standard file :
     *       0 : standard input file descriptor
     *       1 : standard output file descriptor
     *       2 : standard error file descriptor
     *      otherwise : panic
     */

	switch (file) {
	case 0: return (char *) stdin;
	case 1: return (char *) stdout;
	case 2: return (char *) stderr;
	default: panic("invalid file request");
	}

	/* NOTREACHED */
}

/*
 * Emulation of possibly non-existent system calls.
 */

#ifndef HAS_RENAME
public int rename(from, to)
char *from;		/* Orginal name */
char *to;		/* Target name */
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
public int rmdir(path)
char *path;
{
	/* Emulates the rmdir() system call */

	char cmd[BUFSIZ];
	int status;			/* Status from the shell */

	errno = 0;			/* In case system() cannot fork */
	sprintf(cmd, "/bin/rmdir %s", path);
	status = system(cmd);
	if (errno != 0 || status != 0)
		return -1;
	
	return 0;
}
#endif

#ifndef HAS_MKDIR
public int mkdir(path)
char *path;
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

