/*

 #####     ##     #####   #####  ######  #####   #    #           ####
 #    #   #  #      #       #    #       #    #  ##   #          #    #
 #    #  #    #     #       #    #####   #    #  # #  #          #
 #####   ######     #       #    #       #####   #  # #   ###    #
 #       #    #     #       #    #       #   #   #   ##   ###    #    #
 #       #    #     #       #    ######  #    #  #    #   ###     ####

	Pattern matching (substrings, not regular expressions).

	The algorithm used is the one described in Communications of the ACM,
	volume 33, number 8, August 1990, by Daniel M. Sunday. The fuzzy
	version was presented by Peter R. Sibbald in Communications of the
	ACM, volume 35, number 4, April 1992 (Technical Correspondance).
*/

#include "config.h"
#include "portable.h"
#include "malloc.h"
#include "hector.h"
#include "except.h"
#include "eif_globals.h"

/* #define ASIZE	256 *//* The alphabet's size */ /* %%ss moved to eif_contants.h */

rt_private uint32 delta[ASIZE];	/* Records shifting deltas */ /* %%ss mt */
rt_private uint32 **darray;		/* Pointer to array recording shifting tables */ /* %%ss mt */

rt_private void compile(char *pattern, register int plen, uint32 *dtable);			/* Regular pattern compilation */
rt_private void fuz_compile(EIF_OBJ pattern, register int plen, int fuzzy);		/* Fuzzy pattern compilation */
rt_private void free_structures(int n);	/* Free fuzzy shifting tables */
rt_private char *qsearch(char *text, int tlen, char *pattern, int plen);		/* Sunday's Quick Search algorithm */
rt_private char *fuz_qsearch(char *text, int tlen, char *pattern, int plen, int fuzzy);	/* Fuzzy version of Quick Search */

rt_public int str_str(EIF_CONTEXT EIF_OBJ text, EIF_OBJ pattern, int tlen, int plen, int start, int fuzzy)
             		/* The text string */
                	/* The pattern we are looking for */
         			/* Length of the text */
         			/* Length of the pattern */
          			/* Index within text where search starts */
          			/* Fuzzy matching quantifier (0 = perfect matching) */
{
	/* Forward search of 'pattern' within 'text' starting at 'start'. Return
	 * the index within 'text' where the pattern was located, 0 if not found
	 * (this is an Eiffel index, starting at 1).
	 * The 'fuzzy' parameter is the maximum allowed number of mismatches within
	 * the pattern. A 0 means an exact match. For efficiency reasons, I use a
	 * special version of the algorithm for perfect matches, although the fuzzy
	 * one is a generalization--RAM.
	 * NB: as the fuzzy pattern matching uses malloc(), the Eiffel side must
	 * give us protected addresses.
	 */

	EIF_GET_CONTEXT
	char *p;			/* Returned address from quick search algorithm */

	if (fuzzy < 0)		/* Invalid fuzzy parameter */
		return 0;

	if (fuzzy >= plen)	/* More mismatches than the pattern length */
		return start;	/* Anything matches */

	start--;			/* Convert index to C one (start at 0) */

	/* Exact matching does not use any memory allocation at all, so it is safe
	 * to use eif_access() now to pass true addresses.
	 * Fuzzy pattern matching uses memory allocation to store the delta tables.
	 * This means we have to pass EIF_OBJ pointers to the pattern compilation
	 * routine. But once compile is done, no more memory allocation is needed
	 * and then we may pass the true pointer to the search function, which is
	 * nice.
	 */

	if (fuzzy == 0) {
		compile(eif_access(pattern), plen, delta);		/* Compile pattern */
		p = qsearch(eif_access(text) + start, tlen-start,
			eif_access(pattern), plen);					/* Quick search */
	} else {
		fuz_compile(pattern, plen, fuzzy);				/* Compile pattern */
		p = fuz_qsearch(eif_access(text) + start, tlen-start,
			eif_access(pattern), plen, fuzzy);			/* Quick search */
		free_structures(fuzzy);							/* Free tables */
	}

	if (p == (char *) 0)		/* `p' is the start of the found substring */
		return 0;				/* Pattern not found */
	else
		return 1 + (p - eif_access(text));		/* Index within string */
}

rt_private void compile(char *pattern, register int plen, uint32 *dtable)
              		/* The pattern we want to look at */
                   	/* The length of the pattern */
               		/* Base address of delta array */
{
	/* Compile the pattern by computing the delta shift table from a pattern
	 * string. This has to be done before searching occurs.
	 */
	
	register1 int i;
	register2 char *p;
	register3 uint32 *dp = dtable;

	plen++;		/* Increment to avoid doing it at each step of the loop */

	/* Initialize the delta table (one more than pattern length) */

	for (i = 0; i < ASIZE; i++)
		*dp++ = plen;

	plen--;		/* Restore pattern's length */

	/* Now for each character within the pattern, fill in shifting necessary
	 * to bring the pattern to the character. The rightmost value is kept, as
	 * we scan the pattern from left to right (ie. if there is two 'a', only the
	 * delta associated with the second --rightmost-- will be kept).
	 */

	for (p = pattern, i = 0; i < plen; p++, i++)
		dtable[*p] = plen - i;
}

