/*
	UU.C - uuencoding and decoding routines

	uuencode is a simple algorithm to convert strings of binary data to
	ASCII streams.  Every 3 characters of input gets converted to 4 character
		on output

	uudecode is the reverse.
*/

#include "eif_eiffel.h"
#include "windows.h"
#include "uu.h"

#define ENC(c) (((c) & 077) + ' ')

/*
	uuencode a string `s' and put the result in `Result'
*/

void uuencode (char s[], char *Result)
{
	/* s is 3 characters to be uuencode */
	*Result = (char) (ENC(s[0] >> 2));
	*(Result+1) = (char) (ENC(s[0] << 4 & 060 | s[1] >> 4 & 017));
	*(Result+2) = (char) (ENC(s[1] << 2 & 074 | s[2] >> 6 & 03));
	*(Result+3) = (char) (ENC(s[2] & 077));
}

#define DEC(c) (((c) - ' ') & 077)


/*
	uudecode a string `s' and put the result in `Result'
*/

void uudecode (char s[], char *Result)
{
	/* s is 4 characters to be uudecoded */
	*Result = (char) (DEC(s[0]) << 2 | DEC(s[1]) >> 4);
	*(Result+1) = (char) (DEC(s[1]) << 4 | DEC(s[2]) >> 2);
	*(Result+2) = (char) (DEC(s[2]) << 6 | DEC(s[3]));
}


/*
	uudecode the string s
*/

char *uudecode_str (char *s)
{
	char *Result, *i, *j;

	Result = (char *) calloc (strlen(s) / 4 * 3+1,1);
	for (i = s, j = Result; i < s+strlen(s); i += 4, j += 3)
		uudecode (i, j);
	return Result;
}

/*
	uuencode the string s for a length size.  This allows for strings with \0 in them
	I got the routine from a newsgroup referring to somewhere on a DEC site.
*/

char *uuencode_str (char *s, int size)
{
	char *Result, *i, *j, *t;
	int sz;

	sz = (size * 4 + 2) / 3;
	if (sz % 4)
		sz += 4 - (sz % 4);
	Result = (char *) calloc (sz+1,1);
	for (i = s, j = Result; i < s+size; i += 3, j += 4)
		if (s+size-i < 3)
			{
			t = (char *) calloc (3,1);
			memcpy (t, i, s+size-i);
			uuencode (t,j);
			free (t);
			}
		else
			uuencode (i, j);
	return Result;
}
