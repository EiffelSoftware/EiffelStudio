/*

 #####   #       #    #   ####           #    #
 #    #  #       #    #  #    #          #    #
 #    #  #       #    #  #               ######
 #####   #       #    #  #  ###   ###    #    #
 #       #       #    #  #    #   ###    #    #
 #       ######   ####    ####    ###    #    #

	Declarations for plugging routines and structures.
*/

#ifndef _plug_h_
#define _plug_h_

#ifdef __cplusplus
extern "C" {
#endif
 
#include "config.h"
#include "portable.h"

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

extern char *makestr(register char *s, register int len);				/* Build an Eiffel string object */
extern char *makebit(char *bit, long int bit_count);				/* Build an Eiffel bit object */
extern char *striparr(register char *curr, register int dtype, register char **items, register long int nbr);			/* Build an Eiffel ARRAY[ANY] object for strip*/
extern int str_dtype;				/* Dynamic type for string */
extern int arr_dtype;				/* Dynamic type for ARRAY[ANY] */
extern int32 disp_rout_id;			/* Dispose routine id */ 

#ifdef __STDC__
extern void (*eif_strmake)(char *, EIF_INTEGER);	/* STRING creation feature */
extern void (*eif_strset)(char *, EIF_INTEGER);		/* STRING `set_count' feature */
extern void (*eif_arrmake)(char *, EIF_INTEGER, EIF_INTEGER);	/* STRING creation feature */
#else
extern void (*eif_strmake)();	/* STRING creation feature */
extern void (*eif_strset)();		/* STRING `set_count' feature */
extern void (*eif_arrmake)();	/* STRING creation feature */
#endif

extern char *argarr(int argc, char **argv);				/* ARRAY[STRING] creation from command line arguments */

extern long *eif_lower_table;		/* ARRAY `lower' (array optimization) */
extern long *eif_area_table;		/* ARRAY `area' (array optimization) */

#ifdef WORKBENCH
extern void wstdinit(char *obj, char *parent);				/* Composite objects initialization */
extern char *cr_exp(uint32 type);				/* Creation of expanded objects */
#endif

#ifdef __cplusplus
}
#endif

/*
 * Run time declarations (tables produced by the compiler).
 */

#ifndef WORKBENCH
extern long fsize[];	/* Size of object given Dynamic Type (static system) */
extern long *esize;		/* Size of object given DType (updated by DLE) */
extern long fnbref[];	/* Gives # of references given DT (static system) */
extern long *nbref;		/* Gives # of references given DT (updated by DLE) */
extern void (**edispose)();			/* Records pointers to dispose routines */
extern char *(**ecreate)();			/* Initialization routines */
extern char *(**dle_make)();		/* Make routines of DYNAMIC descendants */
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define System(type)		esystem[type]	/* Object description */

#ifndef WORKBENCH
#define References(type)	nbref[type]	 	/* # of references */
#define Size(type)			esize[type]	 	/* Object's size */
#define Dispose(type)		edispose[type]	/* Dispose routine */
#define Disp_rout(type) 	Dispose(type)	/* Does type have disp routine */
#define Create(type)		ecreate[type]	/* Initialization routine */
#else
#define References(type)	esystem[type].nb_ref
#define Size(type)			esystem[type].size
#define Disp_rout(type)		esystem[type].cn_disposed
											/* Does type have disp routine ? */
#define Dispose(type) ((void (*)()) wdisp(type));
											/* Dispose routine */
#define Create(type)		\
	(esystem[type].cn_composite ? (char *(*)()) wstdinit : (char *(*)()) 0)
#endif

/* Type used in the "dynamic type" field of special objects holding an array
 * of simple type, e.g. ARRAY[REAL]. They are used by all the object "viewing"
 * routines.
 */

extern int sp_bool;			/* Dynamic type of SPECIAL[BOOLEAN] */
extern int sp_char;			/* Dynamic type of SPECIAL[CHARACTER] */
extern int sp_int;			/* Dynamic type of SPECIAL[INTEGER] */
extern int sp_real;			/* Dynamic type of SPECIAL[REAL] */
extern int sp_double;		/* Dynamic type of SPECIAL[DOUBLE] */
extern int sp_pointer;		/* Dynamic type of SPECIAL[POINTER] */

extern int int_ref_dtype;	/* Dynamic type of INTEGER_REF */
extern int bool_ref_dtype;	/* Dynamic type of BOOLEAN_REF */
extern int real_ref_dtype;	/* Dynamic type of REAL_REF */
extern int doub_ref_dtype;	/* Dynamic type of DOUBLE_REF */
extern int char_ref_dtype;	/* Dynamic type of CHARACTER_REF */
extern int point_ref_dtype;	/* Dynamic type of POINTER_REF */

extern int dynamic_dtype;	/* Dynamic type of DYNAMIC */

/*
 * Miscellaneous routines.
 */

extern EIF_BOOLEAN econfg(char *obj1, char *obj2);	/* Conformance query in class GENERAL */
extern int econfm(int ancestor, int heir);			/* Conformance query for assignment attempt */
extern long sp_count(char *spobject);			/* Count of a special object */
extern void chkinv(char *obj, int where);			/* Invariant control call */
#ifdef WORKBENCH
extern void chkcinv(char *obj);			/* Creation invariant call */	
#endif

#ifndef WORKBENCH
extern void rt_norout(void);		/* No function pointer */
#endif

#ifdef __cplusplus
}
#endif

#endif

