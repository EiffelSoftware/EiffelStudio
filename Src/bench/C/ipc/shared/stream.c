/*
	description: "[
			Maps file descriptor on STREAM structure.

			The motivation for the STREAM structure is to make it easy later to use
			sockets in place of pipes when networking code will be activated. A
			single socket descriptor may be use bidirectionnally, but a pipe is
			only for reading or writing.

			For Windows:
				This form is a little more complex.
				A stream consists of 4 components, 2 pipes and 2 events.
				Each pipe has an event associated with it.
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

#include "eif_config.h"
#include "eif_portable.h"
#include "stream.h"
#ifndef EIF_WINDOWS
#include <unistd.h>
#ifdef EIF_VMS
#include "ipcvms.h"		/* only affects VMS */
#endif
#endif

#define MAX_FILE_DESC	64		/* To be Configured--FIXME */

/* All the recorded streams are recorded in an array, which makes it possible
 * to map an file descriptor to its associated stream structure.
 */

#ifndef EIF_WINDOWS
rt_public STREAM *stream_by_fd [MAX_FILE_DESC];
#endif

#ifdef EIF_WINDOWS
rt_public STREAM *new_stream(HANDLE read_fd, HANDLE write_fd, HANDLE er, HANDLE ew)
#else
rt_public STREAM *new_stream(int read_fd, int write_fd)
#endif
{
	/* Records the new stream and returns a pointer to a freshly allocated
	 * stream structure. A null pointer is returned in case of error.
	 */

	STREAM *sp;			/* Created stream structure */

	sp = (STREAM *) malloc(sizeof(STREAM));
	if (sp == (STREAM *) 0)
		return (STREAM *) 0;		/* Could not allocate structure */

	sp->sr = read_fd;				/* File descriptor used for reading */
	sp->sw = write_fd;				/* File descriptor used for writing */

#ifdef EIF_WINDOWS
	sp->er = er;				/* Handle for event monitor - read ok */
	sp->ew = ew;				/* Handle for event monitor - write done */
#else
	stream_by_fd[read_fd] = sp;		/* Enable searching by fd */
	stream_by_fd[write_fd] = sp;
#ifdef USE_ADD_LOG
	add_log(20, "new stream created, read_fd: %d, write_fd: %d", read_fd, write_fd);
#endif
#endif

	return sp;			/* Associated stream structure */
}

rt_public void close_stream(STREAM *sp)
{
	/* Close the stream connection */

#ifdef EIF_WINDOWS
	CloseHandle(readfd(sp));
	CloseHandle(writefd(sp));
	CloseHandle(writeev(sp));
	CloseHandle(readev(sp));
	readfd(sp) = NULL;
	writefd(sp) = NULL;
	readev(sp) = NULL;
	writeev(sp) = NULL;

#else

#ifdef USE_ADD_LOG
	add_log(20, "close stream (read_fd: %d, write_fd: %d)", readfd(sp), writefd(sp));
#endif
	close(readfd(sp));
	close(writefd(sp));
	stream_by_fd[readfd(sp)] = (STREAM *) 0;
	stream_by_fd[writefd(sp)] = (STREAM *) 0;
#endif
}
