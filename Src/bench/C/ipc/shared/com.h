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

#ifdef EIF_WINDOWS
extern void send_bye(STREAM *s, int code);				/* Send final acknowledgment */
extern void send_ack(STREAM *s, int code);				/* Send acknowledgment */
extern void send_info(STREAM *s, int code);			/* Send information */
extern void send_packet(STREAM *s, Request *dans);	/* Send an answer to client */	
extern int recv_packet(STREAM *s, Request *rqst, BOOL reset);/* Receive data from client */	
#else
extern void send_bye(int s, int code);				/* Send final acknowledgment */
extern void send_ack(int s, int code);				/* Send acknowledgment */
extern void send_info(int s, int code);			/* Send information */
extern void send_packet(int s, Request *dans);	/* Send an answer to client */
extern int recv_packet(int s, Request *rqst);	/* Receive data from client */
#endif

extern int send_str(STREAM *sp, char *buffer);				/* Send string to the remote process */
extern char *recv_str(STREAM *sp, size_t *sizeptr);			/* Receive string from the remote process */
extern void trace_request(char *status, Request *rqst);		/* Trace received request */

#endif
