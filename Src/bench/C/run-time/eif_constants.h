/*

 ######     #    ######           ####    ####   #    #   ####    #####    ##	 #    #   #####   ####           #    #
 #          #    #               #    #  #    #  ##   #  #          #     #  #	 ##   #     #    #               #    #
 #####      #    #####           #       #    #  # #  #   ####      #    #    #	 # #  #     #     ####           ######
 #          #    #               #       #    #  #  # #       #     #    ######	 #  # #     #         #   ###    #    #
 #          #    #               #    #  #    #  #   ##  #    #     #    #    #	 #   ##     #    #    #   ###    #    #
 ######     #    #      #######   ####    ####   #    #   ####      #    #    #	 #    #     #     ####    ###    #    #

	Constants used in global variable definitions.

*/

#ifndef _eif_constants_h_
#define _eif_constants_h_

	/* except.h */
#ifndef WORKBENCH
#define EN_NEX		25			/* Number of internal exceptions */
#else
#define EN_NEX		26			/* Number of internal exceptions */
#endif

	/* pattern.c */
#define ASIZE 256     /* The alphabet's size */

	/* out.c */
#define TAG_SIZE 512  /* Maximum size for a single tagged expression */

#endif	/* _eif_constants_h_ */
