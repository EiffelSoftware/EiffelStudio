/*

 ######  #    #   ####    ####   #####   ######           ####
 #       ##   #  #    #  #    #  #    #  #               #    #
 #####   # #  #  #       #    #  #    #  #####           #
 #       #  # #  #       #    #  #    #  #        ###    #
 #       #   ##  #    #  #    #  #    #  #        ###    #    #
 ######  #    #   ####    ####   #####   ######   ###     ####

	Encoding of C generated functions.
*/

#include "eif_macros.h" 				/* Access to Eiffel objects. */

#define BASE sizeof(encode_tbl)
#define ENCODE_LENGTH 7

#define FEAT_NAME_FLAG		0
#define ROUT_TABLE_FLAG		(((uint32)1<<30) + ((uint32)1<<29))
#define TYPE_TABLE_FLAG		(((uint32)1<<31) + ((uint32)1<<29))

/*
 * Function declarations.
 */

void eif000(char *eiffel_string, long int i, long int j);
void eif011(char *eiffel_string, long int i);
void eif101(char *eiffel_string, long int i);
/*
 * Static declarations.
 */

static void encode(char *s, uint32 n);				/* Encoder function */
static char encode_tbl[] = {		/* Corespondance table */
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
	'_', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
};


/*
 * Function definitions.
 */

void eif000(char *eiffel_string, long int i, long int j)
{
	/*
	 * Initialize the Eiffel string `eiffel_string' with an internal name
	 * for Eiffel features: the Eiffel string is supposed to be created
	 * with a size of ENCODE_LENGTH.
	 */

	char *s;


	/*
	 * 's' is a reference on the special object of the Eiffel string
	 */
	s = *(char **) eiffel_string;

	encode(s, ((uint32) i) + ((uint32) j << 15) + FEAT_NAME_FLAG);
}

void eif011(char *eiffel_string, long int i)
{
	char *s;

	/*
	 * 's' is a reference on the special object of the Eiffel string
	 */

	s = *(char **) eiffel_string;

	/*
	 * ROUT_TABLE_FLAG is the characteristic of routine table entry or an
	 * attribute offset entry
	 */
	encode(s, ((uint32) i) + ROUT_TABLE_FLAG);
}

void eif101(char *eiffel_string, long int i)
{
	char *s;

	s = *(char **) eiffel_string;

	/*
	 * TYPE_TABLE_FLAG is the characteristic of the type table name
	 */

	encode(s, ((uint32) i) + TYPE_TABLE_FLAG);
}

/*
 * Encoding of a number into a six-character string
 */

static void encode(char *s, uint32 n)
{
	int t;

	/*
	 * Encode number n in base BASE in string s
	 */
	for (s += 6, t = 1; t < ENCODE_LENGTH; t++) {
		*s-- = encode_tbl[n % BASE];
		n /= BASE;
	}
}

#ifdef TEST

static uint32 decode(char *s)
{
	/* Decode number 's' in base BASE from string 's' */

	uint32 n = 0;
	int i;
	int len = strlen(s);
	uint32 power = 1;

	for (i = 0; i < len; i++) {
		n += value(s[len - i - 1]) * power;
		power *= BASE;
	}

	return n;
}

static int value(char c)
{
	/* Value of digit 'c' in base BASE */
	
	int i;

	for (i = 0; i < BASE; i++)
		if (encode_tbl[i] == c)
			return i;
	
	return i;
}

#include <stdio.h>

main(void)
{
	char l[100];
	uint32 value;

	char toto [1000];
	strcpy (toto, "E000000");

	encode(toto, ((uint32) 12) + ((uint32) 14 << 15) + FEAT_NAME_FLAG);
	printf ("Encoded name: %s\n", toto);
	while (gets(l)) {
		value = decode(l);
		printf("%s is %d, %d\n", l, value / 32768, value % 32768);
	}
	exit(0);
}

#endif
