/*
	description: "[
			Dummy declarations for variables and routines called in the run-time but
			generated in a system in `E1/eplug.c'.
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

/*
doc:<file name="eif_project.c" header="eif_project.h" version="$Id$" summary="Declarations for runtime variables called by run-time and initialized by compiler C generated code">
*/

#ifdef __VMS 	/* EIF_VMS is not defined yet */
#pragma module EIF_PROJECT	// force uppercase module name
#endif

#include "eif_project.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
doc:	<attribute name="" return_type="" export="public">
doc:		<summary></summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes></eiffel_classes>
doc:		<fixme></fixme>
doc:	</attribute>
*/

/*
doc:	<attribute name="exception_stacked_managed" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>Is Eiffel call stack managed?</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_public EIF_BOOLEAN exception_stack_managed;

/*
doc:	<attribute name="egc_prof_enabled" return_type="EIF_INTEGER" export="public">
doc:		<summary>To enable or disable profiler.</summary>
doc:		<thread_safety>Safe only if not modified during execution through use of PROFILING_SETTING class.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>PROFILING_SETTING</eiffel_classes>
doc:	</attribute>
*/
rt_public EIF_INTEGER egc_prof_enabled;	  

/*
doc:	<attribute name="exec_recording_enabled" return_type="EIF_INTEGER" export="public">
doc:		<summary>To enable or disable execution recording.</summary>
doc:		<thread_safety>Safe only if not modified during execution. Safe if app is stopped</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>RT_EXTENSION</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
rt_public EIF_INTEGER exec_recording_enabled;	  
#endif


/*
doc:	<attribute name="egc_strmake" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine STRING.make to create Eiffel strings from C.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STRING</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
rt_public void (*egc_strmake)(EIF_REFERENCE, EIF_TYPED_VALUE);
#else
rt_public void (*egc_strmake)(EIF_REFERENCE, EIF_INTEGER);
#endif

#ifdef WORKBENCH
/*
doc:	<attribute name="egc_strset" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine STRING.set_count to set count of Eiffel strings. Only used in workbench mode as computing the offset is not an easy task as the value might change often (especially when melting STRING class).</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STRING</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_strset)(EIF_REFERENCE, EIF_TYPED_VALUE);
#else

/*
doc:	<attribute name="egc_str_count_offset" return_type="uint32" export="public">
doc:		<summary>Offset to `count' attribute from top of STRING object. Used to set count of newly created manifest Eiffel strings. Only used in final mode for efficient setting.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STRING</eiffel_classes>
doc:	</attribute>
*/
rt_public uint32 egc_str_count_offset; 

/*
doc:	<attribute name="egc_str_hash_offset" return_type="uint32" export="public">
doc:		<summary>Offset to `internal_hash_code' attribute from top pf STRING object. Used to set a precomputed hash code of newly created manifest Eiffel strings. Only used in final mode for efficient setting.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STRING</eiffel_classes>
doc:	</attribute>
*/
rt_public uint32 egc_str_hash_offset; 
#endif

/*
doc:	<attribute name="egc_arrmake" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine ARRAY.make to create Eiffel arrays of ANY from C used for command line arguments.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>ARRAY [ANY]</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
rt_public void (*egc_arrmake)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE);
#else
rt_public void (*egc_arrmake)(EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER);
#endif

/*
doc:	<attribute name="egc_routdisp" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine ROUTINE.set_rout_disp used to initialize new ROUTINE objects of type PROCEDURE, FUNCTION or PREDICATE.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>ROUTINE, PROCEDURE, FUNCTION, PREDICATE</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_routdisp)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_INTEGER, EIF_INTEGER,
							   EIF_REFERENCE, EIF_BOOLEAN, EIF_BOOLEAN, EIF_BOOLEAN, EIF_BOOLEAN, EIF_REFERENCE,	EIF_INTEGER); 

#ifdef WORKBENCH
/*
doc:	<attribute name="egc_routdisp_wb" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine ROUTINE.set_rout_disp used to initialize new ROUTINE objects of type PROCEDURE, FUNCTION or PREDICATE.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>ROUTINE, PROCEDURE, FUNCTION, PREDICATE</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_routdisp_wb)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE,
                                  EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE);

#else
/*
doc:	<attribute name="egc_routdisp_fl" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine ROUTINE.set_rout_disp_final used to initialize new ROUTINE objects of type PROCEDURE, FUNCTION or PREDICATE.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>ROUTINE, PROCEDURE, FUNCTION, PREDICATE</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_routdisp_fl)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_BOOLEAN, EIF_INTEGER); 

/*
doc:	<attribute name="egc_correct_mismatch" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine ANY.internal_correct_mismatch which is used to fix a mismatch while retrieving objects from a storable.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>ANY</eiffel_classes>
doc:	</attribute>
*/
#endif
rt_public void (*egc_correct_mismatch)(EIF_REFERENCE); 

