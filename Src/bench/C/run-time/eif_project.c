/*

 #####   #####    ####        #  ######   ####    #####           #### 
 #    #  #    #  #    #       #  #       #    #     #            #    #
 #    #  #    #  #    #       #  #####   #          #            #
 #####   #####   #    #       #  #       #          #     ###    #    
 #       #   #   #    #  #    #  #       #    #     #     ###    #    #
 #       #    #   ####    ####   ######   ####      #     ###     ####

Dummy declarations for variables and routines called in the run-time but
generated in a system

*/
#include "eif_project.h"

#ifdef __cplusplus
extern "C" {
#endif

EIF_BOOLEAN exception_stack_managed;	/* Is the stack managed (always True in workbench mode) */

EIF_INTEGER egc_prof_enabled;	  /* Is the Eiffel profiler on */
void (*egc_strmake)(char *, EIF_INTEGER);	/* STRING creation feature */
void (*egc_strset)(char *, EIF_INTEGER);	/* STRING `set_count' feature */
void (*egc_arrmake)(char *, EIF_INTEGER, EIF_INTEGER);	/* STRING creation feature */
int egc_str_dtype;				/* Dynamic type for string */
int egc_arr_dtype;				/* Dynamic type for ARRAY[ANY] */
int32 egc_disp_rout_id;			/* Dispose routine id */ 
int egc_bit_dtype;			/* Dynamic type of BIT, E1/plug.c */

int egc_sp_bool;			/* Dynamic type of SPECIAL[BOOLEAN] */
int egc_sp_char;			/* Dynamic type of SPECIAL[CHARACTER] */
int egc_sp_int;			/* Dynamic type of SPECIAL[INTEGER] */
int egc_sp_real;			/* Dynamic type of SPECIAL[REAL] */
int egc_sp_double;		/* Dynamic type of SPECIAL[DOUBLE] */
int egc_sp_pointer;		/* Dynamic type of SPECIAL[POINTER] */

int egc_int_ref_dtype;	/* Dynamic type of INTEGER_REF */
int egc_bool_ref_dtype;	/* Dynamic type of BOOLEAN_REF */
int egc_real_ref_dtype;	/* Dynamic type of REAL_REF */
int egc_doub_ref_dtype;	/* Dynamic type of DOUBLE_REF */
int egc_char_ref_dtype;	/* Dynamic type of CHARACTER_REF */
int egc_point_ref_dtype;	/* Dynamic type of POINTER_REF */

fnptr *egc_frozen;			/* C routine array (frozen routines) */
int *egc_fpatidtab;		/* Table of pattern id's indexed by body id's */
struct ctable egc_ce_type;			/* Class name -> type ID */
struct ctable egc_ce_gtype;			/* Generic class name -> gt_info */
struct eif_opt *egc_foption;	/* Frozen option table */
fnptr **egc_address_table;	/* Table of $ operator encapsulation functions */
uint32 *egc_fdispatch;		/* Frozen disaptch table */

struct cnode *egc_fsystem;	/* Describes the full frozen Eiffel system */
int32 **egc_fcall;			/* Routine id arrays indexed by feature id's */
struct rout_info *egc_forg_table;	/* Routine origin/offset table */
int16 *egc_fdtypes;				/* Dynamic type  array indexed by old
  							 	 	 * dynamic types (for re-freezing) */

struct conform **egc_fco_table;  
struct p_interface *egc_fpattern;

void (*egc_einit)(void);		/* System-dependent initializations, E1/einit.c */
void (*egc_system_mod_init) (void);	/* Module Initialization (from einit.c) */
void (*egc_tabinit)(void);		/* E1/einit.c */

int32 egc_rcdt;				/* E1/einit.c */
int32 egc_rcorigin;			/* E1/einit.c */
int32 egc_rcoffset;			/* E1/einit.c */
int egc_rcarg;				/* E1/einit.c */

#ifdef __cplusplus
}
#endif

