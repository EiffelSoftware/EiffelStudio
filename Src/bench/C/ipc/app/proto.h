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

#include "request.h"

extern int rqstcnt;				/* Request count (number of requests sent) */

#ifdef EIF_WINDOWS
extern void arqsthandle(STREAM *);		/* General request handler */
extern void stop_rqst(STREAM *);		/* Stop notification to workbench */
extern int recv_packet(STREAM *, Request *, BOOL); /* Receive IDR packet from ised */
#else
extern void arqsthandle(int s);		/* General request handler */
extern void stop_rqst(int s);		/* Stop notification to workbench */
extern int recv_packet(int, Request *);		/* Receive IDR packet from ised */	
#endif

extern void prt_init(void);			/* Initialize IDR filters */

#endif