rt_private void fuz_compile(EIF_CONTEXT EIF_OBJ pattern, register int plen, int fuzzy)
                	/* The pattern we want to look at */
                   	/* The length of the pattern */
          			/* Fuzzy control */
{
	/* Compile the pattern by computing the delta shift tables from a pattern
	 * string. This has to be done before searching occurs. The first delta
	 * table is computed with the full pattern, the second one is computed with
	 * the rightmost character removed, and so on. A total of (fuzzy + 1) tables
	 * are computed.
	 */
	EIF_GET_CONTEXT
	int i;
	uint32 *new;	/* Address of new delta table */

	fuzzy++;		/* Number of delta tables to build */

	/* First dynamically allocate the array of delta shift tables */
	darray = (uint32 **) cmalloc(fuzzy * sizeof(uint32 *));
	if (darray == (uint32 **) 0) {
		xraise(EN_MEM);
		return;					/* Exception ignored */
	}

	/* Now allocate each of the delta tables */
	for (i = 0; i < fuzzy; i++) {
		new = (uint32 *) cmalloc(ASIZE * sizeof(uint32));
		if (new == (uint32 *) 0) {			/* No more memory */
			free_structures(i - 1);			/* Free already allocated tables */
			xraise(EN_MEM);					/* No more memory */
			return;							/* Exception ignored */
		}
		darray[i] = new;		/* Shift table for that fuzzy match */
	}

	for (i = 0; i < fuzzy; i++)
		compile(eif_access(pattern), plen - i, darray[i]);
}

rt_private void free_structures(EIF_CONTEXT int n)
{
	EIF_GET_CONTEXT
	/* Free fuzzy delta shift tables from 0 to 'n' */

	while (n > 0)
		xfree((char *) (darray[n--]));	/* Free allocated delta tables */
	xfree((char *) darray);					/* Free main table */
}

rt_private char *qsearch(EIF_CONTEXT char *text, int tlen, char *pattern, int plen)
           		/* The text we are searching through */
         		/* Length of the text */
              	/* The pattern string */
         		/* The length of the pattern */
{
	/* The quick substring search algorithm. It returns the address of the start
	 * of the matching substring or a null pointer if not found.
	 */
	EIF_GET_CONTEXT
	register1 unsigned char *p;		/* Pattern string pointer */
	register2 unsigned char *t;		/* Text pointer */
	register4 unsigned char *tx;	/* Another text pointer (start of search) */
	register3 int i;		/* Position within pattern string */

	tx = (unsigned char *)text;				/* Where we start scanning */
	text += tlen;			/* First address beyond text string */

	while (tx + plen <= (unsigned char *)text) {		/* While enough text still left */

		for (p = (unsigned char *)pattern, t = tx, i = 0; i < plen; p++, t++, i++)
			if (*p != *t)			/* Scan pattern string */
				break;				/* Mismatch, so stop */
		
		if (i == plen)				/* Got substring (whole pattern matched) */
			return (char *) tx;				/* Start of substring found */

			/* If pattern is not found and tx+plen=text, the pattern is not
			 * in the string (we cannot get the value of tx+plen as the
			 * string is NOT null terminated)
			 */
		if (tx + plen == (unsigned char *)text)
			return (char *) 0;

		tx += delta[*(tx + plen)];	/* Shift to next text location */
	}
	return (char *) 0;		/* No substring found */
}

rt_private char *fuz_qsearch(EIF_CONTEXT char *text, int tlen, char *pattern, int plen, int fuzzy)
           		/* The text we are searching through */
         		/* Length of the text */
              	/* The pattern string */
         		/* The length of the pattern */
          		/* Allowed number of mismatches */
{
	/* The quick substring search algorithm. It returns the address of the start
	 * of the matching substring or a null pointer if not found. At most 'fuzzy'
	 * mismatches are allowed.
	 */
	EIF_GET_CONTEXT
	register1 char *p;		/* Pattern string pointer */
	register2 char *t;		/* Text pointer */
	register4 char *tx;		/* Another text pointer (start of search) */
	register3 int i;		/* Position within pattern string */
	register5 int m;		/* Number of mismatches so far */
	register6 int s;		/* Current shifting minimum */

	tx = text;				/* Where we start scanning */
	text += tlen;			/* First address beyond text string */
	m = 0;					/* No mismatches so far */
	fuzzy++;				/* Number of shift tables needed */

	while (tx + plen <= text) {		/* While enough text still left */

		for (p = pattern, t = tx, i = 0; i < plen; p++, t++, i++)
			if (*p != *t)			/* Scan pattern string */
				if (++m >= fuzzy)	/* Did we have enough mismatches? */
					break;			/* We did, so stop */
		
		if (i == plen)				/* Got substring (whole pattern matched) */
			return tx;				/* Start of substring found */
		
		/* Compute the minimum delta shift value */
		for (i = 0, s = plen + 1; i < fuzzy; i++) {
			m = darray[i][*(tx + (plen - i))];
			if (m < s)
				s = m;
		}

		tx += s;		/* Shift to next text location */
		m = 0;			/* Reset mismatches count */
	}

	return (char *) 0;		/* No substring found */
}

