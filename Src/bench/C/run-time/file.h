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

/*
 * The following universal constants might not be found in the standard headers
 * included in file.c. Rather than getting an headache trying to Configure that,
 * it seems better to provide them here...--RAM.
 */

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

extern char	*file_open();
extern char	*file_dopen();
extern char	*file_reopen();
extern void file_close();
extern void file_flush();
extern char file_feof();
extern void file_pi();
extern void file_pr();
extern void file_ps();
extern void file_pc();
extern void file_pd();
extern void file_tnwl();
extern void file_append();
extern void file_tnil();
extern long file_gi();
extern float file_gr();
extern double file_gd();
extern char	file_gc();
extern long file_gs();
extern long file_gss();
extern long file_gw();
extern char file_lh();
extern void file_chown();
extern void file_chgrp();
extern void file_stat ();
extern long file_info ();
extern char file_eaccess();
extern char file_access();
extern char file_exists();
extern void file_rename();
extern void file_link();
extern void file_unlink();
extern void file_touch();
extern void file_utime();
extern void file_perm();
extern void file_chmod();
extern long file_tell();
extern void file_go();
extern void file_recede();
extern void file_move();
extern long stat_size();
extern char file_creatable();
extern long file_fd();
extern char *file_owner();
extern char *file_group();
extern int rename();
extern int rmdir();

#endif
