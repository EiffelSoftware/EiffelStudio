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

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_config.h"
#include "eif_portable.h"

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

/*
 * Run time functions used by generated C code.
 */

RT_LNK char *makestr(register char *s, register int len);	/* Build an Eiffel string object */
extern char *makebit(char *bit, long int bit_count);		/* Build an Eiffel bit object */
extern char *striparr(register char *curr, register int dtype, register char **items, register long int nbr);			/* Build an Eiffel ARRAY[ANY] object for strip*/

RT_LNK char *argarr(int argc, char **argv);		/* ARRAY[STRING] creation from command line arguments */

extern long *eif_lower_table;		/* ARRAY `lower' (array optimization) */
extern long *eif_area_table;		/* ARRAY `area' (array optimization) */

#ifdef WORKBENCH
extern void wstdinit(char *obj, char *parent);				/* Composite objects initialization */
extern char *cr_exp(uint32 type);				/* Creation of expanded objects */
#endif

/*
 * Run time declarations (tables produced by the compiler).
 */

#ifndef WORKBENCH
extern long *esize;		/* Size of object given DType (updated by DLE) */
extern long *nbref;		/* Gives # of references given DT (updated by DLE) */
extern char *(**dle_make)();		/* Make routines of DYNAMIC descendants */
#endif

#define System(type)		esystem[type]	/* Object description */

#ifndef WORKBENCH
#define References(type)	nbref[type] 	/* # of references */
#define Size(type)		esize[type] 	/* Object's size */
#define Dispose(type)		egc_edispose[type]	/* Dispose routine */
#define Disp_rout(type)	Dispose(type)	/* Does type have disp routine */
#define XCreate(type)		egc_ecreate[type]	/* Initialization routine */
#else
#define References(type)	esystem[type].nb_ref
#define Size(type)		esystem[type].size
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
	(((char *) obj1) == ((char *) 0) || ((char *) obj2) == ((char *) 0))? EIF_FALSE: \
		eif_gen_conf((int16) Dftype(obj1), (int16) Dftype(obj2))
  
/* Are dynamic types of `obj1' and `obj2' identical? */
#define estypeg(obj1, obj2) \
	(((char *) obj1) == ((char *) 0) || ((char *) obj2) == ((char *) 0))? EIF_FALSE: \
		(Dtype(obj1) == Dtype(obj2))

RT_LNK int econfm(int ancestor, int heir);	/* Conformance query for assignment attempt */
RT_LNK long sp_count(char *spobject);		/* Count of a special object */
RT_LNK void chkinv(char *obj, int where);	/* Invariant control call */

#ifdef WORKBENCH
RT_LNK void chkcinv(char *obj);			/* Creation invariant call */	
#endif

#ifndef WORKBENCH
RT_LNK void rt_norout(void);		/* No function pointer */
#endif

#ifdef __cplusplus
}
#endif

#endif

