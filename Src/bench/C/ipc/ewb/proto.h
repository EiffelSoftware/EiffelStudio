/*

 #####   #####    ####    #####   ####           #    #
 #    #  #    #  #    #     #    #    #          #    #
 #    #  #    #  #    #     #    #    #          ######
 #####   #####   #    #     #    #    #   ###    #    #
 #       #   #   #    #     #    #    #   ###    #    #
 #       #    #   ####      #     ####    ###    #    #

	Some structures and defines used to ensure protocol.
*/

#ifndef _proto_h_
#define _proto_h_

#include "request.h" 	/* %%ss added */

extern int rqstcnt;				/* Request count (number of requests sent) */

extern void prt_init(void);			/* Initialize IDR filters */

#ifdef EIF_WINDOWS
extern void send_packet(STREAM *s, Request *rqst);		/* Send IDR packet to ised */
extern int recv_packet(STREAM *s, Request *dans, BOOL reset); /* Receive IDR packet from ised */
#else
extern void send_packet(int s, Request *rqst);		/* Send IDR packet to ised */
extern int recv_packet(int s, Request *dans);		/* Receive IDR packet from ised */	
#endif

#endif
