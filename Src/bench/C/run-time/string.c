/*

  ####    #####  #####      #    #    #   ####            ####
 #          #    #    #     #    ##   #  #    #          #    #
  ####      #    #    #     #    # #  #  #               #
      #     #    #####      #    #  # #  #  ###   ###    #
 #    #     #    #   #      #    #   ##  #    #   ###    #    #
  ####      #    #    #     #    #    #   ####    ###     ####

	Externals for class STRING

*/

#include "eif_portable.h"
#include "eif_macros.h"			/* For EIF_FALSE|EIF_TRUE. */
#include "eif_str.h"
#include "eif_globals.h"
#include <ctype.h>
#include <string.h>

#include <stdio.h>					/* For sscanf() */

rt_private EIF_CHARACTER *make_string(EIF_CHARACTER *s, EIF_INTEGER length)
{
	/* Build a C string from the Eiffel string starting at 's', whose length
	 * is 'length'. This is for the sole purpose of string to numeric
	 * conversions. Hence any spurious null characters are ignored and we do
	 * not allow more than MAX_NUM_LEN into the built string.
	 * The function returns a pointer to a static buffer where string is held.
	 */

	
	register1 int i;			/* To loop over the string */
	register2 int l;			/* Length of string */
	register3 EIF_CHARACTER c;	/* Character read from string */
	
#ifndef EIF_THREADS
	static EIF_CHARACTER buffer [MAX_NUM_LEN + 1];
#else	/* !EIF_THREADS */
	EIF_CHARACTER *buffer;
	EIF_GET_CONTEXT			
	buffer = eif_string_buffer;		/* Per thread buffer. */
#endif	/* !EIF_THREADS */
	l = length > MAX_NUM_LEN ? MAX_NUM_LEN : length;

	for (i = 0; l > 0; l--) {
		c = *s++;
		if (c)			/* Do not copy embedded null characters */
			buffer[i++] = c;
	}

	buffer[i] = '\0';			/* Ensure null terminated string */

	return buffer;
}

/*
 * Stripping space characters.
 */

rt_public EIF_INTEGER str_left(register EIF_CHARACTER *str, EIF_INTEGER length)
{
	/* Remove all leading white spaces from `str'.
	 * Return the number of remaining characters.
	 */

	register2 int i;
	register3 EIF_CHARACTER *s = str;

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

rt_public void str_ljustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity)
{
	/* Remove all leading white spaces from `str'.
	 * Pad the right side with spaces.
	 */

	register2 int i;
	register3 EIF_CHARACTER *s = str;

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

rt_public void str_rjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity)
{
	/* Remove all trailing white spaces from `str'.
	 * Pad the left side with spaces.
	 */

	register2 int i;
	register3 EIF_CHARACTER *s;
	register4 EIF_CHARACTER *r;

	for (s = str+length-1, i = length; i > 0; i--, s--)
		if (!isspace(*s))
			break;
	for (r = str+capacity-1; i > 0; i--)
		*r-- = *s--;
	for (;r >= str;)
		*r-- = ' ';
}

rt_public void str_cjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity)
{
	/* Remove all leading and trailing white spaces from `str'.
	 * Pad both sides with spaces.
	 */

	register2 int i;
	register3 EIF_CHARACTER *s;
	register4 EIF_CHARACTER *r;
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


rt_public EIF_INTEGER str_right(register EIF_CHARACTER *str, EIF_INTEGER length)
{
	/* Remove all trailing white spaces from `str'.
	 * Return the new number of remaining characters.
	 */

	register2 EIF_CHARACTER *s;

	/* Find first non-space character starting from rightmost end */
	for (s = str + length - 1; s >= str; s--)
		if (!isspace(*s))
			break;

	return s >= str ? s - str + 1: 0;
}

/*
 * Search and replace.
 */

rt_public void str_replace(EIF_CHARACTER *str, EIF_CHARACTER *new, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER start, EIF_INTEGER end)
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
	register2 EIF_CHARACTER *f;		/* From address for byte copy */
	register3 EIF_CHARACTER *t;		/* To address for byte copy */

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
	 * 'start' index. We cannot use memcpy  here, as `str' and `new' can point
	 * to the same area.
	 */
	
	memmove (str + (start - 1),new,  new_len);
}

rt_public void str_insert(EIF_CHARACTER *str, EIF_CHARACTER *new, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER idx)
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
	register2 EIF_CHARACTER *f;		/* From address for byte copy */
	register3 EIF_CHARACTER *t;		/* To address for byte copy */

	/* First shift all the string from 'new_len' positions to the right,
	 * starting at 'idx'.
	 */

	f = str + (string_length - 1);	/* Address of last character in string */
	string_length += new_len;			/* String gains that many characters */
	t = str + (string_length - 1);	/* New address of last character */
		for (i = string_length - new_len - idx + 1; i > 0; i--)
			*t-- = *f--;

	/* Now copy the string at the beginning. No overlap is to be feared, so we
	 * may safely use memcpy ().
	 */

	memcpy (str + idx - 1, new, new_len);
}

