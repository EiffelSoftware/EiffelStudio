/*

 #####     ##     #####  ######           ####
 #    #   #  #      #    #               #    #
 #    #  #    #     #    #####           #
 #    #  ######     #    #        ###    #
 #    #  #    #     #    #        ###    #    #
 #####   #    #     #    ######   ###     ####

		Time stamp ressources

*/

#include "eif_macros.h"
#include <sys/types.h>
#include <sys/stat.h>

#ifdef EIF_WIN32
/*#define NOGDI*/
#include <windows.h>
#endif

EIF_INTEGER eif_date(char *path)
{
	/* Return last modification time of file of path `path' */

	static struct stat info;

	return (-1 == stat(path,&info)) ? (EIF_INTEGER) 0L : (EIF_INTEGER) info.st_mtime;
}

EIF_BOOLEAN eif_directory_has_changed(char *path, EIF_INTEGER date)
{
	/* Check to see if the directory `path' has changed after `date' */

	static struct stat info;

	return (-1 == stat(path,&info)) ? EIF_TRUE : EIF_TEST(date != (EIF_INTEGER) info.st_mtime);
}

