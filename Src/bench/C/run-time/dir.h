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
#include "macros.h"

#ifdef I_DIRENT
#ifdef __WATCOMC__
#include <direct.h>
#else
#include <dirent.h>
#endif
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
	Sorry! You have to find a directory package...
#endif
#endif
#endif

extern fnptr dir_open();
extern void dir_rewind();
extern char *dir_search();
extern char *dir_next();

#endif
