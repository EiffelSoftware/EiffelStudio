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

extern int rqstcnt;				/* Request count (number of requests sent) */

#ifdef EIF_WIN32
#include "stream.h"
extern void arqsthandle(STREAM *s);		/* General request handler */
extern void stop_rqst(STREAM *s);		/* Stop notification to workbench */
#else
extern void arqsthandle(int s);		/* General request handler */
extern void stop_rqst(int s);		/* Stop notification to workbench */
#endif

extern void prt_init(void);			/* Initialize IDR filters */

#endif
