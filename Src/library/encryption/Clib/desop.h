/*

 #####   ######   ####    ####   #####           #    #
 #    #  #       #       #    #  #    #          #    #
 #    #  #####    ####   #    #  #    #          ######
 #    #  #            #  #    #  #####    ###    #    #
 #    #  #       #    #  #    #  #        ###    #    #
 #####   ######   ####    ####   #        ###    #    #

	DES encryption/decryption routines used by authentication.
*/

#ifndef _desop_h_
#define _desop_h_

extern void decrypt(char *buf, int size);	/* Perform in-place DES decryption */
extern void encrypt(char *buf, int size);	/* Perform in-place DES encryption */

#endif
