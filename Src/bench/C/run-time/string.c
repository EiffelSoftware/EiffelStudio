/*

  ####    #####  #####      #    #    #   ####            ####
 #          #    #    #     #    ##   #  #    #          #    #
  ####      #    #    #     #    # #  #  #               #
      #     #    #####      #    #  # #  #  ###   ###    #
 #    #     #    #   #      #    #   ##  #    #   ###    #    #
  ####      #    #    #     #    #    #   ####    ###     ####

	Externals for class STRING

*/

#include "eif_config.h"
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif
#include "eif_str.h"
#include "eif_globals.h"
#include <ctype.h>

#include <stdio.h>					/* For sscanf() */

#define MAX_NUM_LEN		256			/* Maximum length for an ASCII number */

rt_private char *make_string(char *s, int length)
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
		if ((c = *s++))			/* Do not copy embedded null characters */
			buffer[i++] = c;

	buffer[i] = '\0';			/* Ensure null terminated string */

	return buffer;
}

/*
 * Stripping space characters.
 */

rt_public int str_left(register char *str, int length)
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
/*
 * Justifying strings
 */

rt_public void str_ljustify(register char *str, int length, int capacity)
{
	/* Remove all leading white spaces from `str'.
	 * Pad the right side with spaces.
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

	for (;i < capacity; i++)
		*s++ = ' ';
}

rt_public void str_rjustify(register char *str, int length, int capacity)
{
	/* Remove all trailing white spaces from `str'.
	 * Pad the left side with spaces.
	 */

	register2 int i;
	register3 char *s;
	register4 char *r;

	for (s = str+length-1, i = length; i > 0; i--, s--)
		if (!isspace(*s))
			break;
	for (r = str+capacity-1; i > 0; i--)
		*r-- = *s--;
	for (;r >= str;)
		*r-- = ' ';
}

rt_public void str_cjustify(register char *str, int length, int capacity)
{
	/* Remove all leading and trailing white spaces from `str'.
	 * Pad both sides with spaces.
	 */

	register2 int i;
	register3 char *s;
	register4 char *r;
	register5 int offset;

	/* Set the right hand end to spaces */
	str_ljustify (str, length, capacity);
	/* Find first non space on right */
	for (r = str + capacity -1, i = capacity; i > 0; i --, r--)
		if (!isspace (*r))
			break;
	/* Offset calculation */
	offset = (capacity - i) / 2;
	for (s = str + offset; i > offset; i --)
		*s-- = *r--;
	for (;i > 0; i --)
		*s-- = ' ';	

}


rt_public int str_right(register char *str, int length)
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

rt_public int str_search(char *str, char c, int start, int len)
          		/* The string */
       			/* Character to look at */
          		/* Index in string where search starts */
        		/* Length of the string */
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

rt_public int str_last_search (char *str, char c, int start_index_from_end)
			/* The string */
			/* character to look at */
			/* start index length of the string */
{
	register1 char *s;	/* To walk through the string */
	register2 int i;	/* Index in string */

	i = start_index_from_end - 1;		/* C index starts at 0*/
	s = str + i;

	for (; i > 0; i--)
		if (*s-- == c)
			break;

	return (i > 0) ? ++i : 0;
}

rt_public void str_replace(char *str, char *new, int string_length, int new_len, int start, int end)
          			/* The original string */
          			/* The new string for substring replacement */
                  	/* Length of the original string */
            		/* Length of the replacing substring */
          			/* Index within string where replacement starts */
        			/* Index within string where replacement stops */
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
		f = str + (string_length - 1);	/* Address of last character in string */
		string_length += (new_len - i);	/* String gains that many characters */
		t = str + (string_length - 1);	/* New address of last character */
		for (i = f - (str + end - 1); i > 0; i--)
			*t-- = *f--;
	} else if (i > new_len) {
		f = str + end;				/* First character after replacement spot */
		t = str + (start - 1);		/* Address of first character replaced */
		t += new_len;				/* Where first char after substring comes */
		for (i = (str + string_length) - f; i > 0; i--)
			*t++ = *f++;
	}

	/* Now there is room to copy the replacement string as is, starting at the
	 * 'start' index. We may safely use bcopy here, as there is no overlapping.
	 */
	
	bcopy(new, str + (start - 1), new_len);
}

rt_public void str_insert(char *str, char *new, int string_length, int new_len, int idx)
          			/* The original string */
          			/* The new string to be inserted */
                  		/* Length of the original string */
            		/* Length of the inserted substring */
        			/* Index within string where insertion begins */
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

	f = str + (string_length - 1);	/* Address of last character in string */
	string_length += new_len;			/* String gains that many characters */
	t = str + (string_length - 1);	/* New address of last character */
		for (i = string_length - new_len - idx + 1; i > 0; i--)
			*t-- = *f--;

	/* Now copy the string at the beginning. No overlap is to be feared, so we
	 * may safely use bcopy().
	 */

	bcopy(new, str + idx - 1, new_len);
}

/*
 * General routines.
 */

rt_public EIF_INTEGER str_code(EIF_CHARACTER *str, EIF_INTEGER i)
{
	return (EIF_INTEGER) str[i-1]; /* Numeric code of 'i'-th character in 'str' */
}

rt_public void str_blank(char *str, int n)
{
	/* Fill 'str' with 'n' blanks */

	int i;

	for (i = 0; i < n; i++)
		*str++ = ' ';
}

