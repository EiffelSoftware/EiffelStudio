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

/* Command spawning via ised */
public int shell();				/* Run shell command synchronously */
public int background();		/* Run shell command asynchronously */

#endif