/*
doc:	<attribute name="egc_init_exception_data" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine {EXCEPTION_MANAGER}.init_exception which is used to init the exception object.</summary>
doc:		<thread_safety>Safe, per thread data is manipulated.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>EXCEPTION_MANAGER</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
rt_public void (*egc_set_exception_data)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, 
													EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `set_exception_data' feature */
#else
rt_public void (*egc_set_exception_data)(EIF_REFERENCE, EIF_INTEGER, EIF_BOOLEAN, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, 
												EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_BOOLEAN); /* EXCEPTION_MANAGER `set_exception_data' feature */
#endif

/*
doc:	<attribute name="egc_set_last_exception" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine {EXCEPTION_MANAGER}.set_last_exception which is simply used to restore the exception object from runtime as `last_exception'.</summary>
doc:		<thread_safety>Safe, per thread data is manipulated.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>EXCEPTION_MANAGER</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
	rt_public void (*egc_set_last_exception)(EIF_REFERENCE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `set_last_exception' feature */
#else
	rt_public void (*egc_set_last_exception)(EIF_REFERENCE, EIF_REFERENCE); /* EXCEPTION_MANAGER `set_last_exception' feature */
#endif

/*
doc:	<attribute name="egc_last_exception" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine {EXCEPTION_MANAGER}.last_exception which is used to get current last exception object.</summary>
doc:		<thread_safety>Safe, per thread data is manipulated.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>EXCEPTION_MANAGER</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
	rt_public EIF_TYPED_VALUE (*egc_last_exception)(EIF_REFERENCE); /* EXCEPTION_MANAGER `last_exception' feature */
#else
	rt_public EIF_REFERENCE (*egc_last_exception)(EIF_REFERENCE); /* EXCEPTION_MANAGER `last_exception' feature */
#endif

/*
doc:	<attribute name="egc_init_exception_data" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine {EXCEPTION_MANAGER}.is_code_ignored. By querying this runtime knows from the manager if exception of the code should be ignored.</summary>
doc:		<thread_safety>Safe, per thread data is manipulated.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>EXCEPTION_MANAGER</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
	rt_public EIF_TYPED_VALUE (*egc_is_code_ignored)(EIF_REFERENCE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `is_code_ignored' feature */
#else
	rt_public EIF_BOOLEAN (*egc_is_code_ignored)(EIF_REFERENCE, EIF_INTEGER); /* EXCEPTION_MANAGER `is_code_ignored' feature */
#endif

/*
doc:	<attribute name="egc_raise" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine {EXCEPTION_MANAGER}.raise which is used to raise an existing exception object. This is called by runtime to raise the saved exception object by once routines.</summary>
doc:		<thread_safety>Safe, per thread data is manipulated.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>EXCEPTION_MANAGER</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
	rt_public void (*egc_once_raise)(EIF_REFERENCE, EIF_TYPED_VALUE); /* EXCEPTION_MANAGER `once_raise' feature */
#else
	rt_public void (*egc_once_raise)(EIF_REFERENCE, EIF_REFERENCE); /* EXCEPTION_MANAGER `once_raise' feature */
#endif

/*
doc:	<attribute name="egc_init_exception_manager" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine {EXCEPTION_MANAGER}.init_exception_manager which is called by generated code to initialize objects beforehand.</summary>
doc:		<thread_safety>Safe, per thread data is manipulated.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>EXCEPTION_MANAGER</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_init_exception_manager)(EIF_REFERENCE); /* EXCEPTION_MANAGER `init_exception_manager' feature */

/*
doc:	<attribute name="egc_free_preallocated_trace" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine {EXCEPTION_MANAGER}.free_preallocated_trace. </summary>
doc:		<thread_safety>Safe, per thread data is manipulated.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>EXCEPTION_MANAGER</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_free_preallocated_trace)(EIF_REFERENCE); /* EXCEPTION_MANAGER `free_preallocated_trace' feature */

rt_public int egc_str_dtype;
rt_public int egc_arr_dtype;
rt_public int egc_tup_dtype;
rt_public int32 egc_disp_rout_id;
rt_public int egc_bit_dtype;

rt_public uint32 egc_sp_bool;
rt_public uint32 egc_sp_char;
rt_public uint32 egc_sp_wchar;
rt_public uint32 egc_sp_uint8;
rt_public uint32 egc_sp_uint16;
rt_public uint32 egc_sp_uint32;
rt_public uint32 egc_sp_uint64;
rt_public uint32 egc_sp_int8;
rt_public uint32 egc_sp_int16;
rt_public uint32 egc_sp_int32;
rt_public uint32 egc_sp_int64;
rt_public uint32 egc_sp_real32;
rt_public uint32 egc_sp_real64;
rt_public uint32 egc_sp_pointer;
rt_public uint32 egc_sp_ref;

