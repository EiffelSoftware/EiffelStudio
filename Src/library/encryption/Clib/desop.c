/*

 #####   ######   ####    ####   #####            ####
 #    #  #       #       #    #  #    #          #    #
 #    #  #####    ####   #    #  #    #          #
 #    #  #            #  #    #  #####    ###    #
 #    #  #       #    #  #    #  #        ###    #    #
 #####   ######   ####    ####   #        ###     ####

	DES encryption routines for authentication, using conversation
	key and des algorithm #1.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "des.h"
#include "desop.h"

rt_private void desop(char *buf, int size, void (*crypter)())
	 /* Pointer to data to be (de)crypted */
	 /* Size in bytes of encrypted data */
	 /* Routine used to perform DES operation */
{
	/* In place DES encryption/decryption using routine 'crypter'.
	 * The key used is the conversation key.
	 */
	
	char work[8];		/* DES routines work with 8 bytes chunks */

	memset(work, 0, 8);		/* Filled with zeros only the first time */
	while (size > 0) {
		/* Note that residual byte(s) are left untouched even if they are
		 * garbage (when size < 8). This is a FEATURE, not a bug--RAM.
		 * At decrypt time, the remaining bytes will be ignored anyway.
		 */
		memcpy(work, buf, size < 8 ? size : 8);
		(crypter)(work);
		memcpy(buf, work, size < 8 ? size : 8);
		size -= 8;
		buf += 8;
	}
}

rt_public void des_decrypt(char *buf, int size)
	 /* Pointer to data to be decrypted */
	 /* Size in bytes of encrypted data */
{
	/* In place decryption of data held in 'buf' */

	desop(buf, size, ise_dedes);		/* DES decryption */
}

rt_public void des_encrypt(char *buf, int size)
	 /* Pointer to data to be encrypted */
	 /* Size in bytes of encrypted data */
{
	/* In place encryption of data held in 'buf' */
	
	desop(buf, size, ise_endes);		/* DES encryption */
}

