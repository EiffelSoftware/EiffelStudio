/*

 #####     ##     #####  ######           ####
 #    #   #  #      #    #               #    #
 #    #  #    #     #    #####           #
 #    #  ######     #    #        ###    #
 #    #  #    #     #    #        ###    #    #
 #####   #    #     #    ######   ###     ####

		Time stamp ressources

*/

#include "macros.h"
#include <sys/types.h>
#include <sys/stat.h>

#ifdef EIF_WIN32
/*#define NOGDI*/
#include <windows.h>
#endif

EIF_INTEGER eif_date(path)
char *path;
{
	/* Return last modification time of file of path `path' */

	static struct stat info;

	return (-1 == stat(path,&info)) ? (EIF_INTEGER) 0L : (EIF_INTEGER) info.st_mtime;
}

EIF_BOOLEAN eif_directory_has_changed(path, date)
char *path;
EIF_INTEGER date;
{
	/* Check to see if the directory `path' has changed after `date' */

#if defined EIF_WINDOWS || defined EIF_OS2
	return (EIF_BOOLEAN) 1;
#else
	static struct stat info;

	if (-1 == stat(path,&info))
		return (EIF_BOOLEAN) 1;
	else
		return (date == (EIF_INTEGER) info.st_mtime) ? (EIF_BOOLEAN) 0 : (EIF_BOOLEAN) 1;
#endif
}

