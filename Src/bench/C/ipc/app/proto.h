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

extern void arqsthandle();		/* General request handler */
extern void stop_rqst();		/* Stop notification to workbench */
extern void prt_init();			/* Initialize IDR filters */

#endif