rt_public int egc_uint8_ref_dtype;	
rt_public int egc_uint16_ref_dtype;	
rt_public int egc_uint32_ref_dtype;	
rt_public int egc_uint64_ref_dtype;	
rt_public int egc_int8_ref_dtype;	
rt_public int egc_int16_ref_dtype;	
rt_public int egc_int32_ref_dtype;	
rt_public int egc_int64_ref_dtype;	
rt_public int egc_bool_ref_dtype;	
rt_public int egc_real32_ref_dtype;	
rt_public int egc_real64_ref_dtype;	
rt_public int egc_char_ref_dtype;	
rt_public int egc_wchar_ref_dtype;	
rt_public int egc_point_ref_dtype;	

rt_public int egc_uint8_dtype;
rt_public int egc_uint16_dtype;	
rt_public int egc_uint32_dtype;	
rt_public int egc_uint64_dtype;	
rt_public int egc_int8_dtype;	
rt_public int egc_int16_dtype;	
rt_public int egc_int32_dtype;	
rt_public int egc_int64_dtype;	
rt_public int egc_bool_dtype;	
rt_public int egc_real32_dtype;	
rt_public int egc_real64_dtype;	
rt_public int egc_char_dtype;	
rt_public int egc_wchar_dtype;	
rt_public int egc_point_dtype;

rt_public int egc_except_emnger_dtype;
rt_public int egc_exception_dtype;

rt_public struct ctable egc_ce_type;
rt_public struct ctable egc_ce_exp_type;
rt_public struct cnode *egc_fsystem;	
rt_public struct conform **egc_fco_table;  
rt_public struct eif_par_types **egc_partab;
rt_public int egc_partab_size;
rt_public void (*egc_system_mod_init) (void);	
rt_public int egc_type_of_gc;
rt_public struct eif_opt *egc_foption;	


#ifdef WORKBENCH

rt_public fnptr *egc_frozen;			
rt_public int *egc_fpatidtab;		
rt_public fnptr *egc_address_table;	
rt_public struct p_interface *egc_fpattern;
rt_public void (*egc_einit)(void);	
rt_public void (*egc_tabinit)(void);	
rt_public int32 **egc_fcall;
rt_public struct rout_info *egc_forg_table;
rt_public int16 *egc_fdtypes;

#else
rt_public void (**egc_edispose)(void);
rt_public char *(**egc_ecreate)(void);
rt_public char *(**egc_exp_create)(void);
rt_public struct ctable *egc_ce_rname;
rt_public long *egc_fnbref ;
rt_public long *egc_fsize;
#endif

#ifdef WORKBENCH
	rt_public EIF_TYPED_VALUE (*egc_equal)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE); /* {ANY}.equal */
	rt_public EIF_TYPED_VALUE (*egc_twin)(EIF_REFERENCE); /* {ANY}.twin */
#else
	rt_public EIF_BOOLEAN   (*egc_equal)(EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE); /* {ANY}.equal */
	rt_public EIF_REFERENCE (*egc_twin)(EIF_REFERENCE); /* {ANY}.twin */
#endif

rt_public int32 egc_rcdt;				/* E1/einit.c */
rt_public int32 egc_rcorigin;			/* E1/einit.c */
rt_public int32 egc_rcoffset;			/* E1/einit.c */
rt_public int32 egc_rcarg;				/* E1/einit.c */

rt_public char *egc_system_name;
		/* Used in `misc.c' for storing and retrieving of Windows registry keys.
		 * Used in `update.c' to find out what the name of a melted file should
		 * be for current system.
		 */

rt_public char *egc_system_location;
		/* Used in `option.c' to find out where the `profinfo' file
		 * should be generated when profiling a system. 
		 */

rt_public EIF_INTEGER egc_compiler_tag;
rt_public EIF_INTEGER egc_project_version;

rt_public int egc_platform_level;
		/* Used in `main.c' to find out whether or not we are handling
		 * a unlocked version of the ISE Eiffel environment or not. If
		 * it was not the case a message is displayed.
		 */


/*
doc:	<attribute name="egc_rt_extension_notify" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine RT_EXTENSION.notify to notify event from C.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>RT_EXTENSION</eiffel_classes>
doc:	</attribute>
*/
#ifdef WORKBENCH
rt_public int32 egc_rt_extension_dt;				/* E1/einit.c */
rt_public void (*egc_rt_extension_notify)(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE);
rt_public EIF_TYPED_VALUE (*egc_rt_extension_notify_argument)(EIF_REFERENCE, EIF_TYPED_VALUE);
#endif

#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/

