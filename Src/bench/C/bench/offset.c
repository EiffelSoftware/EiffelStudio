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
rt_public EIF_INTEGER r32off(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER ptroff(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER i64off(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_public EIF_INTEGER r64off(EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);
rt_private EIF_INTEGER eif_remainder(EIF_INTEGER x);
rt_private EIF_INTEGER eif_padding(EIF_INTEGER x, EIF_INTEGER y);


/*
 * Functions definitions
 */

rt_public EIF_INTEGER chroff(EIF_INTEGER nb_ref)
{
	/* Return offset of first character after `nb_ref' references
	 */

	return nb_ref * REFSIZ + eif_padding(nb_ref * REFSIZ, (EIF_INTEGER)CHRSIZ);
}

rt_public EIF_INTEGER i16off(EIF_INTEGER nb_ref, EIF_INTEGER nb_char)
{
	/* Return offset of first integer 16 bits after `nb_ref' references,
	 * and `nb_char' characters. 
	 */
	EIF_INTEGER to_add = chroff(nb_ref) + nb_char *CHRSIZ;

	return to_add + eif_padding(to_add, (EIF_INTEGER) I16SIZ);
}

rt_public EIF_INTEGER lngoff(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16)
{
	/* Return offset of first integer after `nb_ref' references,
	 * and `nb_char' characters. 
	 */
	EIF_INTEGER to_add = i16off(nb_ref, nb_char) + nb_int16 *I16SIZ;

	return to_add + eif_padding(to_add, (EIF_INTEGER) LNGSIZ);
}

rt_public EIF_INTEGER r32off(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32)
{
	/* Return offset of first real32 after `nb_ref' references,
	 * `nb_char' characters and `nb_int32' integers.
	 */
	EIF_INTEGER to_add = lngoff(nb_ref,nb_char, nb_int16) + nb_int32 * LNGSIZ;

	return to_add + eif_padding(to_add, (EIF_INTEGER)R32SIZ);
}

rt_public EIF_INTEGER ptroff(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_r32)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers and `nb_r32' real32s.
	 */
	EIF_INTEGER to_add = r32off(nb_ref,nb_char, nb_int16,nb_int32) + nb_r32 * R32SIZ;

	return to_add + eif_padding(to_add, (EIF_INTEGER)PTRSIZ);
}

rt_public EIF_INTEGER i64off(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_r32, EIF_INTEGER nb_ptr)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers, `nb_r32' real32s,
	 * and `nb_ptr' pointers. 
	 */
	EIF_INTEGER to_add = ptroff(nb_ref,nb_char, nb_int16,nb_int32,nb_r32)
					+ nb_ptr * PTRSIZ;

	return to_add + eif_padding(to_add, (EIF_INTEGER) I64SIZ);
}

rt_public EIF_INTEGER r64off(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_r32, EIF_INTEGER nb_ptr, EIF_INTEGER nb_int64)
{
	/* Return offset of first pointer after `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers, `nb_r32' real32s,
	 * and `nb_ptr' pointers. 
	 */
	EIF_INTEGER to_add = i64off(nb_ref,nb_char, nb_int16,nb_int32,nb_r32, nb_ptr)
					+ nb_int64 * I64SIZ;

	return to_add + eif_padding(to_add, (EIF_INTEGER) R64SIZ);
}

rt_public EIF_INTEGER objsiz(EIF_INTEGER nb_ref, EIF_INTEGER nb_char, EIF_INTEGER nb_int16, EIF_INTEGER nb_int32, EIF_INTEGER nb_r32, EIF_INTEGER nb_ptr, EIF_INTEGER nb_int64, EIF_INTEGER nb_r64)
{
	/* Return size of an object having `nb_ref' references,
	 * `nb_char' characters, `nb_int32' integers, `nb_r32' real32s,
	 * `nb_ptr' pointers and `nb_r64' real64s.
	 */
	EIF_INTEGER to_add = r64off(nb_ref,nb_char, nb_int16,nb_int32,nb_r32,nb_ptr, nb_int64)
					+ nb_r64 * R64SIZ;

	return to_add + eif_remainder(to_add);
}

/*
 * Private functions definitions
 */

rt_private EIF_INTEGER eif_remainder(EIF_INTEGER x)
{
	return ((x % ALIGN) ? (ALIGN -(x % ALIGN)) : 0);
}

rt_private EIF_INTEGER eif_padding(EIF_INTEGER x, EIF_INTEGER y)
{
	return eif_remainder(x) % y;
}
