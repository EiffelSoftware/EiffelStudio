/*

  ####    #####  #####   ######    ##    #    #          #    #
 #          #    #    #  #        #  #   ##  ##          #    #
  ####      #    #    #  #####   #    #  # ## #          ######
      #     #    #####   #       ######  #    #   ###    #    #
 #    #     #    #   #   #       #    #  #    #   ###    #    #
  ####      #    #    #  ######  #    #  #    #   ###    #    #

	Encapsulation of reading and writing file descriptors. For a socket,
	the two values are the same, but not for a pipe. To get a nice clean
	standard interface, let's encapsulate...
*/

#ifndef _stream_h_
#define _stream_h_

typedef struct stream {
	int sr;			/* Reading stream */
	int sw;			/* Writing stream */
} STREAM;

/* Acesssing of reading and writing file descriptors is to be done via macros,
 * to keep a constant interface should the STREAM structure evolve over time.
 */
#define readfd(sp)		((sp)->sr)
#define writefd(sp)		((sp)->sw)

extern STREAM *stream_by_fd[];		/* Maps a fd to a STREAM */
extern STREAM *new_stream(int read_fd, int write_fd);		/* Asks for a new STREAM structure */
extern void close_stream(STREAM *sp);			/* Close stream connection */

#endif
