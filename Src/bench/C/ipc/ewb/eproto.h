/*

 ######  #####   #####    ####    #####   ####           #    #
 #       #    #  #    #  #    #     #    #    #          #    #
 #####   #    #  #    #  #    #     #    #    #          ######
 #       #####   #####   #    #     #    #    #   ###    #    #
 #       #       #   #   #    #     #    #    #   ###    #    #
 ######  #       #    #   ####      #     ####    ###    #    #

	Some structures and defines used to ensure protocol.
*/

#ifndef _eproto_h_
#define _eproto_h_

/* Command spawning via ised */
public int shell();				/* Run shell command synchronously */
public int background();		/* Run shell command asynchronously */
public int app_start();			/* Start application in debugging mode */

#endif