/*
 * Prepending a character, appending a string.
 */

rt_public void str_cprepend(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l)
          		/* The string */
       			/* The character to prepend */
      			/* And Her Majesty, the Length */
{
	/*  Prepend `c' to `str' */

	register1 EIF_CHARACTER *f;	/* From */
	register2 EIF_CHARACTER *t;	/* To */

	for (f = str + l - 1, t = f + 1; l > 0; l--)
		*t-- = *f--;

	*str = c;
}

/*
 * Removing characters.
 */

rt_public void str_rmchar(EIF_CHARACTER *str, EIF_INTEGER l, EIF_INTEGER i)
          		/* The string */
      			/* String length */
      			/* Index of character to be removed */
{
	/* Remove 'i'-th character from 'str', shifting the remaining string to
	 * fill-in the hole.
	 */

	register1 int j;		/* Number of characters to shift */
	register2 EIF_CHARACTER *f;		/* From address for copy */
	register3 EIF_CHARACTER *t;		/* To address for copy */

	f = str + i;			/* First character kept */
	t = f - 1;				/* Shifting left from one EIF_CHARACTER */

	for (j = (str + l) - f; j > 0; j--)
		*t++ = *f++;
}

rt_public EIF_INTEGER str_rmall(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l)
          		/* The string */
       			/* Character to be removed */
      			/* Length of string */
{
	/* Remove all occurrences of `c' in `str'.
	 * Return new number of character making up `str'.
	 */

	EIF_INTEGER new;		/* New string length */
	EIF_CHARACTER *top;		/* String viewed as a stack (first free location) */

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
 * Conversions from ASCII to numeric values.
 */

rt_public EIF_INTEGER str_atoi(EIF_CHARACTER *str, EIF_INTEGER length)
{
	/* Value of integer in `str' */

	EIF_CHARACTER *s = make_string(str, (int) length);
	EIF_INTEGER val;

	sscanf((char *) s, "%d", &val);
	return val;
}

rt_public float str_ator(EIF_CHARACTER *str, EIF_INTEGER length)
{
	/* Value of real in `str' */

	EIF_CHARACTER *s = make_string(str, length);
	float val;

	sscanf((char *) s, "%f", &val);
	return val;
}

rt_public double str_atod(EIF_CHARACTER *str, EIF_INTEGER length)
{
	/* Value of double in `str' */

	EIF_CHARACTER *s = make_string(str, length);
	double val;

	sscanf((char *) s, "%lf", &val);
	return val;
}

/*
 * Test for numeric values.
 */

rt_public EIF_BOOLEAN str_isi (EIF_CHARACTER *str, EIF_INTEGER length)
{
    /* Is it an integer? 
	 * We use a finite-state automaton which is faster than it is with
	 * `sscanf ()'.
	 * State 0: nothing read yet. 
	 * State 1: '+' or '-' read.
	 * State 2: in the number.
	 * State 3: after the number.
	 * State 4: Error.
	 */	

	int state = 0;					/* Current state. */
    EIF_CHARACTER c;							/* Current character read. */
    EIF_BOOLEAN ret = EIF_FALSE;	/* Return value. */


	/* [separator|\0][-|+][separator|\0][0-9|\0]*[separator|\0]
     * is considered as an integer. 
	 * We also have to take into account the Null character
	 * that an Eiffel String can contain. 
	 */

    for (; length > 0 && state < 4; length--) {
        c = *str++;
        switch (state) {
            case 0:
                if (c == '\0' || isspace (c))
                    break;
                else if (c == '+' || c == '-')
                    state = 1;
                else if (isdigit(c)) {
                    state = 2;
                    ret = EIF_TRUE;
                }
                else {
                    state = 4;
                    ret = EIF_FALSE;
                }
                break;

            case 1:
                if (c == '\0' || isspace (c))
                    break;
                else if (isdigit(c)) {
                    state = 2;
                    ret = EIF_TRUE;
                }
                else
                    ret = EIF_FALSE;
                break;

            case 2:
                if (isdigit (c) || c == '\0')
                    break;
                else if (isspace (c))
                    state = 3;
                else {
                    state = 4;
                    ret = EIF_FALSE;
                }
                break;

            case 3:
                if (c == '\0' || isspace (c))
                    break;
                else
                    state = 4;
                    ret = EIF_FALSE;
                break;
        }
    }
    return ret;
}	/* str_isi (). */

rt_public EIF_BOOLEAN str_isr(EIF_CHARACTER *str, EIF_INTEGER length)
{
	/* Is it a real? */

	EIF_CHARACTER *s = make_string (str, length);
	float val;
	EIF_CHARACTER c;

	return EIF_TEST(sscanf((char *) s, "%f %c", &val, &c) == 1);
}

rt_public EIF_BOOLEAN str_isd(EIF_CHARACTER *str, EIF_INTEGER length)
{
	/* Is is a double? */

	EIF_CHARACTER *s = make_string (str, length);
	double val;
	EIF_CHARACTER c;

	return EIF_TEST(sscanf((char *) s, "%lf %c", &val, &c) == 1);
}
