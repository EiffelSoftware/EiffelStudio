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

long eif_date(path)
char *path;
{
	/* Return last modification time of file of path `path' */

	static struct stat info;

	return (-1 == stat(path,&info)) ? 0L : (long) info.st_mtime;
}