rt_public void str_fill(char *str, int n, char c)
{
	/* Fill 'str' with 'n'  `c' */

	int i;

	for (i = 0; i < n; i++)
		*str++ = c;
}

rt_public void str_tail(register char *str, register int n, int l)
                    	/* The string */
                		/* Number of characters to keep at the tail */
      					/* Length of the string */
{
	/* Remove all characters in `str' except for the last `n' */

	register2 char *f;		/* From address for copy */

	for (f = str + (l - n); n > 0; n--)
		*str++ = *f++;
}

rt_public void str_take(char *str, char *new, long int start, long int end)
          			/* The original string */
          			/* The to-be-filled substring */
           			/* First char index in string 'str' to be copied */
         			/* Last char index in string 'str' to be copied */
{
	/* Extract the substring (start, end) from 'str' into 'new' */

	bcopy (str + start - 1, new, end - start + 1);
}

/*
 * String case conversions.
 */

rt_public void str_lower(register char *str, int l)
{
	/* Convert 'str' to lower case */

	register2 char c;

	while (l-- > 0) {
		c = *str;
		*str = tolower(c);
		str++;
	}
}

rt_public void str_upper(register char *str, int l)
{
	/* Convert `str' to upper case */

	register2 char c;

	while (l-- > 0) {
		c = *str;
		*str = toupper(c);
		str++;
	}
}

rt_public int str_cmp(register char *str1, register char *str2, int l1, int l2)
{
	/* Compare the two strings 'str1' and 'str2'.
	 * Return the sign of 'str1 - str2'.
	 */

	if (l2 == l1)
		return (strncmp (str1, str2, l1) > 0);
	else {
		if (l2 < l1) 
			return (strncmp (str1, str2, l2) >= 0);
		else
			return (strncmp (str1, str2, l1) > 0);
	}

}

rt_public void str_cpy(char *to, char *from, int len)
{
	/*  Copy 'len' characters from 'from' to 'to' */

	bcopy (from, to, len);
}

/*
 * Prepending a character, appending a string.
 */

rt_public void str_cprepend(char *str, char c, int l)
          		/* The string */
       			/* The character to prepend */
      			/* And Her Majesty, the Length */
{
	/*  Prepend `c' to `str' */

	register1 char *f;	/* From */
	register2 char *t;	/* To */

	for (f = str + l - 1, t = f + 1; l > 0; l--)
		*t-- = *f--;

	*str = c;
}

rt_public void str_append(char *str, char *new, int string_length, int new_len)
          			/* The original string */
          			/* The new string to be appended */
                  		/* Length of the original string */
            		/* Length of the appended substring */
{
	/* Append 'new' at the end of 'str' */

	bcopy (new, str + string_length, new_len);
}

/*
 * Removing characters.
 */

rt_public void str_rmchar(char *str, int l, int i)
          		/* The string */
      			/* String length */
      			/* Index of character to be removed */
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

rt_public int str_rmall(char *str, char c, int l)
          		/* The string */
       			/* Character to be removed */
      			/* Length of string */
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

rt_public void str_mirror(register char *str, register char *new, register int len)
                    	/* The string to reverse */
                    	/* Where the reversed string goes */
                  		/* Length of the string to be reversed */
{
	/* Build a new string into 'new' which is the mirror copy of the original
	 * string held in 'str'.
	 */

	str += len - 1;		/* Go to the end of the string */

	while (len-- > 0)
		*new++ = *str--;
}

rt_public void str_reverse(register char *str, int len)
                    	/* The string to reverese */
        				/* Length of the string to be reversed */
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

rt_public long str_atoi(char *str, int length)
{
	/* Value of integer in `str' */

	char *s = make_string(str, length);
	long val;

	sscanf(s, "%ld", &val);
	return val;
}

rt_public float str_ator(char *str, int length)
{
	/* Value of real in `str' */

	char *s = make_string(str, length);
	float val;

	sscanf(s, "%f", &val);
	return val;
}

rt_public double str_atod(char *str, int length)
{
	/* Value of double in `str' */

	char *s = make_string(str, length);
	double val;

	sscanf(s, "%lf", &val);
	return val;
}

/*
 * Test for numeric values.
 */

rt_public EIF_BOOLEAN str_isi(char *str, EIF_INTEGER length)
{
	/* Is it an integer? */

	char *s = make_string(str, length);
	long val;
	char c;
	return (sscanf(s, "%ld %c", &val, &c) == 1)?(EIF_BOOLEAN) '\1': (EIF_BOOLEAN) '\0';
}

rt_public EIF_BOOLEAN str_isr(char *str, EIF_INTEGER length)
{
	/* Is it a real? */

	char *s = make_string(str, length);
	float val;
	char c;

	return (sscanf(s, "%f %c", &val, &c) == 1)?(EIF_BOOLEAN) '\1': (EIF_BOOLEAN) '\0';
}

rt_public EIF_BOOLEAN str_isd(char *str, EIF_INTEGER length)
{
	/* Is is a double? */

	char *s = make_string(str, length);
	double val;
	char c;

	return (sscanf(s, "%lf %c", &val, &c) == 1)?(EIF_BOOLEAN) '\1': (EIF_BOOLEAN) '\0';
}

/*
 * To avoid redeclaration conflicts...
 */

rt_public long str_len(char *str)
{
	return strlen(str);
}

