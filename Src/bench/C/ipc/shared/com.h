/*

  ####    ####   #    #          #    #
 #    #  #    #  ##  ##          #    #
 #       #    #  # ## #          ######
 #       #    #  #    #   ###    #    #
 #    #  #    #  #    #   ###    #    #
  ####    ####   #    #   ###    #    #

	Common communication routines.
*/

#ifndef _com_h_
#define _com_h_

#include "stream.h" 	/* %%ss added */
#include "request.h" 	/* %%ss added */

#ifdef EIF_WIN32
extern void send_bye(STREAM *s, int code);				/* Send final acknowledgment */
extern void send_ack(STREAM *s, int code);				/* Send acknowledgment */
extern void send_info(STREAM *s, int code);			/* Send information */
#else
extern void send_bye(int s, int code);				/* Send final acknowledgment */
extern void send_ack(int s, int code);				/* Send acknowledgment */
extern void send_info(int s, int code);			/* Send information */
#endif

extern int send_str(STREAM *sp, char *buffer);				/* Send string to the remote process */
extern char *recv_str(STREAM *sp, int *sizeptr);			/* Receive string from the remote process */
extern void trace_request(char *status, Request *rqst);		/* Trace received request */

#endif
