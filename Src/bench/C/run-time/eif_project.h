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

#include "eif_portable.h"
#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

	RT_LNK EIF_BOOLEAN exception_stack_managed;	/* Is the stack managed (always True in workbench mode) */

/*************/	
/* variables */
/*************/	

	RT_LNK EIF_INTEGER egc_prof_enabled;	  /* Is the Eiffel profiler on */
	RT_LNK void (*egc_strmake)(EIF_REFERENCE, EIF_INTEGER);	/* STRING creation feature */
	RT_LNK void (*egc_strset)(EIF_REFERENCE, EIF_INTEGER);	/* STRING `set_count' feature */
	RT_LNK void (*egc_arrmake)(EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER);/* ARRAY creation feature */
	RT_LNK void (*egc_routdisp)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE);		/* ROUTINE `set_rout_disp' feature */
	RT_LNK int egc_str_dtype;				/* Dynamic type for string */
	RT_LNK int egc_arr_dtype;				/* Dynamic type for ARRAY[ANY] */
	RT_LNK int egc_tup_dtype;				/* Dynamic type for TUPLE */
	RT_LNK int32 egc_disp_rout_id;			/* Dispose routine id */ 
	RT_LNK int egc_bit_dtype;			/* Dynamic type of BIT, E1/plug.c */
	RT_LNK int egc_any_dtype;			/* Dynamic type of ANY */

	RT_LNK int egc_sp_bool;			/* Dynamic type of SPECIAL[BOOLEAN] */
	RT_LNK int egc_sp_char;			/* Dynamic type of SPECIAL[CHARACTER] */
	RT_LNK int egc_sp_wchar;		/* Dynamic type of SPECIAL[WIDE_CHARACTER] */
	RT_LNK int egc_sp_int8;			/* Dynamic type of SPECIAL[INTEGER_8] */
	RT_LNK int egc_sp_int16;		/* Dynamic type of SPECIAL[INTEGER_16] */
	RT_LNK int egc_sp_int32;		/* Dynamic type of SPECIAL[INTEGER_32] */
	RT_LNK int egc_sp_int64;		/* Dynamic type of SPECIAL[INTEGER_64] */
	RT_LNK int egc_sp_real;			/* Dynamic type of SPECIAL[REAL] */
	RT_LNK int egc_sp_double;		/* Dynamic type of SPECIAL[DOUBLE] */
	RT_LNK int egc_sp_pointer;		/* Dynamic type of SPECIAL[POINTER] */

	RT_LNK int egc_int8_ref_dtype;	/* Dynamic type of INTEGER_8_REF */
	RT_LNK int egc_int16_ref_dtype;	/* Dynamic type of INTEGER_16_REF */
	RT_LNK int egc_int32_ref_dtype;	/* Dynamic type of INTEGER_32_REF */
	RT_LNK int egc_int64_ref_dtype;	/* Dynamic type of INTEGER_64_REF */
	RT_LNK int egc_bool_ref_dtype;	/* Dynamic type of BOOLEAN_REF */
	RT_LNK int egc_real_ref_dtype;	/* Dynamic type of REAL_REF */
	RT_LNK int egc_doub_ref_dtype;	/* Dynamic type of DOUBLE_REF */
	RT_LNK int egc_char_ref_dtype;	/* Dynamic type of CHARACTER_REF */
	RT_LNK int egc_wchar_ref_dtype;	/* Dynamic type of WIDE_CHARACTER_REF */
	RT_LNK int egc_point_ref_dtype;	/* Dynamic type of POINTER_REF */

	RT_LNK struct ctable egc_ce_type;			/* Class name -> type ID */
	RT_LNK struct ctable egc_ce_gtype;			/* Generic class name -> gt_info */
	RT_LNK struct cnode *egc_fsystem;			/* Describes the full frozen Eiffel system */
	RT_LNK struct conform **egc_fco_table; 
	RT_LNK void (*egc_system_mod_init) (void);	/* Module Initialization (from einit.c) */
	RT_LNK struct eif_par_types **egc_partab;	/* Parent table */
	RT_LNK int egc_partab_size;				/* Size of parent table */
	RT_LNK int egc_type_of_gc;

#ifdef WORKBENCH
	RT_LNK fnptr *egc_frozen;			/* C routine array (frozen routines) */
	RT_LNK int *egc_fpatidtab;			/* Table of pattern id's indexed by body id's */
	RT_LNK struct eif_opt *egc_foption;	/* Frozen option table */
	RT_LNK fnptr **egc_address_table;		/* Table of $ operator encapsulation functions */
	RT_LNK struct p_interface *egc_fpattern;

	RT_LNK void (*egc_einit)(void);		/* System-dependent initializations, E1/einit.c */
	RT_LNK void (*egc_tabinit)(void);		/* E1/einit.c */

	RT_LNK int32 **egc_fcall;	/* Routine id arrays indexed by feature id's */
	RT_LNK struct rout_info *egc_forg_table;/* Routine origin/offset table */
	RT_LNK int16 *egc_fdtypes;	/* Dynamic type  array indexed by old
								* dynamic types (for re-freezing) */
#else
	RT_LNK void (**egc_edispose)(void);
	RT_LNK char *(**egc_ecreate)(void);
	RT_LNK struct ctable *egc_ce_rname;
	RT_LNK long *egc_fnbref ;
	RT_LNK long *egc_fsize;
#endif

	RT_LNK int32 egc_rcdt;				/* E1/einit.c */
	RT_LNK int32 egc_rcorigin;			/* E1/einit.c */
	RT_LNK int32 egc_rcoffset;			/* E1/einit.c */
	RT_LNK int32 egc_rcarg;				/* E1/einit.c */

	RT_LNK char *egc_system_name;		/* Name of the generated system */
	RT_LNK char *egc_system_location;	/* Location of the generated system */
	RT_LNK EIF_INTEGER egc_compiler_tag;	/* Tag corresponding to the compiler version */
	RT_LNK EIF_INTEGER egc_project_version;	/* Tag corresponding to the project version */

	RT_LNK int egc_platform_level;
	 
#ifdef __cplusplus
}
#endif

#endif /* _EIF_PROJECT_H_ */

