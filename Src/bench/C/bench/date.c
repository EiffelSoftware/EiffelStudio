/*
	description: "[
			Helper for the compiler to properly figure out the exact modification date
			on an Eiffel source text.
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_macros.h"
#include <sys/types.h>
#include <sys/stat.h>
#ifdef I_SYS_TIMEB
#include <sys/timeb.h>
#endif
#include <time.h>

#ifdef EIF_WINDOWS
/*#define NOGDI*/
#include <windows.h>
#endif

EIF_INTEGER eif_date(char *path)
	/* Return last modification time of file of path `path' */
{
#ifdef EIF_WINDOWS
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
