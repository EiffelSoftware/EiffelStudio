/*

  ####   ######  ######   ####   ######   #####           ####
 #    #  #       #       #       #          #            #    #
 #    #  #####   #####    ####   #####      #            #
 #    #  #       #            #  #          #     ###    #
 #    #  #       #       #    #  #          #     ###    #    #
  ####   #       #        ####   ######     #     ###     ####

	Primitves for attribute offsets evaluation 
*/

#include "eif_macros.h"
#include "x2c.h"	/* Needed for OFFSETS macros */

/*
 * Declarations
 */

long chroff(long int nb_ref);
long lngoff(long int nb_ref, long int nb_char);
long fltoff(long int nb_ref, long int nb_char, long int nb_int);
long ptroff(long int nb_ref, long int nb_char, long int nb_int, long int nb_flt);
long dbloff(long int nb_ref, long int nb_char, long int nb_int, long int nb_flt, long int nb_ptr);
static long remainder(long int x);
static long padding(long int x, long int y);


/*
 * Functions definitions
 */

long chroff(long int nb_ref)
{
	/* Return offset of first character after `nb_ref' references
	 */

	return nb_ref * REFSIZ + padding(nb_ref * REFSIZ, (long)CHRSIZ);
}

long lngoff(long int nb_ref, long int nb_char)
{
	/* Return offset of first integer after `nb_ref' references,
	 * and `nb_char' characters. 
	 */
	long to_add = chroff(nb_ref) + nb_char *CHRSIZ;

	return to_add + padding(to_add, (long)LNGSIZ);
}

long fltoff(long int nb_ref, long int nb_char, long int nb_int)
{
	/* Return offset of first float after `nb_ref' references,
	 * `nb_char' characters and `nb_int' integers.
	 */
	long to_add = lngoff(nb_ref,nb_char) + nb_int * LNGSIZ;

	return to_add + padding(to_add, (long)FLTSIZ);
}

long ptroff(long int nb_ref, long int nb_char, long int nb_int, long int nb_flt)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int' integers and `nb_flt' floats.
	 */
	long to_add = fltoff(nb_ref,nb_char,nb_int) + nb_flt * FLTSIZ;

	return to_add + padding(to_add, (long)PTRSIZ);
}

long dbloff(long int nb_ref, long int nb_char, long int nb_int, long int nb_flt, long int nb_ptr)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int' integers, `nb_flt' floats,
	 * and `nb_ptr' pointers. 
	 */
	long to_add = ptroff(nb_ref,nb_char,nb_int,nb_flt)
					+ nb_ptr * PTRSIZ;

	return to_add + padding(to_add, (long)DBLSIZ);
}

long objsiz(int nb_ref, int nb_char, int nb_int, int nb_flt, int nb_ptr, int nb_dbl)
{
	/* Return size of an object having `nb_ref' references,
	 * `nb_char' characters, `nb_int' integers, `nb_flt' floats,
	 * `nb_ptr' pointers and `nb_dbl' doubles.
	 */
	long to_add = 	dbloff(nb_ref,nb_char,nb_int,nb_flt,nb_ptr)
					+ nb_dbl * DBLSIZ;

	return to_add + remainder(to_add);
}

long bitoff(long int bitval)
{
	/* Return size of a bit object of size `bit_val'. */

	return BITOFF(bitval);
}

long chracs(long int n)
{
	/* Return size of `n' characters */

	return CHRACS(n);
}

long refacs(long int n)
{
	/* Return size of `n' references */

	return REFACS(n);
}

long lngacs(long int n)
{
	/* Return size of `n' long integers */

	return LNGACS(n);
}

long fltacs(long int n)
{
	/* Return size of `n' floats */

	return FLTACS(n);
}

long ptracs(long int n)
{
	/* Return size of `n' pointers */

	return PTRACS(n);
}

long dblacs(long int n)
{
	/* Return size of `n' doubles */

	return DBLACS(n);
}

long ovhsiz(void)
{
	/* Return size of an Eiffel 3 overhead. */

	return OVERHEAD;
}



/*
 * Private functions definitions
 */

static long remainder(long int x)
{
	return ((x % ALIGN) ? (ALIGN -(x % ALIGN)) : 0);
}

static long padding(long int x, long int y)
{
	return remainder(x) % y;
}
