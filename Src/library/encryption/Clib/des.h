/*

 #####   ######   ####           #    #
 #    #  #       #               #    #
 #    #  #####    ####           ######
 #    #  #            #   ###    #    #
 #    #  #       #    #   ###    #    #
 #####   ######   ####    ###    #    #

	Declarations for DES routines.
*/

extern int ise_desinit();		/* Initialize internal DES structures */
extern void ise_setkey();		/* Set encryption/decryption key */
extern void ise_endes();		/* Perform DES encryption */
extern void ise_dedes();		/* Perform DES decryption */
extern void ise_desdone();		/* Free internal structures allocated by ise_desinit */
