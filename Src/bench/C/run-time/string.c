/*

  ####    #####  #####      #    #    #   ####            ####
 #          #    #    #     #    ##   #  #    #          #    #
  ####      #    #    #     #    # #  #  #               #
      #     #    #####      #    #  # #  #  ###   ###    #
 #    #     #    #   #      #    #   ##  #    #   ###    #    #
  ####      #    #    #     #    #    #   ####    ###     ####

	Externals for class STRING

*/

#include "config.h"
#include "portable.h"
#include "string.h"
#include <ctype.h>

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#define MAX_NUM_LEN		256			/* Maximum length for an ASCII number */

private char *make_string(s, length)
char *s;
int length;
{
	/* Build a C string from the Eiffel string starting at 's', whose length
	 * is 'length'. This is for the sole purpose of string to numeric
	 * conversions. Hence any spurious null characters are ignored and we do
	 * not allow more than MAX_NUM_LEN into the built string.
	 * The function returns a pointer to a static buffer where string is held.
	 */

	static char buffer[MAX_NUM_LEN + 1];	/* Where string is built */
	register1 int i;			/* To loop over the string */
	register2 int l;			/* Length of string */
	register3 int c;			/* Character read from string */
	
	l = length > MAX_NUM_LEN ? MAX_NUM_LEN : length;

	for (i = 0; l > 0; l--)
		if (c = *s++)			/* Do not copy embeded null characters */
			buffer[i++] = c;

	buffer[i] = '\0';			/* Ensure null terminated string */

	return buffer;
}

/*
 * Stripping space characters.
 */

public int str_left(str, length)
register1 char *str;
int length;
{
	/* Remove all leading white spaces from `str'.
	 * Return the number of remaining characters.
	 */

	register2 int i;
	register3 char *s = str;

	/* Find first non-space character starting from leftmost end */
	for (i = 0; i < length; i++, s++)
		if (!isspace(*s))
			break;
	
	length -= i;		/* Remove space characters from length */

	/* Shift remaining of string to the left */
	for (s = str, str += i, i = 0;  i < length; i++)
		*s++ = *str++;

	return length;		/* New string length */
}

public int str_right(str, length)
register1 char *str;
int length;
{
	/* Remove all trailing white spaces from `str'.
	 * Return the new number of remaining characters.
	 */

	register2 char *s;

	/* Find first non-space character starting from rightmost end */
	for (s = str + length - 1; s >= str; s--)
		if (!isspace(*s))
			break;

	return s >= str ? s - str + 1: 0;
}

/*
 * Search and replace.
 */

public int str_search(str, c, start, len)
char *str;		/* The string */
char c;			/* Character to look at */
int start;		/* Index in string where search starts */
int len;		/* Length of the string */
{
	/* Look for the first occurrence of 'c' within the string 'str', starting
	 * a index 'start'. If the character is found, return its position (1 is
	 * the leftmost character), otherwise return 0.
	 */

	register1 char *s;		/* To walk through the string */
	register2 int i;		/* Index in string */

	i = start - 1;			/* C index starts at 0 */
	s = str + i;			/* Where shall we start looking at */

	for (; i < len; i++)
		if (*s++ == c)
			break;

	return i < len ? ++i : 0;
}

