/*

  #####   ####    ####   #        ####            ####
    #    #    #  #    #  #       #               #    #
    #    #    #  #    #  #        ####           #
    #    #    #  #    #  #            #   ###    #
    #    #    #  #    #  #       #    #   ###    #    #
    #     ####    ####   ######   ####    ###     ####

	Some general purpose tools, used by the run-time and/or the
	Eiffel library classes.
*/

#include "eif_tools.h"
#include <stddef.h>					/* For size_t typedef. */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_public EIF_INTEGER hashcode(register char *s, register EIF_INTEGER count)
{
	/* Compute the hash code associated with given string s. The magic number
	 * below is the greatest prime lower than 2^23.
	 */

	register1 size_t hashval = 0;
	register2 int magic = 8388593;

	while (count--)
		hashval = ((hashval % magic) << 8) + (size_t) *s++;

	return (EIF_INTEGER) (hashval & 0x7fffffff);	/* Clear bit 31 (no unsigned in Eiffel) */
}

rt_public uint32 nprime(register uint32 n)
{
	/* Return the closest prime number greater than `n' */

	while (!prime(n))
		n++;

	return n;
}

rt_public int prime(register uint32 n)
{
	/* Return 1 if `n' is a prime number */

	register1 uint32 divisor;

	if (n == 1)
		return 0;
	else if (n == 2)
		return 1;
	else if (n % 2) {
		for (
			divisor = 3; 
			divisor * divisor <= n;
			divisor += 2
		)
			if (0 == (n % divisor))
				return 0;
		return 1;
	}
	return 0;
}

