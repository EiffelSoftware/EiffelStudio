/*********************************************************/
/* Copyright (C) Interactive Software Engineering, Inc.  */
/* 270 Storke Road, Suite 7 Goleta, California 93117 USA */
/*                  (805) 685-1006                       */
/*                All rights reserved                    */
/*      Duplication or distribution prohibited           */
/*********************************************************/
/*
 * rou.c
 * Necessary external C routines for Eiffel
 * these routines are required by the following classe:
 *      - FIX_INT_SET
 */

#include <eiffel.h>

/*
 * Is fix_int_set a1 with size s empty?
 */
EIF_BOOLEAN bempty (a1, s)
char *a1;
EIF_INTEGER s;
{
	EIF_INTEGER i;

	for (i = 0; (i < s) && (a1 [i] == 0); i++);
	return ((EIF_BOOLEAN) (i == s));
}

/*
 * Smallest element of fix_int_set a1. Size + 1 if empty.
 */
EIF_INTEGER sma (a1, s)
char *a1;
EIF_INTEGER s;
{
	EIF_INTEGER i=0;

	while ((i < s) && (a1[i] == 0)) i++;
	return (i+1);
}

/*
 * Largest element of fix_int_set a1. 0 if empty.
 */
EIF_INTEGER lar (a1, s)
char *a1;
EIF_INTEGER s;
{
	EIF_INTEGER i = s;

	while ((i > 0) && (a1[i-1] == 0)) i--;
	return (i);
}

/*
 * Next element of fix_int_set a1, following p.
 * Size + 1 if p is the last one.
 */
EIF_INTEGER nex (a1, s, p)
char *a1;
EIF_INTEGER s;
EIF_INTEGER p;
{
	EIF_INTEGER i = p;

	while ((i < s) && (a1[i] == 0)) i++;
	return (i+1);
}