public void str_replace(str, new, str_len, new_len, start, end)
char *str;			/* The original string */
char *new;			/* The new string for substring replacement */
int str_len;		/* Length of the original string */
int new_len;		/* Length of the replacing substring */
int start;			/* Index within string where replacement starts */
int end;			/* Index within string where replacement stops */
{
	/* The substring (start, end) within 'str' is replaced by the strin 'new'.
	 * The resulting string extends or shrinks accordingly. Of course, it is
	 * up to the caller to ensure that there is enough room at the end of the
	 * 'str' arena to make the expansion, if necessary.
	 */

	register1 int i;		/* Length of replacement spot */
	register2 char *f;		/* From address for byte copy */
	register3 char *t;		/* To address for byte copy */

	i = end - start + 1;	/* Characters in the replacement spot */

	/* If the new string is longer than the replacement spot, then we need to
	 * shift the tail before copying the new string in place. Otherwise, if
	 * the string is shorter, then the original string shrinks and again the
	 * final characters are moved before the replacement occurs.
	 */

	if (i < new_len) {
		f = str + (str_len - 1);	/* Address of last character in string */
		str_len += (new_len - i);	/* String gains that many characters */
		t = str + (str_len - 1);	/* New address of last character */
		for (i = f - (str + end - 1); i > 0; i--)
			*t-- = *f--;
	} else if (i > new_len) {
		f = str + end;				/* First character after replacement spot */
		t = str + (start - 1);		/* Address of first character replaced */
		t += new_len;				/* Where first char after substring comes */
		for (i = (str + str_len) - f; i > 0; i--)
			*t++ = *f++;
	}

	/* Now there is room to copy the replacement string as is, starting at the
	 * 'start' index. We may safely use bcopy here, as there is no overlapping.
	 */
	
	bcopy(new, str + (start - 1), new_len);
}

public void str_insert(str, new, str_len, new_len, idx)
char *str;			/* The original string */
char *new;			/* The new string to be inserted */
int str_len;		/* Length of the original string */
int new_len;		/* Length of the inserted substring */
int idx;			/* Index within string where insertion begins */
{
	/* Insert 'new' at the left of 'idx' within 'str'. The remaining of the
	 * original string is shifted to the right accordingly.
	 */

	register int i;			/* Number of character to shift */
	register2 char *f;		/* From address for byte copy */
	register3 char *t;		/* To address for byte copy */

	/* First shift all the string from 'new_len' positions to the right,
	 * starting at 'idx'.
	 */

	f = str + (str_len - 1);	/* Address of last character in string */
	str_len += new_len;			/* String gains that many characters */
	t = str + (str_len - 1);	/* New address of last character */
		for (i = str_len - new_len - idx + 1; i > 0; i--)
			*t-- = *f--;

	/* Now copy the string at the beginning. No overlap is to be feared, so we
	 * may safely use bcopy().
	 */

	bcopy(new, str + idx - 1, new_len);
}

/*
 * General routines.
 */

public int str_code(str, i)
char *str;
int i;
{
    return (int) str[i-1];	/* Numeric code of 'i'-th character in 'str' */
}

public void str_blank(str, n)
char *str;
int n;
{
	/* Fill 'str' with 'n' blanks */

	int i;

    for (i = 0; i < n; i++)
        *str++ = ' ';
}

public void str_tail(str, n, l)
register3 char *str;	/* The string */
register1 int n;		/* Number of characters to keep at the tail */
int l;					/* Length of the string */
{
	/* Remove all characters in `str' except for the last `n' */

	register2 char *f;		/* From address for copy */

	for (f = str + (l - n); n > 0; n--)
		*str++ = *f++;
}

public void str_take(str, new, start, end)
char *str;			/* The original string */
char *new;			/* The to-be-filled substring */
long start;			/* First char index in string 'str' to be copied */
long end;			/* Last char index in string 'str' to be copied */
{
	/* Extract the substring (start, end) from 'str' into 'new' */

	bcopy (str + start - 1, new, end - start + 1);
}

/*
 * String case conversions.
 */

public void str_lower(str, l)
register1 char *str;
int l;
{
	/* Convert 'str' to lower case */

	register2 char c;

    while (l-- > 0) {
		c = *str;
        if (isupper(c))
            *str = tolower(c);
        str++;
	}
}

public void str_upper(str, l)
register1 char *str;
int l;
{
	/* Convert `str' to upper case */

	register2 char c;

    while (l-- > 0) {
		c = *str;
        if (islower(c))
            *str = toupper(c);
        str++;
	}
}

/*
 * Comparaison and copy.
 */

