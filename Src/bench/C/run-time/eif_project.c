/*

 #####   #####    ####        #  ######   ####    #####           #### 
 #    #  #    #  #    #       #  #       #    #     #            #    #
 #    #  #    #  #    #       #  #####   #          #            #
 #####   #####   #    #       #  #       #          #     ###    #    
 #       #   #   #    #  #    #  #       #    #     #     ###    #    #
 #       #    #   ####    ####   ######   ####      #     ###     ####

Dummy declarations for variables and routines called in the run-time but
generated in a system in `E1/eplug.c'.

*/

#include "eif_project.h"

#ifdef __cplusplus
extern "C" {
#endif

	EIF_BOOLEAN exception_stack_managed;
	EIF_INTEGER egc_prof_enabled;	  
	void (*egc_strmake)(EIF_REFERENCE, EIF_INTEGER); 
	void (*egc_strset)(EIF_REFERENCE, EIF_INTEGER); 
	void (*egc_arrmake)(EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER);	
	void (*egc_routdisp)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE); 

	int egc_str_dtype;
	int egc_arr_dtype;
	int egc_tup_dtype;
	int32 egc_disp_rout_id;
	int egc_bit_dtype;
	int egc_sp_bool;
	int egc_sp_char;
	int egc_sp_wchar;
	int egc_sp_int8;
	int egc_sp_int16;
	int egc_sp_int32;
	int egc_sp_int64;
	int egc_sp_real;
	int egc_sp_double;
	int egc_sp_pointer;

	int egc_int8_ref_dtype;	
	int egc_int16_ref_dtype;	
	int egc_int32_ref_dtype;	
	int egc_int64_ref_dtype;	
	int egc_bool_ref_dtype;	
	int egc_real_ref_dtype;	
	int egc_doub_ref_dtype;	
	int egc_char_ref_dtype;	
	int egc_wchar_ref_dtype;	
	int egc_point_ref_dtype;	

	struct ctable egc_ce_type;			
	struct ctable egc_ce_gtype;			
	struct cnode *egc_fsystem;	
	struct conform **egc_fco_table;  
	struct eif_par_types **egc_partab;
	int    egc_partab_size;
	void (*egc_system_mod_init) (void);	
	int egc_type_of_gc;


#ifdef WORKBENCH

	fnptr *egc_frozen;			
	int *egc_fpatidtab;		
	struct eif_opt *egc_foption;	
	fnptr **egc_address_table;	
	struct p_interface *egc_fpattern;
	void (*egc_einit)(void);	
	void (*egc_tabinit)(void);	
	int32 **egc_fcall;
	struct rout_info *egc_forg_table;
	int16 *egc_fdtypes;

#else
	void (**egc_edispose)(void);
	char *(**egc_ecreate)(void);
	struct ctable *egc_ce_rname;
	long *egc_fnbref ;
	long *egc_fsize;
#endif

	int32 egc_rcdt;				/* E1/einit.c */
	int32 egc_rcorigin;			/* E1/einit.c */
	int32 egc_rcoffset;			/* E1/einit.c */
	int32 egc_rcarg;				/* E1/einit.c */

	char *egc_system_name;
			/* Used in `misc.c' for storing and retrieving of Windows registry keys.
			 * Used in `update.c' to find out what the name of a melted file should
			 * be for current system.
			 */

	char *egc_system_location;
			/* Used in `option.c' to find out where the `profinfo' file
			 * should be generated when profiling a system. 
			 */

	EIF_INTEGER egc_compiler_tag;
	EIF_INTEGER egc_project_version;

	int egc_platform_level;
			/* Used in `main.c' to find out whether or not we are handling
			 * a unlocked version of the ISE Eiffel environment or not. If
			 * it was not the case a message is displayed.
			 */

#ifdef __cplusplus
}
#endif

