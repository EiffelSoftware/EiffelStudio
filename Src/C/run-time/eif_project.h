/*
	description: "[
			Dummy declarations for variables and routines called in the run-time but
			generated in a system.
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _EIF_PROJECT_H_
#define _EIF_PROJECT_H_

#include "eif_portable.h"
#include "eif_struct.h"
#include "eif_types.h"

#ifdef __cplusplus
extern "C" {
#endif

	RT_LNK EIF_BOOLEAN exception_stack_managed;	/* Is the stack managed (always True in workbench mode) */

/*************/	
/* variables */
/*************/	

	RT_LNK EIF_INTEGER egc_prof_enabled;	  /* Is the Eiffel profiler on */
#ifdef WORKBENCH
	RT_LNK void (*egc_strmake)(EIF_REFERENCE, EIF_TYPED_VALUE);	/* STRING creation feature */
	RT_LNK void (*egc_strset)(EIF_REFERENCE, EIF_TYPED_VALUE);
	RT_LNK void (*egc_arrmake)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE);/* ARRAY creation feature */
#else
	RT_LNK void (*egc_strmake)(EIF_REFERENCE, EIF_INTEGER);	/* STRING creation feature */
	RT_LNK uint32 egc_str_count_offset;
	RT_LNK uint32 egc_str_hash_offset;
	RT_LNK void (*egc_arrmake)(EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER);/* ARRAY creation feature */
#endif
	RT_LNK void (*egc_routdisp)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_INTEGER, EIF_INTEGER,
							    EIF_REFERENCE, EIF_BOOLEAN, EIF_BOOLEAN, EIF_BOOLEAN, EIF_BOOLEAN, EIF_REFERENCE, EIF_INTEGER); 	/* ROUTINE `set_rout_disp' feature */
#ifdef WORKBENCH
	RT_LNK void (*egc_routdisp_wb)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE,
		EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE); 	/* ROUTINE `set_rout_disp_wb' feature */
#else
	RT_LNK void (*egc_routdisp_fl)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_BOOLEAN, EIF_INTEGER); /* ROUTINE `set_rout_disp_final' feature */
#endif

#ifdef WORKBENCH
	RT_LNK void (*egc_set_exception_data)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, 
													EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `set_exception_data' feature */
#else
	RT_LNK void (*egc_set_exception_data)(EIF_REFERENCE, EIF_INTEGER, EIF_BOOLEAN, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, 
													EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_BOOLEAN); /* EXCEPTION_MANAGER `set_exception_data' feature */
#endif

