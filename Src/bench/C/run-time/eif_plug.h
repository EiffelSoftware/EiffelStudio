/*

 #####   #       #    #   ####           #    #
 #    #  #       #    #  #    #          #    #
 #    #  #       #    #  #               ######
 #####   #       #    #  #  ###   ###    #    #
 #       #       #    #  #    #   ###    #    #
 #       ######   ####    ####    ###    #    #

	Declarations for plugging routines and structures.
*/

#ifndef _eif_plug_h_
#define _eif_plug_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Structure used to represent bits in the object. The first long integer
 * is the length of the bit field. It is then followed by enough long integers
 * to store the value of the bits.
 * The declaration of the structure is tricky: the value field is declared as
 * a pointer on an array of one time, but as C does no range checking, this
 * perfectly suits our needs--RAM.
 */

struct bit {
	uint32 b_length;				/* Length of the bit field */
	uint32 b_value[1];				/* Array long integers holding value */
};

#define	eif_make_string	makestr	/* Returns an Eiffel string */

/*
 * Run time functions used by generated C code.
 */

RT_LNK EIF_REFERENCE makestr(register char *s, register int len);	/* Build an Eiffel string object */
extern EIF_REFERENCE makebit(char *bit, long int bit_count);		/* Build an Eiffel bit object */
extern EIF_REFERENCE striparr(EIF_REFERENCE curr, int dtype, EIF_REFERENCE *items, long int nbr);			/* Build an Eiffel ARRAY[ANY] object for strip*/

RT_LNK EIF_REFERENCE argarr(int argc, char **argv);		/* ARRAY[STRING] creation from command line arguments */

extern long *eif_lower_table;		/* ARRAY `lower' (array optimization) */
extern long *eif_area_table;		/* ARRAY `area' (array optimization) */

#ifdef WORKBENCH
extern void wstdinit(EIF_REFERENCE obj, EIF_REFERENCE parent);				/* Composite objects initialization */
extern EIF_REFERENCE cr_exp(uint32 type);				/* Creation of expanded objects */
#endif

/*
 * Run time declarations (tables produced by the compiler).
 */

#ifndef WORKBENCH
extern long *esize;		/* Size of object given DType */
extern long *nbref;		/* Gives # of references given DT */
#endif

#define System(type)		esystem[type]	/* Object description */

#ifndef WORKBENCH
#define References(type)	nbref[type] 	/* # of references */
#define EIF_Size(type)		esize[type] 	/* Object's size */
#define Dispose(type)		egc_edispose[type]	/* Dispose routine */
#define Disp_rout(type)	Dispose(type)	/* Does type have disp routine */
#define XCreate(type)		egc_ecreate[type]	/* Initialization routine */
#else
#define References(type)	esystem[type].nb_ref
#define EIF_Size(type)		esystem[type].size
#define Disp_rout(type)	esystem[type].cn_disposed
								/* Does type have disp routine ? */
#define Dispose(type) ((void (*)()) wdisp(type));
										/* Dispose routine */
#define XCreate(type)	     \
	(esystem[type].cn_composite ? (char *(*)()) wstdinit : (char *(*)()) 0)
#endif

/* Type used in the "dynamic type" field of special objects holding an array
 * of simple type, e.g. ARRAY[REAL]. They are used by all the object "viewing"
 * routines.
 */

extern int dynamic_dtype;	/* Dynamic type of DYNAMIC */

#ifdef CONCURRENT_EIFFEL
#define _concur_sep_obj_dtype scount
#endif

/*
 * Miscellaneous routines.
 */
  
/* Conformance query in class GENERAL */
#define econfg(obj1, obj2) \
	(((EIF_REFERENCE) obj1 == (EIF_REFERENCE) 0) || ((EIF_REFERENCE) obj2 == (EIF_REFERENCE) 0 )) ? EIF_FALSE: \
		eif_gen_conf((int16) Dftype(obj2), (int16) Dftype(obj1))
  
/* Are dynamic types of `obj1' and `obj2' identical? */
#define estypeg(obj1, obj2) \
	(((EIF_REFERENCE) obj1 == (EIF_REFERENCE) 0) || ((EIF_REFERENCE) obj2 == (EIF_REFERENCE) 0))? EIF_FALSE: \
		(Dftype(obj1) == Dftype(obj2))

RT_LNK EIF_INTEGER sp_count(EIF_REFERENCE spobject);		/* Count of a special object */
RT_LNK void chkinv(EIF_REFERENCE obj, int where);	/* Invariant control call */

#ifdef WORKBENCH
RT_LNK void chkcinv(EIF_REFERENCE obj);			/* Creation invariant call */	
#endif

#ifndef WORKBENCH
RT_LNK void rt_norout(EIF_REFERENCE);		/* No function pointer */
#endif

#ifdef __cplusplus
}
#endif

#endif

