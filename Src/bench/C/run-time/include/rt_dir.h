/*

 #####      #    #####           #    #
 #    #     #    #    #          #    #
 #    #     #    #    #          ######
 #    #     #    #####    ###    #    #
 #    #     #    #   #    ###    #    #
 #####      #    #    #   ###    #    #

	Private declaration of public directory functions.
*/

#ifndef _rt_dir_h_
#define _rt_dir_h_

#include "eif_dir.h"

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

#ifdef EIF_WIN32
#include <windows.h>
#include <direct.h>	/* In order to use chdir and getcwd */
#else
#include <unistd.h>	/* In order to use chdir and getcwd */
#endif

#endif
