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

	EIF_BOOLEAN exception_stack_managed;	

	EIF_INTEGER egc_prof_enabled;	  
	void (*egc_strmake)(char *, EIF_INTEGER); 
	void (*egc_strset)(char *, EIF_INTEGER); 
	void (*egc_arrmake)(char *, EIF_INTEGER, EIF_INTEGER);	
	void (*egc_tupmake)(char *);
	void (*egc_routdisp)(char *, char *, char *, char *, EIF_INTEGER); 

	int egc_str_dtype;				
	int egc_arr_dtype;				
	int egc_tup_dtype;
	int32 egc_disp_rout_id;			
	int egc_bit_dtype;			
	int egc_any_dtype;
	int egc_sp_bool;			
	int egc_sp_char;			
	int egc_sp_int;			
	int egc_sp_real;			
	int egc_sp_double;		
	int egc_sp_pointer;		

	int egc_int_ref_dtype;	
	int egc_bool_ref_dtype;	
	int egc_real_ref_dtype;	
	int egc_doub_ref_dtype;	
	int egc_char_ref_dtype;	
	int egc_point_ref_dtype;	

	struct ctable egc_ce_type;			
	struct ctable egc_ce_gtype;			
	struct cnode *egc_fsystem;	
	struct conform **egc_fco_table;  
	struct eif_par_types **egc_partab;
	int    egc_partab_size;
	void (*egc_system_mod_init) (void);	


#ifdef WORKBENCH

	fnptr *egc_frozen;			
	int *egc_fpatidtab;		
	struct eif_opt *egc_foption;	
	fnptr **egc_address_table;	
	uint32 *egc_fdispatch;		
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

	int32 egc_rcdt;
	int32 egc_rcorigin;
	int32 egc_rcoffset;
	int egc_rcarg;

	char *egc_system_name;
	EIF_INTEGER egc_compiler_tag;

#ifdef __cplusplus
}
#endif

