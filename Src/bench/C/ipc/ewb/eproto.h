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
rt_public int shell(char *cmd);		/* Run shell command synchronously */
rt_public int background(char *cmd); /* Run shell command asynchronously */
rt_public int app_start(char *cmd);			/* Start application in debugging mode */

#endif
