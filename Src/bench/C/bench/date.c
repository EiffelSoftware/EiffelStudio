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
	/* Return last modification time of file of path `path' */
{
#ifdef EIF_WIN32
		/* On NTFS file system, windows store UTC file stamps in 100 of nanoseconds
		 * starting from January 1st 0. Converted in seconds, this time is greater
		 * than 2^32 therefore we substract the EPOCH date January 1st 1970 to get
		 * a 32 bits representation of the date.
		 * FIXME: Manu 01/28/2004: On FAT file system, the date is in local time,
		 * meaning that the code below does not compensate if you change your timezone
		 * and will return a different date value for the same stamp just because
		 * you are in different time zone.
		 */
	static ULARGE_INTEGER epoch_date;
	static int done = 0;

	WIN32_FIND_DATA l_find_data;
	HANDLE l_file_handle;
	ULARGE_INTEGER l_date;

	l_file_handle = FindFirstFile(path, &l_find_data);
	if (l_file_handle == INVALID_HANDLE_VALUE) {
		return -1;
	} else {
			/* We do not need the file handle anymore, so we close it to
			 * avoir handle leak. */
		FindClose (l_file_handle);
		if (done == 0) {
				/* Lazy initialization of `epoch_date'. */
			SYSTEMTIME epoch;
			FILETIME epoch_file;

			done = 1;
			memset (&epoch, 0, sizeof(SYSTEMTIME));
			epoch.wYear = 1970;
			epoch.wMonth = 1;
			epoch.wDay = 1;
			SystemTimeToFileTime (&epoch, &epoch_file);
			memcpy (&epoch_date, &epoch_file, sizeof (ULARGE_INTEGER));
		}
		memcpy (&l_date, &(l_find_data.ftLastWriteTime), sizeof (ULARGE_INTEGER));
		return (EIF_INTEGER) ((l_date.QuadPart - epoch_date.QuadPart) / RTI64C(10000000));
	}
#else
	static struct stat info;
	return (-1 == stat(path,&info)) ? (EIF_INTEGER) -1L : (EIF_INTEGER) info.st_mtime;
#endif
}
