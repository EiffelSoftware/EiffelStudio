/*

  ####   ######  ######   ####   ######   #####           ####
 #    #  #       #       #       #          #            #    #
 #    #  #####   #####    ####   #####      #            #
 #    #  #       #            #  #          #     ###    #
 #    #  #       #       #    #  #          #     ###    #    #
  ####   #       #        ####   ######     #     ###     ####

	Primitves for attribute offsets evaluation 
*/

#include "macros.h"

/*
 * Declarations
 */

long chroff();
long lngoff();
long fltoff();
long ptroff();
long dbloff();
static long remainder();
static long padding();


/*
 * Functions definitions
 */

long chroff(nb_ref)
long nb_ref;
{
	/* Return offset of first character after `nb_ref' references
	 */

	return nb_ref * REFSIZ + padding(nb_ref * REFSIZ, CHRSIZ);
}

long lngoff(nb_ref,nb_char)
long nb_ref, nb_char;
{
	/* Return offset of first integer after `nb_ref' references,
	 * and `nb_char' characters. 
	 */
	long to_add = chroff(nb_ref) + nb_char *CHRSIZ;

	return to_add + padding(to_add,LNGSIZ);
}

long fltoff(nb_ref,nb_char,nb_int)
long nb_ref, nb_char, nb_int;
{
	/* Return offset of first float after `nb_ref' references,
	 * `nb_char' characters and `nb_int' integers.
	 */
	long to_add = lngoff(nb_ref,nb_char) + nb_int * LNGSIZ;

	return to_add + padding(to_add,FLTSIZ);
}

long ptroff(nb_ref,nb_char,nb_int,nb_flt)
long nb_ref, nb_char, nb_int, nb_flt;
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int' integers and `nb_flt' floats.
	 */
	long to_add = fltoff(nb_ref,nb_char,nb_int) + nb_flt * FLTSIZ;

	return to_add + padding(to_add,PTRSIZ);
}

long dbloff(nb_ref,nb_char,nb_int,nb_flt,nb_ptr)
long nb_ref, nb_char, nb_int, nb_flt, nb_ptr;
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int' integers, `nb_flt' floats,
	 * and `nb_ptr' pointers. 
	 */
	long to_add = ptroff(nb_ref,nb_char,nb_int,nb_flt)
					+ nb_ptr * PTRSIZ;

	return to_add + padding(to_add,DBLSIZ);
}

long objsiz(nb_ref,nb_char,nb_int,nb_flt,nb_ptr,nb_dbl)
{
	/* Return size of an object having `nb_ref' references,
	 * `nb_char' characters, `nb_int' integers, `nb_flt' floats,
	 * `nb_ptr' pointers and `nb_dbl' doubles.
	 */
	long to_add = 	dbloff(nb_ref,nb_char,nb_int,nb_flt,nb_ptr)
					+ nb_dbl * DBLSIZ;

	return to_add + remainder(to_add);
}

long bitoff(bitval)
long bitval;
{
	/* Return size of a bit object of size `bit_val'. */

	return BITOFF(bitval);
}

long chracs(n)
long n;
{
	/* Return size of `n' characters */

	return CHRACS(n);
}

long refacs(n)
long n;
{
	/* Return size of `n' references */

	return REFACS(n);
}

long lngacs(n)
long n;
{
	/* Return size of `n' long integers */

	return LNGACS(n);
}

long fltacs(n)
long n;
{
	/* Return size of `n' floats */

	return FLTACS(n);
}

long ptracs(n)
long n;
{
	/* Return size of `n' pointers */

	return PTRACS(n);
}

long dblacs(n)
long n;
{
	/* Return size of `n' doubles */

	return DBLACS(n);
}

long ovhsiz()
{
	/* Return size of an Eiffel 3 overhead. */

	return OVERHEAD;
}



/*
 * Private functions definitions
 */

static long remainder(x)
long x;
{
	return ((x % ALIGN) ? (ALIGN -(x % ALIGN)) : 0);
}

static long padding(x,y)
long x,y;
{
	return remainder(x) % y;
}
