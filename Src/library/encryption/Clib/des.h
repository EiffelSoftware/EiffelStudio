/*

 #####   ######   ####           #    #
 #    #  #       #               #    #
 #    #  #####    ####           ######
 #    #  #            #   ###    #    #
 #    #  #       #    #   ###    #    #
 #####   ######   ####    ###    #    #

	Declarations for DES routines.
*/

#ifndef _des_h_
#define _des_h_

#ifdef __cplusplus
extern "C" {
#endif

extern int ise_desinit();		/* Initialize internal DES structures */
extern void ise_setkey();		/* Set encryption/decryption key */
extern void ise_endes(char *);		/* Perform DES encryption */
extern void ise_dedes(char *);		/* Perform DES decryption */
extern void ise_desdone();		/* Free internal structures allocated by ise_desinit */

#ifdef __cplusplus
}
#endif

#endif /* _des_h_ */
