/*

 #####   ######   ####           #    #
 #    #  #       #               #    #
 #    #  #####    ####           ######
 #    #  #            #   ###    #    #
 #    #  #       #    #   ###    #    #
 #####   ######   ####    ###    #    #

	Declarations for DES routines.
*/

extern int desinit();		/* Initialize internal DES structures */
extern void setkey();		/* Set encryption/decryption key */
extern void endes();			/* Perform DES encryption */
extern void dedes();			/* Perform DES decryption */
extern void desdone();		/* Free internal structures allocated by desinit */
