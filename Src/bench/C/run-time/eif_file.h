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

#include <stdio.h>		/* %%zs moved from file.c */
#include <limits.h>							/* For PATH_MAX */

#ifdef I_DIRENT								/* For PATH_MAX under Linux */
#include <dirent.h>
#endif

#ifdef EIF_WIN32
#include <time.h>
#ifndef PATH_MAX
#define PATH_MAX 260	/* Maximum length of full path name */
#endif

#else

#include <unistd.h>		/* For R_OK,... */

#ifndef PATH_MAX
#define PATH_MAX 1024	/* Maximum length of full path name */
#endif

#endif

#include "eif_macros.h"

/*
 * The following universal constants might not be found in the standard headers
 * included in file.c. Rather than getting an headache trying to Configure that,
 * it seems better to provide them here...--RAM.
 */

#include <sys/types.h>
#include <sys/stat.h>

#ifdef __cplusplus
extern "C" {
#endif

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

RT_LNK char *file_open_mode(int how, char mode);
RT_LNK EIF_POINTER file_open(char *name, int how);
RT_LNK EIF_POINTER file_dopen(int fd, int how);
RT_LNK EIF_POINTER file_reopen(char *name, int how, FILE *old);
RT_LNK EIF_POINTER file_binary_open(char *name, int how);
RT_LNK EIF_POINTER file_binary_dopen(int fd, int how);
RT_LNK EIF_POINTER file_binary_reopen(char *name, int how, FILE *old);
RT_LNK void file_close(FILE *fp);
RT_LNK void file_flush(FILE *fp);
RT_LNK EIF_INTEGER file_size (FILE *fp);
RT_LNK EIF_BOOLEAN file_feof(FILE *fp);
RT_LNK void file_pi(FILE *f, EIF_INTEGER number);
RT_LNK void file_pr(FILE *f, EIF_REAL number);
RT_LNK void file_pib(FILE *f, EIF_INTEGER number);
RT_LNK void file_prb(FILE *f, EIF_REAL number);
RT_LNK void file_ps(FILE *f, char *str, EIF_INTEGER len);
RT_LNK void file_pc(FILE *f, char c);
RT_LNK void file_pd(FILE *f, EIF_DOUBLE val);
RT_LNK void file_pdb(FILE *f, EIF_DOUBLE val);
RT_LNK void file_tnwl(FILE *f);
RT_LNK void file_append(FILE *f, FILE *other, EIF_INTEGER l);
RT_LNK void file_tnil(FILE *f);
RT_LNK EIF_INTEGER file_gi(FILE *f);
RT_LNK EIF_REAL file_gr(FILE *f);
RT_LNK EIF_DOUBLE file_gd(FILE *f);
RT_LNK EIF_INTEGER file_gib(FILE *f);
RT_LNK EIF_REAL file_grb(FILE *f);
RT_LNK EIF_DOUBLE file_gdb(FILE *f);
RT_LNK EIF_CHARACTER file_gc(FILE *f);
RT_LNK EIF_INTEGER file_gs(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
RT_LNK EIF_INTEGER file_gss(FILE *f, char *s, EIF_INTEGER bound);
RT_LNK EIF_INTEGER file_gw(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
RT_LNK EIF_CHARACTER file_lh(FILE *f);
RT_LNK void file_chown(char *name, int uid);
RT_LNK void file_chgrp(char *name, int gid);
RT_LNK void file_stat(char *path, struct stat *buf);
RT_LNK EIF_INTEGER file_info(struct stat *buf, int op);
RT_LNK EIF_BOOLEAN file_eaccess(struct stat *buf, int op);
RT_LNK EIF_BOOLEAN file_access(char *name, EIF_INTEGER op);
RT_LNK EIF_BOOLEAN file_exists(char *name);
RT_LNK void file_rename(char *from, char *to);
RT_LNK void file_link(char *from, char *to);
RT_LNK void file_mkdir(char *path);
RT_LNK void file_unlink(char *name);
RT_LNK void file_touch(char *name);
RT_LNK void file_utime(char *name, time_t stamp, int how);
RT_LNK void file_perm(char *name, char *who, char *what, int flag);
RT_LNK void file_chmod(char *path, int mode);
RT_LNK EIF_INTEGER file_tell(FILE *f);
RT_LNK void file_go(FILE *f, EIF_INTEGER pos);
RT_LNK void file_recede(FILE *f, EIF_INTEGER pos);
RT_LNK void file_move(FILE *f, EIF_INTEGER pos);
RT_LNK EIF_INTEGER stat_size(void);
RT_LNK EIF_BOOLEAN file_creatable(char *path);
RT_LNK EIF_INTEGER file_fd(FILE *f);
RT_LNK char *file_owner(int uid);
RT_LNK char *file_group(int gid);

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