public int str_cmp(str1, str2, l1, l2)
register1 char *str1;
register2 char *str2;
int l1;
int l2;
{
	/* Compare the two strings 'str1' and 'str2'.
	 * Return the sign of 'str1 - str2'.
	 */

	register3 int c1;
	register4 int c2;

	for (; l1 > 0 && l2 > 0; l1--, l2--) {
		c1 = *str1++;
		c2 = *str2++;
		if (c1 != c2)
			return c1 > c2 ? 1 : -1;
	}

	return (l1 + l2) == 0 ? 0 : (l1 > l2 ? 1 : -1);
}

public void str_cpy(to, from, len)
char *to;
char *from;
int len;
{
	/*  Copy 'len' characters from 'from' to 'to' */

	bcopy (from, to, len);
}

/*
 * Prepending a character, appending a string.
 */

public void str_cprepend(str, c, l)
char *str;		/* The string */
char c;			/* The character to prepend */
int l;			/* And Her Majesty, the Length */
{
	/*  Prepend `c' to `str' */

	register1 char *f;	/* From */
	register2 char *t;	/* To */

	for (f = str + l - 1, t = f + 1; l > 0; l--)
		*t-- = *f--;

    *str = c;
}

public void str_append(str, new, str_len, new_len)
char *str;			/* The original string */
char *new;			/* The new string to be appended */
int str_len;		/* Length of the original string */
int new_len;		/* Length of the appended substring */
{
	/* Append 'new' at the end of 'str' */

	bcopy (new, str + str_len, new_len);
}

/*
 * Removing characters.
 */

public void str_rmchar(str, l, i)
char *str;		/* The string */
int l;			/* String length */
int i;			/* Index of character to be removed */
{
	/* Remove 'i'-th character from 'str', shifting the remaining string to
	 * fill-in the hole.
	 */

	register1 int j;		/* Number of characters to shift */
	register2 char *f;		/* From address for copy */
	register3 char *t;		/* To address for copy */

	f = str + i;			/* First character kept */
	t = f - 1;				/* Shifting left from one char */

	for (j = (str + l) - f; j > 0; j--)
		*t++ = *f++;
}

public int str_rmall(str, c, l)
char *str;		/* The string */
char c;			/* Character to be removed */
int l;			/* Length of string */
{
	/* Remove all occurrences of `c' in `str'.
     * Return new number of character making up `str'.
	 */

	int new;		/* New string length */
	char *top;		/* String viewed as a stack (first free location) */

	top = str;
	new = 0;

    while (l-- > 0) {
        if (*str++ != c) {
			*top++ = *(str - 1);
			new++;
		}
	}

	return new;
}

/*
 * String reversing.
 */

public void str_mirror(str, new, len)
register1 char *str;	/* The string to reverse */
register2 char *new;	/* Where the reversed string goes */
register3 int len;		/* Length of the string to be reversed */
{
	/* Build a new string into 'new' which is the mirror copy of the original
	 * string held in 'str'.
	 */

	str += len - 1;		/* Go to the end of the string */

	while (len-- > 0)
		*new++ = *str--;
}

public void str_reverse(str, len)
register1 char *str;	/* The string to reverese */
int len;				/* Length of the string to be reversed */
{
	/* In-place reverse string 'str' */

	register2 char *end;	/* Pointer from the end of the string */
	register3 int c;		/* Swapping variable */

	end = str + (len - 1);	/* Go to the end of the string */

	while (end >= str) {
		c = *end;
		*end-- = *str;
		*str++ = c;
	}
}

/*
 * Conversions from ASCII to numeric values.
 */

public long str_atoi(str, length)
char *str;
int length;
{
	/* Value of integer in `str' */

	char *s = make_string(str, length);
	long val;

	sscanf(s, "%ld", &val);
	return val;
}

public float str_ator(str, length)
char *str;
int length;
{
	/* Value of real in `str' */

	char *s = make_string(str, length);
	float val;

    sscanf(s, "%f", &val);
    return val;
}

public double str_atod(str, length)
char *str;
int length;
{
	/* Value of double in `str' */

	char *s = make_string(str, length);
	double val;

	sscanf(s, "%lf", &val);
    return val;
}

/*
 * To avoid redeclaration conflicts...
 */

public long str_len(str)
char *str;
{
	return strlen(str);
}

