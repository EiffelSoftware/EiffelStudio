/*

 #####    ####    ####   #        ####    #####  #####            ####
 #    #  #    #  #    #  #       #          #    #    #          #    #
 #####   #    #  #    #  #        ####      #    #    #          #
 #    #  #    #  #    #  #            #     #    #####    ###    #
 #    #  #    #  #    #  #       #    #     #    #   #    ###    #    #
 #####    ####    ####   ######   ####      #    #    #   ###     ####

	Externals for class BOOL_STRING.
*/

#include "eif_portable.h"
#include "eif_boolstr.h"
#include <string.h>

rt_public char *bl_str_set(char *a1, int s, int n)
      			/* number of boolean in `a1' */
{
	int i;

	for (i = 0; i < s; i++)
		a1[i] = (char) n;	/* n value is either 0 or 1 */

	return a1;
}

rt_public char *bl_str_and(char *a1, char *a2, char *a3, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = (char) (a1[i] && a2[i]);

	return a3;
}

rt_public char *bl_str_or(char *a1, char *a2, char *a3, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = (char) (a1[i] || a2[i]);

	return a3;
}

rt_public char *bl_str_xor(char *a1, char *a2, char *a3, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = (char) (a1[i] ^ a2[i]);

	return a3;
}

rt_public char *bl_str_not(char *a1, char *a2, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a2[i] = (char) (!a1[i]);

	return a2;
}

rt_public char *bl_str_shiftr(char *a1, char *a2, int s, int n)
      			/* number of booleans in `a1' */
{
	/* Right shift `a1' by `n' positions */
	if (n < s)
		memcpy  (a2 + n * sizeof(char), a1, (s - n) * sizeof(char));
	else
		n = s;

	memset (a2, 0, n * sizeof (char));

	return a2;
}

rt_public char *bl_str_shiftl(char *a1, char *a2, int s, int n)
      			/* number of booleans in `a1' */
{
    int i;

	if (n < s)
		memcpy (a2, a1 + n * sizeof(char), (s - n) * sizeof(char));
	else
		n = s;

	for (i = 0; i < n; i++)
		a2[s-i-1] = '\0';

	return a2;
}

