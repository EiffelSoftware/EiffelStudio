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

rt_public EIF_INTEGER chroff(EIF_INTEGER);
rt_public EIF_INTEGER i16off(EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER lngoff(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER fltoff(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER ptroff(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER i64off(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER dbloff(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_private EIF_INTEGER remainder(EIF_INTEGER x);
rt_private EIF_INTEGER padding(EIF_INTEGER x, EIF_INTEGER y);


/*
 * Functions definitions
 */

rt_public EIF_INTEGER chroff(EIF_INTEGER nb_ref)
{
	/* Return offset of first character after `nb_ref' references
	 */

	return nb_ref * REFSIZ + padding(nb_ref * REFSIZ, (EIF_INTEGER)CHRSIZ);
}

rt_public EIF_INTEGER i16off(EIF_INTEGER nb_ref, EIF_INTEGER nb_char)
{
	/* Return offset of first integer 16 bits after `nb_ref' references,
	 * and `nb_char' characters. 
	 */
	EIF_INTEGER to_add = chroff(nb_ref) + nb_char *CHRSIZ;

	return to_add + padding(to_add, (EIF_INTEGER) I16SIZ);
}

rt_public EIF_INTEGER lngoff(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16)
{
	/* Return offset of first integer after `nb_ref' references,
	 * and `nb_char' characters. 
	 */
	EIF_INTEGER to_add = i16off(nb_ref, nb_char) + nb_int16 *I16SIZ;

	return to_add + padding(to_add, (EIF_INTEGER) LNGSIZ);
}

rt_public EIF_INTEGER fltoff(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32)
{
	/* Return offset of first float after `nb_ref' references,
	 * `nb_char' characters and `nb_int32' integers.
	 */
	EIF_INTEGER to_add = lngoff(nb_ref,nb_char, nb_int16) + nb_int32 * LNGSIZ;

	return to_add + padding(to_add, (EIF_INTEGER)FLTSIZ);
}

rt_public EIF_INTEGER ptroff(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_flt)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers and `nb_flt' floats.
	 */
	EIF_INTEGER to_add = fltoff(nb_ref,nb_char, nb_int16,nb_int32) + nb_flt * FLTSIZ;

	return to_add + padding(to_add, (EIF_INTEGER)PTRSIZ);
}

rt_public EIF_INTEGER i64off(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_flt, EIF_INTEGER nb_ptr)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers, `nb_flt' floats,
	 * and `nb_ptr' pointers. 
	 */
	EIF_INTEGER to_add = ptroff(nb_ref,nb_char, nb_int16,nb_int32,nb_flt)
					+ nb_ptr * PTRSIZ;

	return to_add + padding(to_add, (EIF_INTEGER) I64SIZ);
}

rt_public EIF_INTEGER dbloff(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_flt, EIF_INTEGER nb_ptr, EIF_INTEGER nb_int64)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers, `nb_flt' floats,
	 * and `nb_ptr' pointers. 
	 */
	EIF_INTEGER to_add = i64off(nb_ref,nb_char, nb_int16,nb_int32,nb_flt, nb_ptr)
					+ nb_int64 * I64SIZ;

	return to_add + padding(to_add, (EIF_INTEGER) DBLSIZ);
}

rt_public EIF_INTEGER objsiz(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_flt, EIF_INTEGER nb_ptr, EIF_INTEGER nb_int64, EIF_INTEGER nb_dbl)
{
	/* Return size of an object having `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers, `nb_flt' floats,
	 * `nb_ptr' pointers and `nb_dbl' doubles.
	 */
	EIF_INTEGER to_add = dbloff(nb_ref,nb_char, nb_int16,nb_int32,nb_flt,nb_ptr, nb_int64)
					+ nb_dbl * DBLSIZ;

	return to_add + remainder(to_add);
}

/*
 * Private functions definitions
 */

rt_private EIF_INTEGER remainder(EIF_INTEGER x)
{
	return ((x % ALIGN) ? (ALIGN -(x % ALIGN)) : 0);
}

rt_private EIF_INTEGER padding(EIF_INTEGER x, EIF_INTEGER y)
{
	return remainder(x) % y;
}
