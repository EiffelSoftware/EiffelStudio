/*

  ####    #####  #####   ######    ##    #    #           ####
 #          #    #    #  #        #  #   ##  ##          #    #
  ####      #    #    #  #####   #    #  # ## #          #
      #     #    #####   #       ######  #    #   ###    #
 #    #     #    #   #   #       #    #  #    #   ###    #    #
  ####      #    #    #  ######  #    #  #    #   ###     ####

	Maps file descriptor on STREAM structure.

	The motivation for the STREAM structure is to make it easy later to use
	sockets in place of pipes when networking code will be activated. A
	single socket descriptor may be use bidirectionnally, but a pipe is
	only for reading or writing.

	For Windows:
		This form is a little more complex.
		A stream consists of 4 components, 2 pipes and 2 events.
		Each pipe has an event associated with it.

*/

#include "eif_config.h"
#include "ipcvms.h"		/* only affects VMS */
#include "eif_portable.h"
#include "stream.h"
#ifndef EIF_WIN32
#include <unistd.h>
#endif

#define MAX_FILE_DESC	64		/* To be Configured--FIXME */

/* All the recorded streams are recorded in an array, which makes it possible
 * to map an file descriptor to its associated stream structure.
 */

#ifndef EIF_WIN32
rt_public STREAM *stream_by_fd [MAX_FILE_DESC];
#endif

#ifdef EIF_WIN32
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

#ifdef EIF_WIN32
	sp->er = er;				/* Handle for event monitor - read ok */
	sp->ew = ew;				/* Handle for event monitor - write done */
#else
	stream_by_fd[read_fd] = sp;		/* Enable searching by fd */
	stream_by_fd[write_fd] = sp;
#endif

	return sp;			/* Associated stream structure */
}

rt_public void close_stream(STREAM *sp)
{
	/* Close the stream connection */

#ifdef EIF_WIN32
	CloseHandle(readfd(sp));
	CloseHandle(writefd(sp));
	CloseHandle(writeev(sp));
	CloseHandle(readev(sp));
	readfd(sp) = NULL;
	writefd(sp) = NULL;
	readev(sp) = NULL;
	writeev(sp) = NULL;
#else
	close(readfd(sp));
	close(writefd(sp));

	stream_by_fd[readfd(sp)] = (STREAM *) 0;
	stream_by_fd[writefd(sp)] = (STREAM *) 0;
#endif
}
