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
*/

#include "config.h"
#include "portable.h"
#include "stream.h"

#define MAX_FILE_DESC	64		/* To be Configured--FIXME */

extern Malloc_t malloc();

/* All the recorded streams are recorded in an array, which makes it possible
 * to map an file descriptor to its associated stream structure.
 */
rt_public STREAM *stream_by_fd[MAX_FILE_DESC];

rt_public STREAM *new_stream(read_fd, write_fd)
int read_fd;
int write_fd;
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

	stream_by_fd[read_fd] = sp;		/* Enable searching by fd */
	stream_by_fd[write_fd] = sp;

	return sp;			/* Associated stream structure */
}

rt_public void close_stream(sp)
STREAM *sp;
{
	/* Close the stream connection */

	close(readfd(sp));
	close(writefd(sp));

	stream_by_fd[readfd(sp)] = (STREAM *) 0;
	stream_by_fd[writefd(sp)] = (STREAM *) 0;
}