#ifdef WORKBENCH
	RT_LNK void (*egc_set_last_exception)(EIF_REFERENCE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `set_last_exception' feature */
	RT_LNK EIF_TYPED_VALUE (*egc_last_exception)(EIF_REFERENCE); /* EXCEPTION_MANAGER `last_exception' feature */
	RT_LNK EIF_TYPED_VALUE (*egc_is_code_ignored)(EIF_REFERENCE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `is_code_ignored' feature */
	RT_LNK void (*egc_once_raise)(EIF_REFERENCE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `once_raise' feature */
#else
	RT_LNK void (*egc_set_last_exception)(EIF_REFERENCE, EIF_REFERENCE); /* EXCEPTION_MANAGER `set_last_exception' feature */
	RT_LNK EIF_REFERENCE (*egc_last_exception)(EIF_REFERENCE); /* EXCEPTION_MANAGER `last_exception' feature */
	RT_LNK EIF_BOOLEAN (*egc_is_code_ignored)(EIF_REFERENCE, EIF_INTEGER); /* EXCEPTION_MANAGER `is_code_ignored' feature */
	RT_LNK void (*egc_once_raise)(EIF_REFERENCE, EIF_REFERENCE); /* EXCEPTION_MANAGER `once_raise' feature */
#endif
	RT_LNK void (*egc_init_exception_manager)(EIF_REFERENCE); /* EXCEPTION_MANAGER `init_exception_manager' feature */
	RT_LNK void (*egc_free_preallocated_trace)(EIF_REFERENCE); /* EXCEPTION_MANAGER `free_preallocated_trace' feature */

	RT_LNK void (*egc_correct_mismatch)(EIF_REFERENCE);	/* ANY `correct_mismatch' */
	RT_LNK int egc_str_dtype;				/* Dynamic type for string */
	RT_LNK int egc_arr_dtype;				/* Dynamic type for ARRAY[ANY] */
	RT_LNK int egc_tup_dtype;				/* Dynamic type for TUPLE */
	RT_LNK int32 egc_disp_rout_id;			/* Dispose routine id */ 
	RT_LNK int egc_bit_dtype;			/* Dynamic type of BIT, E1/plug.c */
	RT_LNK int16 egc_any_dtype;			/* Dynamic type of ANY */

	RT_LNK uint32 egc_sp_bool;			/* Dynamic type of SPECIAL[BOOLEAN] */
	RT_LNK uint32 egc_sp_char;			/* Dynamic type of SPECIAL[CHARACTER] */
	RT_LNK uint32 egc_sp_wchar;		/* Dynamic type of SPECIAL[WIDE_CHARACTER] */
	RT_LNK uint32 egc_sp_uint8;			/* Dynamic type of SPECIAL[NATURAL_8] */
	RT_LNK uint32 egc_sp_uint16;		/* Dynamic type of SPECIAL[NATURAL_16] */
	RT_LNK uint32 egc_sp_uint32;		/* Dynamic type of SPECIAL[NATURAL_32] */
	RT_LNK uint32 egc_sp_uint64;		/* Dynamic type of SPECIAL[NATURAL_64] */
	RT_LNK uint32 egc_sp_int8;			/* Dynamic type of SPECIAL[INTEGER_8] */
	RT_LNK uint32 egc_sp_int16;		/* Dynamic type of SPECIAL[INTEGER_16] */
	RT_LNK uint32 egc_sp_int32;		/* Dynamic type of SPECIAL[INTEGER_32] */
	RT_LNK uint32 egc_sp_int64;		/* Dynamic type of SPECIAL[INTEGER_64] */
	RT_LNK uint32 egc_sp_real32;			/* Dynamic type of SPECIAL[REAL_32] */
	RT_LNK uint32 egc_sp_real64;		/* Dynamic type of SPECIAL[REAL_64] */
	RT_LNK uint32 egc_sp_pointer;		/* Dynamic type of SPECIAL[POINTER] */
	RT_LNK uint32 egc_sp_ref;			/* Dynamic type of SPECIAL[ANY] */

	RT_LNK int egc_uint8_ref_dtype;	/* Dynamic type of NATURAL_8_REF */
	RT_LNK int egc_uint16_ref_dtype;	/* Dynamic type of NATURAL_16_REF */
	RT_LNK int egc_uint32_ref_dtype;	/* Dynamic type of NATURAL_32_REF */
	RT_LNK int egc_uint64_ref_dtype;	/* Dynamic type of NATURAL_64_REF */
	RT_LNK int egc_int8_ref_dtype;	/* Dynamic type of INTEGER_8_REF */
	RT_LNK int egc_int16_ref_dtype;	/* Dynamic type of INTEGER_16_REF */
	RT_LNK int egc_int32_ref_dtype;	/* Dynamic type of INTEGER_32_REF */
	RT_LNK int egc_int64_ref_dtype;	/* Dynamic type of INTEGER_64_REF */
	RT_LNK int egc_bool_ref_dtype;	/* Dynamic type of BOOLEAN_REF */
	RT_LNK int egc_real32_ref_dtype;	/* Dynamic type of REAL_32_REF */
	RT_LNK int egc_real64_ref_dtype;	/* Dynamic type of REAL_64_REF */
	RT_LNK int egc_char_ref_dtype;	/* Dynamic type of CHARACTER_REF */
	RT_LNK int egc_wchar_ref_dtype;	/* Dynamic type of WIDE_CHARACTER_REF */
	RT_LNK int egc_point_ref_dtype;	/* Dynamic type of POINTER_REF */
	
	RT_LNK int egc_uint8_dtype;	/* Dynamic type of NATURAL_8 */
	RT_LNK int egc_uint16_dtype;	/* Dynamic type of NATURAL_16 */
	RT_LNK int egc_uint32_dtype;	/* Dynamic type of NATURAL_32 */
	RT_LNK int egc_uint64_dtype;	/* Dynamic type of NATURAL_64 */
	RT_LNK int egc_int8_dtype;	/* Dynamic type of INTEGER_8 */
	RT_LNK int egc_int16_dtype;	/* Dynamic type of INTEGER_16 */
	RT_LNK int egc_int32_dtype;	/* Dynamic type of INTEGER_32 */
	RT_LNK int egc_int64_dtype;	/* Dynamic type of INTEGER_64 */
	RT_LNK int egc_bool_dtype;	/* Dynamic type of BOOLEAN */
	RT_LNK int egc_real32_dtype;	/* Dynamic type of REAL_32 */
	RT_LNK int egc_real64_dtype;	/* Dynamic type of REAL_64 */
	RT_LNK int egc_char_dtype;	/* Dynamic type of CHARACTER */
	RT_LNK int egc_wchar_dtype;	/* Dynamic type of WIDE_CHARACTER */
	RT_LNK int egc_point_dtype;	/* Dynamic type of POINTER */

	RT_LNK int egc_except_emnger_dtype;	/* Dynamic type of EXCEPTION_MANAGER */

	RT_LNK struct ctable egc_ce_type;			/* Class name -> type ID */
	RT_LNK struct ctable egc_ce_exp_type;		/* Class name -> type ID for expanded types */
	RT_LNK struct cnode *egc_fsystem;			/* Describes the full frozen Eiffel system */
	RT_LNK struct conform **egc_fco_table; 
	RT_LNK void (*egc_system_mod_init) (void);	/* Module Initialization (from einit.c) */
	RT_LNK struct eif_par_types **egc_partab;	/* Parent table */
	RT_LNK int egc_partab_size;				/* Size of parent table */
	RT_LNK int egc_type_of_gc;

	RT_LNK struct eif_opt *egc_foption;	/* Frozen option table */
#ifdef WORKBENCH
	RT_LNK fnptr *egc_frozen;			/* C routine array (frozen routines) */
	RT_LNK int *egc_fpatidtab;			/* Table of pattern id's indexed by body id's */
	RT_LNK fnptr *egc_address_table;		/* Table of $ operator encapsulation functions */
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
	RT_LNK char *(**egc_exp_create)(void);
	RT_LNK struct ctable *egc_ce_rname;
	RT_LNK long *egc_fnbref ;
	RT_LNK long *egc_fsize;
#endif

#ifdef WORKBENCH
	RT_LNK EIF_TYPED_VALUE (*egc_equal)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE); /* {ANY}.equal */
	RT_LNK EIF_TYPED_VALUE (*egc_twin)(EIF_REFERENCE); /* {ANY}.twin */
#else
	RT_LNK EIF_BOOLEAN   (*egc_equal)(EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE); /* {ANY}.equal */
	RT_LNK EIF_REFERENCE (*egc_twin)(EIF_REFERENCE); /* {ANY}.twin */
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

#ifdef WORKBENCH
	RT_LNK EIF_INTEGER exec_recording_enabled;	  /* Is the Eiffel exec recording on ? */
	RT_LNK int32 egc_rt_extension_dt;				/* E1/einit.c */
	RT_LNK void (*egc_rt_extension_notify)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE);
	RT_LNK EIF_TYPED_VALUE (*egc_rt_extension_notify_argument)(EIF_REFERENCE, EIF_TYPED_VALUE);
#endif
	 
#ifdef __cplusplus
}
#endif

#endif /* _EIF_PROJECT_H_ */


