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
#include <sys/timeb.h>
#include <time.h>

#ifdef EIF_WIN32
/*#define NOGDI*/
#include <windows.h>
#endif

EIF_INTEGER eif_date(char *path)
{
	/* Return last modification time of file of path `path' */

	static struct stat info;
#ifdef EIF_WIN32
	static struct timeb current_time;
	ftime (&current_time);
	if (current_time.dstflag == 1)
			/* We are not in the same daylight saving zone (here we are in summer)
			 * and thus in order to save in the default daylight saving zone
			 * (the winter) we need to remove 3600 seconds from the given time */
		return (-1 == stat(path,&info)) ? (EIF_INTEGER) -1L : ((EIF_INTEGER) info.st_mtime - 3600);
	else
#endif
			/* Since we are in the default daylight saving zone, we just
			 * use the value given by the operating system */
		return (-1 == stat(path,&info)) ? (EIF_INTEGER) -1L : (EIF_INTEGER) info.st_mtime;
}

EIF_BOOLEAN eif_file_has_changed(char *path, EIF_INTEGER date)
{
	/* Check to see if the directory `path' has changed after `date' */

	static struct stat info;
#ifdef EIF_WIN32
	static struct timeb current_time;

	ftime (&current_time);
	if (current_time.dstflag == 1)
			/* We are not in the same daylight saving zone (here we are in summer)
			 * and thus in order to save in the default daylight saving zone
			 * (the winter) we need to remove 3600 seconds from the given time */
		return (stat(path,&info) == -1) ? EIF_TRUE :  EIF_TEST(date != ((EIF_INTEGER) info.st_mtime - 3600));
	else
#endif
			/* Since we are in the default daylight saving zone, we just
			 * use the value given by the operating system */
		return (stat(path,&info) == -1) ? EIF_TRUE :  EIF_TEST(date != (EIF_INTEGER) info.st_mtime);

}

