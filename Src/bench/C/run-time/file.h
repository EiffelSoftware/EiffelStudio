/*

 ######     #    #       ######          #    #
 #          #    #       #               #    #
 #####      #    #       #####           ######
 #          #    #       #        ###    #    #
 #          #    #       #        ###    #    #
 #          #    ######  ######   ###    #    #

    Declarations for externals of class FILE

*/

#ifndef _file_h_
#define _file_h_
#include "limits.h"							/* For PATH_MAX */
#include "macros.h"

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

extern EIF_POINTER	file_open();
extern EIF_POINTER	file_dopen();
extern EIF_POINTER	file_reopen();
extern void file_close();
extern void file_flush();
extern EIF_BOOLEAN file_feof();
extern void file_pi();
extern void file_pr();
extern void file_ps();
extern void file_pc();
extern void file_pd();
extern void file_tnwl();
extern void file_append();
extern void file_tnil();
extern EIF_INTEGER file_gi();
extern EIF_REAL file_gr();
extern EIF_DOUBLE file_gd();
extern EIF_CHARACTER	file_gc();
extern EIF_INTEGER file_gs();
extern EIF_INTEGER file_gss();
extern EIF_INTEGER file_gw();
extern EIF_CHARACTER file_lh();
extern void file_chown();
extern void file_chgrp();
extern void file_stat ();
extern EIF_INTEGER file_info ();
extern EIF_BOOLEAN file_eaccess();
extern EIF_BOOLEAN file_access();
extern EIF_BOOLEAN file_exists();
extern void file_rename();
extern void file_link();
extern void file_unlink();
extern void file_touch();
extern void file_utime();
extern void file_perm();
extern void file_chmod();
extern EIF_INTEGER file_tell();
extern void file_go();
extern void file_recede();
extern void file_move();
extern EIF_INTEGER stat_size();
extern EIF_BOOLEAN file_creatable();
extern EIF_INTEGER file_fd();
extern char *file_owner();
extern char *file_group();

#ifdef EIF_WIN_31
	/* The following routines are already defined with the correct prototype */
#else
	/* FIXME: include the correct header files!!! */
extern int rename();
extern int rmdir();
#endif

extern EIF_BOOLEAN eif_group_in_list();
#endif
