/*

 #####      #    #####           #    #
 #    #     #    #    #          #    #
 #    #     #    #    #          ######
 #    #     #    #####    ###    #    #
 #    #     #    #   #    ###    #    #
 #####      #    #    #   ###    #    #

	Declaration of public directory functions.
*/

#ifndef _dir_h_
#define _dir_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "macros.h"

#ifdef I_DIRECT
#include <direct.h>				/* Pseudo symbol for Watcom C */
#define DIRENTRY struct dirent
#else
#ifdef I_DIRENT
#include <dirent.h>
#define DIRENTRY struct dirent
#else
#ifdef I_SYS_DIR
#include <sys/dir.h>
#define DIRENTRY struct direct
#else
#ifdef I_SYS_NDIR
#include <sys/ndir.h>
#define DIRENTRY struct direct
#else
#ifdef __VMS
#include <descrip.h>
#include "vmsdirent.h"		/* local to run-time */
#define DIRENTRY struct dirent
#elif defined EIF_WIN32
#else
	Sorry! You have to find a directory package...
#endif
#endif
#endif
#endif
#endif

#ifdef __VMS
extern char *   dir_dot_dir (char * dir);
#endif

#ifdef EIF_WIN32		/* %%zs moved this block to here from dir.c for EIF_WN_DIRENT definition */
#include <windows.h>
#ifndef MAX_PATH
#define MAX_PATH 255
#endif

typedef struct tagEIF_WIN_DIRENT {
	char	name [MAX_PATH];
	HANDLE	handle;
} EIF_WIN_DIRENT;
#endif

extern EIF_POINTER dir_open(char *name);

#ifdef EIF_WIN32					/* %%zs added if..elif..else -> DIR definition... */
extern void dir_rewind(EIF_WIN_DIRENT *dirp);
extern char *dir_search(EIF_WIN_DIRENT *dirp, char *name);
extern char *dir_next(EIF_WIN_DIRENT *dirp);

#elif defined EIF_OS2
extern void dir_rewind(EIF_OS2_DIRENT *dirp);
extern char *dir_search(EIF_OS2_DIRENT *dirp, char *name);
extern char *dir_next(EIF_OS2_DIRENT *dirp);

#else
extern void dir_rewind(DIR *dirp);
extern char *dir_search(DIR *dirp, char *name);
extern char *dir_next(DIR *dirp);

#endif

#ifdef __cplusplus
}
#endif

#endif
