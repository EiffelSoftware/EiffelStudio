/*

 #####   #       ######          #    #
 #    #  #       #               #    #
 #    #  #       #####           ######
 #    #  #       #        ###    #    #
 #    #  #       #        ###    #    #
 #####   ######  ######   ###    #    #

	Dynamic Linking in Eiffel primitives declarations
*/

#ifndef _eif_dle_h_
#define _eif_dle_h_

#ifdef __cplusplus
extern "C" {
#endif

/* Status codes of the last dynamic class retrievement
 */
#define DLE_NO_ERROR	0		/* Dynamic class retrieved correctly */
#define DLE_BAD_DIR		1		/* Not a DC-set directory */
#define DLE_NO_CLASS	2		/* No such dynamic class in the DC-set */
#define DLE_M_READ_ERR	3		/* Cannot read the melted DLE file */
#define DLE_F_READ_ERR	3		/* Cannot read the frozen DLE file */
#define DLE_BAD_CLASS	4		/* Class not descendant of `DYNAMIC' */
#define DLE_DUP_CLASS	5		/* Two dynamic classes with same name */
#define DLE_NOT_SUPPORTED	7	/* DLE are not supported in that release */


#ifdef WORKBENCH
RT_LNK uint32 dle_level;		/* DLE level */
RT_LNK uint32 dle_zeroc;		/* Frozen level in the DC-set */
extern fnptr *dle_frozen;		/* DLE C routine array (frozen routines) */
extern char **dle_melt;			/* Byte code array of DLE melted features */
extern int *dle_mpatidtab;		/* Table of pattern id's indexed by body id's */
extern int *dle_fpatidtab;		/* Table of pattern id's indexed by body id's */
extern long dle_melt_count;		/* Size of `dle_melt' table */
#else
extern char *(**dle_make)();	/* Make routines of DYNAMIC descendants */
#endif

extern int dynamic_dtype;		/* Dynamic type of DYNAMIC */
extern void dle_reclaim(void);		/* Free resources introduced by the DC-set */

/* Function called from the Eiffel side (in class DYNAMIC_CLASS) */
extern EIF_INTEGER dle_retrieve(EIF_REFERENCE obj, EIF_REFERENCE dle_path);	/* Load the Dynamic Class Set */
extern EIF_REFERENCE dle_instance(EIF_CONTEXT int dtype, EIF_REFERENCE arg);
extern EIF_INTEGER dle_search(EIF_REFERENCE obj, EIF_REFERENCE class_name);	/* Search for a class in the DC-Set */
extern void c_pass_dle_routines(EIF_PROCEDURE set_dtype_addr);	/* Pass eiffel routine addr to C */
extern void dle_reclaim(void);

#ifdef __cplusplus
}
#endif

#endif
