/*

 ######     #    #       ######          #    #
 #          #    #       #               #    #
 #####      #    #       #####           ######
 #          #    #       #        ###    #    #
 #          #    #       #        ###    #    #
 #          #    ######  ######   ###    #    #

    Declarations for externals of class FILE

*/

#ifndef _eif_file_h_
#define _eif_file_h_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>		/* %%zs moved from file.c */
#include <limits.h>							/* For PATH_MAX */
#include "eif_macros.h"

#ifdef I_DIRENT								/* For PATH_MAX under Linux */
#include <dirent.h>
#endif

/*
 * The following universal constants might not be found in the standard headers
 * included in file.c. Rather than getting an headache trying to Configure that,
 * it seems better to provide them here...--RAM.
 */

#include <sys/types.h>
#include <sys/stat.h>

#ifndef S_IRUSR
#define S_IRUSR 0000400
#endif
#ifndef S_IWUSR
#define S_IWUSR 0000200
#endif
#ifndef S_IXUSR
#define S_IXUSR 0000100
#endif
#ifndef S_IRGRP
#define S_IRGRP 0000040
#endif
#ifndef S_IWGRP
#define S_IWGRP 0000020
#endif
#ifndef S_IXGRP
#define S_IXGRP 0000010
#endif
#ifndef S_IROTH
#define S_IROTH 0000004
#endif
#ifndef S_IWOTH
#define S_IWOTH 0000002
#endif
#ifndef S_IXOTH
#define S_IXOTH 0000001
#endif
#ifndef S_IFDIR
#define S_IFDIR 0040000
#endif
#ifndef S_IFCHR
#define S_IFCHR 0020000
#endif
#ifndef S_IFBLK
#define S_IFBLK 0060000
#endif
#ifndef S_IFREG
#define S_IFREG 0100000
#endif
#ifndef S_IFIFO
#define S_IFIFO 0010000
#endif
#ifndef S_IFLNK
#define S_IFLNK 0120000
#endif
#ifndef S_IFSOCK
#define S_IFSOCK 0140000
#endif

#ifndef PATH_MAX
#define PATH_MAX 512	/* Maximum length of full path name */
#endif

/* The following access constants seems to be universally accepeted. And
 * anyway, it's only after BSD 4.1 that the symbolic constants appeared.
 */

#ifndef R_OK
#define R_OK	4
#define W_OK	2
#define X_OK	1
#define F_OK	0
#endif

/*
 * Functions declaration.
 */

extern char *file_open_mode(int how, char mode);
extern EIF_POINTER	file_open(char *name, int how);
extern EIF_POINTER file_dopen(int fd, int how);
extern EIF_POINTER file_reopen(char *name, int how, FILE *old);
extern EIF_POINTER file_binary_open(char *name, int how);
extern EIF_POINTER file_binary_dopen(int fd, int how);
extern EIF_POINTER file_binary_reopen(char *name, int how, FILE *old);
extern void file_close(FILE *fp);
extern void file_flush(FILE *fp);
extern EIF_INTEGER file_size (FILE *fp);
extern EIF_BOOLEAN file_feof(FILE *fp);
extern void file_pi(FILE *f, EIF_INTEGER number);
extern void file_pr(FILE *f, EIF_REAL number);
extern void file_pib(FILE *f, EIF_INTEGER number);
extern void file_prb(FILE *f, EIF_REAL number);
extern void file_ps(FILE *f, char *str, EIF_INTEGER len);
extern void file_pc(FILE *f, char c);
extern void file_pd(FILE *f, EIF_DOUBLE val);
extern void file_pdb(FILE *f, EIF_DOUBLE val);
extern void file_tnwl(FILE *f);
extern void file_append(FILE *f, FILE *other, EIF_INTEGER l);
extern void file_tnil(FILE *f);
extern EIF_INTEGER file_gi(FILE *f);
extern EIF_REAL file_gr(FILE *f);
extern EIF_DOUBLE file_gd(FILE *f);
extern EIF_INTEGER file_gib(FILE *f);
extern EIF_REAL file_grb(FILE *f);
extern EIF_DOUBLE file_gdb(FILE *f);
extern EIF_CHARACTER file_gc(FILE *f);
extern EIF_INTEGER file_gs(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
extern EIF_INTEGER file_gss(FILE *f, char *s, EIF_INTEGER bound);
extern EIF_INTEGER file_gw(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
extern EIF_CHARACTER file_lh(FILE *f);
extern void file_chown(char *name, int uid);
extern void file_chgrp(char *name, int gid);
extern void file_stat(char *path, struct stat *buf);
extern EIF_INTEGER file_info(struct stat *buf, int op);
extern EIF_BOOLEAN file_eaccess(struct stat *buf, int op);
extern EIF_BOOLEAN file_access(char *name, EIF_INTEGER op);
extern EIF_BOOLEAN file_exists(char *name);
extern void file_rename(char *from, char *to);
extern void file_link(char *from, char *to);
extern void file_mkdir(char *path);
extern void file_unlink(char *name);
extern void file_touch(char *name);
extern void file_utime(char *name, time_t stamp, int how);
extern void file_perm(char *name, char *who, char *what, int flag);
extern void file_chmod(char *path, int mode);
extern EIF_INTEGER file_tell(FILE *f);
extern void file_go(FILE *f, EIF_INTEGER pos);
extern void file_recede(FILE *f, EIF_INTEGER pos);
extern void file_move(FILE *f, EIF_INTEGER pos);
extern EIF_INTEGER stat_size(void);
extern EIF_BOOLEAN file_creatable(char *path);
extern EIF_INTEGER file_fd(FILE *f);
extern char *file_owner(int uid);
extern char *file_group(int gid);

#ifdef HAS_GETGROUPS
/* Does the list of groups the user belongs to include `gid'? */
extern EIF_BOOLEAN eif_group_in_list(int gid);
#endif

	/* FIXME: include the correct header files!!! */

#ifndef HAS_RENAME	/* %%zs added */
extern int rename(const char *from, const char *to);
#endif

#ifndef HAS_RMDIR
extern int rmdir(const char *path);
#endif

#ifndef HAS_MKDIR
extern int mkdir(char *path);
#endif

#ifdef __cplusplus
}
#endif

#endif
