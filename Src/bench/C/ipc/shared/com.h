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

extern void send_bye();				/* Send final acknowledgment */
extern void send_ack();				/* Send acknowledgment */
extern int send_str();				/* Send string to the remote process */
extern char *recv_str();			/* Receive string from the remote process */
extern void trace_request();		/* Trace received request */

#endif
