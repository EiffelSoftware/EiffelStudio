/*
	description: "[
			Encapsulation of reading and writing file descriptors. For a socket,
			the two values are the same, but not for a pipe. To get a nice clean
			standard interface, let's encapsulate...

			For Windows:
				We need to go further as a read on a pipe will block and won't trigger
				a WaitForSingleObject successfully.

				We use a Semaphore for the triggering and a pipe for the communications.

				The pipe is built from the processid of the started app - both the started and
				startee have access to this value.
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

#ifndef _stream_h_
#define _stream_h_

#ifdef EIF_WINDOWS
#include <windows.h>
#endif

#ifdef EIF_WINDOWS
typedef struct stream {
	HANDLE sr;                      /* Reading stream */
	HANDLE sw;                      /* Writing stream */
	HANDLE er;                      /* Event handle read awaiting */
	HANDLE ew;                      /* Event handle write done */
} STREAM, *EIF_LPSTREAM;

#define readfd(sp)              ((sp)->sr)
#define writefd(sp)             ((sp)->sw)
#define readev(sp)              ((sp)->er)
#define writeev(sp)             ((sp)->ew)

#else
typedef struct stream {
	int sr;			/* Reading stream */
	int sw;			/* Writing stream */
} STREAM;

#define readfd(sp)		((sp)->sr)
#define writefd(sp)		((sp)->sw)
#endif

/* Acesssing of reading and writing file descriptors is to be done via macros,
 * to keep a constant interface should the STREAM structure evolve over time.
 */

#ifdef EIF_WINDOWS
extern STREAM *new_stream(HANDLE read_fd, HANDLE write_fd, HANDLE er, HANDLE ew);
extern int net_recv(STREAM *, char *, size_t, BOOL);
extern int net_send(STREAM *, char *, size_t);
#else
extern STREAM *new_stream(int read_fd, int write_fd);		/* Asks for a new STREAM structure */
extern STREAM *stream_by_fd[];		/* Maps a fd to a STREAM */
rt_public int net_send(int cs, char *buf, size_t size) ;
rt_public int net_recv(int cs, char *buf, size_t size) ;
#endif

extern void close_stream(STREAM *sp);			/* Close stream connection */
#endif
