/*

 #          #     ####    #####  ######  #    #          #    #
 #          #    #          #    #       ##   #          #    #
 #          #     ####      #    #####   # #  #          ######
 #          #         #     #    #       #  # #   ###    #    #
 #          #    #    #     #    #       #   ##   ###    #    #
 ######     #     ####      #    ######  #    #   ###    #    #

	Wide listening on all opened file descriptors (read).

	Simialr to UNIX. (A #ifdef removed as the nature of the select
		statement is predetermined.)
*/

#ifndef _listen_h_
#define _listen_h_

extern void wide_listen(void);

#endif /* _listen_h_ */
