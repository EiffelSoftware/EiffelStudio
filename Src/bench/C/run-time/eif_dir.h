/*

 #####      #    #####           #    #
 #    #     #    #    #          #    #
 #    #     #    #    #          ######
 #    #     #    #####    ###    #    #
 #    #     #    #   #    ###    #    #
 #####      #    #    #   ###    #    #

	Declaration of public directory functions.
*/

#ifndef _eif_dir_h_
#define _eif_dir_h_

#include "eif_macros.h"

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
#ifdef EIF_VMS_V6_ONLY
#include <descrip.h>
#include "eif_vmsdirent.h"		/* local to run-time */
#define DIRENTRY struct dirent
#elif defined EIF_WIN32
#else
	Sorry! You have to find a directory package...
#endif
#endif
#endif
#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WIN32
typedef struct tagEIF_WIN_DIRENT {
	char	name [MAX_PATH];
	HANDLE	handle;
} EIF_WIN_DIRENT;
#endif

RT_LNK EIF_POINTER dir_open(char *name);
RT_LNK EIF_REFERENCE dir_current(void);
RT_LNK EIF_CHARACTER eif_dir_separator (void);
RT_LNK EIF_INTEGER eif_chdir (EIF_OBJECT path);
RT_LNK EIF_BOOLEAN eif_dir_exists (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_readable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_writable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_executable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_deletable (char *name);
RT_LNK void eif_dir_delete (char *name);
RT_LNK void dir_rewind(EIF_POINTER dirp);
RT_LNK char *dir_search(EIF_POINTER dirp, char *name);
RT_LNK EIF_REFERENCE dir_next(EIF_POINTER dirp);
RT_LNK void dir_close(EIF_POINTER dirp);

#ifdef __cplusplus
}
#endif

#endif  /* _eif_dir_h_ */
