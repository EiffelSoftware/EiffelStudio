/*

 #####   #####    ####        #  ######   ####    #####          #    #
 #    #  #    #  #    #       #  #       #    #     #            #    #
 #    #  #    #  #    #       #  #####   #          #            ######
 #####   #####   #    #       #  #       #          #     ###    #    #
 #       #   #   #    #  #    #  #       #    #     #     ###    #    #
 #       #    #   ####    ####   ######   ####      #     ###    #    #

Dummy declarations for variables and routines called in the run-time but
generated in a system

*/

#ifndef _EIF_PROJECT_H_
#define _EIF_PROJECT_H_

#include "eif_struct.h"
#ifdef __cplusplus
extern "C" {
#endif

	extern EIF_BOOLEAN exception_stack_managed;	/* Is the stack managed (always True in workbench mode) */

	extern EIF_INTEGER egc_prof_enabled;	  /* Is the Eiffel profiler on */
	extern void (*egc_strmake)(char *, EIF_INTEGER);	/* STRING creation feature */
	extern void (*egc_strset)(char *, EIF_INTEGER);		/* STRING `set_count' feature */
	extern void (*egc_arrmake)(char *, EIF_INTEGER, EIF_INTEGER);	/* STRING creation feature */
	extern int egc_str_dtype;				/* Dynamic type for string */
	extern int egc_arr_dtype;				/* Dynamic type for ARRAY[ANY] */
	extern int32 egc_disp_rout_id;			/* Dispose routine id */ 
	extern int egc_bit_dtype;			/* Dynamic type of BIT, E1/plug.c */

	extern int egc_sp_bool;			/* Dynamic type of SPECIAL[BOOLEAN] */
	extern int egc_sp_char;			/* Dynamic type of SPECIAL[CHARACTER] */
	extern int egc_sp_int;			/* Dynamic type of SPECIAL[INTEGER] */
	extern int egc_sp_real;			/* Dynamic type of SPECIAL[REAL] */
	extern int egc_sp_double;		/* Dynamic type of SPECIAL[DOUBLE] */
	extern int egc_sp_pointer;		/* Dynamic type of SPECIAL[POINTER] */

	extern int egc_int_ref_dtype;	/* Dynamic type of INTEGER_REF */
	extern int egc_bool_ref_dtype;	/* Dynamic type of BOOLEAN_REF */
	extern int egc_real_ref_dtype;	/* Dynamic type of REAL_REF */
	extern int egc_doub_ref_dtype;	/* Dynamic type of DOUBLE_REF */
	extern int egc_char_ref_dtype;	/* Dynamic type of CHARACTER_REF */
	extern int egc_point_ref_dtype;	/* Dynamic type of POINTER_REF */



	extern struct ctable egc_ce_type;			/* Class name -> type ID */
	extern struct ctable egc_ce_gtype;			/* Generic class name -> gt_info */
	extern struct cnode *egc_fsystem;			/* Describes the full frozen Eiffel system */
	extern struct conform **egc_fco_table; 
	extern void (*egc_system_mod_init) (void);	/* Module Initialization (from einit.c) */

#ifdef WORKBENCH
	extern fnptr *egc_frozen;			/* C routine array (frozen routines) */
	extern int *egc_fpatidtab;			/* Table of pattern id's indexed by body id's */
	extern struct eif_opt *egc_foption;	/* Frozen option table */
	extern fnptr **egc_address_table;		/* Table of $ operator encapsulation functions */
	extern uint32 *egc_fdispatch;		/* Frozen disaptch table */
	extern struct p_interface *egc_fpattern;

	extern void (*egc_einit)(void);		/* System-dependent initializations, E1/einit.c */
	extern void (*egc_tabinit)(void);		/* E1/einit.c */

	extern int32 **egc_fcall;	/* Routine id arrays indexed by feature id's */
	extern struct rout_info *egc_forg_table;/* Routine origin/offset table */
	extern int16 *egc_fdtypes;	/* Dynamic type  array indexed by old
								* dynamic types (for re-freezing) */
#else
	extern void (**egc_edispose)(void);
	extern void (**egc_ecreate)(void);
	extern struct ctable *egc_ce_rname;
	extern long *egc_fnbref ;
	extern long *egc_fsize;
#endif


	extern int32 egc_rcdt;				/* E1/einit.c */
	extern int32 egc_rcorigin;			/* E1/einit.c */
	extern int32 egc_rcoffset;			/* E1/einit.c */
	extern int egc_rcarg;				/* E1/einit.c */

#ifdef __cplusplus
}
#endif

#endif /* _EIF_PROJECT_H_ */

