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

extern void prt_init();			/* Initialize IDR filters */
extern void send_packet();		/* Send IDR packet to ised */
extern int recv_packet();		/* Receive IDR packet from ised */

#endif
