/*

 #####    ####    ####   #        ####    #####  #####            ####
 #    #  #    #  #    #  #       #          #    #    #          #    #
 #####   #    #  #    #  #        ####      #    #    #          #
 #    #  #    #  #    #  #            #     #    #####    ###    #
 #    #  #    #  #    #  #       #    #     #    #   #    ###    #    #
 #####    ####    ####   ######   ####      #    #    #   ###     ####

	Externals for class BOOL_STRING.
*/

#include "config.h"
#include "portable.h"

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

rt_public char *bl_str_set(a1, s, n)
char *a1;
int s;			/* number of boolean in `a1' */
int n;
{
	int i;

	for (i = 0; i < s; i++)
		a1[i] = (char) n;	/* n value is either 0 or 1 */

	return a1;
}

rt_public char *bl_str_and(a1, a2, a3, s)
char *a1, *a2, *a3;
int s;
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = a1[i] && a2[i];

	return a3;
}

rt_public char *bl_str_or(a1, a2, a3, s)
char *a1, *a2, *a3;
int s;
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = a1[i] || a2[i];

	return a3;
}

rt_public char *bl_str_xor(a1, a2, a3, s)
char *a1, *a2, *a3;
int s;
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = a1[i] ^ a2[i];

	return a3;
}

rt_public char *bl_str_not(a1, a2, s)
char *a1, *a2;
int s;
{
	int i;

	for (i = 0; i < s; i++)
		a2[i] = !a1[i];

	return a2;
}

rt_public char *bl_str_shiftr(a1, a2, s, n)
char *a1, *a2;
int s;			/* number of booleans in `a1' */
int n;
{
	/* Right shift `a1' by `n' positions */

	int i;

	if (n < s)
		bcopy (a1, a2 + n * sizeof(char), (s - n) * sizeof(char));
	else
		n = s;

/* FIXME: use bzero or equiv */
	for (i = 0; i < n; i++)
		a2[i] = '\0';

	return a2;
}

rt_public char *bl_str_shiftl(a1, a2, s, n)
char *a1, *a2;
int s;			/* number of booleans in `a1' */
int n;
{
    int i;

	if (n < s)
		bcopy (a1 + n * sizeof(char), a2, (s - n) * sizeof(char));
	else
		n = s;

	for (i = 0; i < n; i++)
		a2[s-i-1] = '\0';

	return a2;
}

