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

#ifdef __VMS
#pragma module EIF_PROJECT  // force uppercase module name
#endif

#include "eif_project.h"

#ifdef EIF_VMS
/* The first one is to upcase the module name, but why the second? */
//#pragma message disable EXTRAMODULE
#pragma module EIF_PROJECT
#endif

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
doc:	<attribute name="egc_strmake" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine STRING.make to create Eiffel strings from C.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STRING</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_strmake)(EIF_REFERENCE, EIF_INTEGER); 

#ifdef WORKBENCH
/*
doc:	<attribute name="egc_strset" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine STRING.set_count to set count of Eiffel strings. Only used in workbench mode as computing the offset is not an easy task as the value might change often (especially when melting STRING class).</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>STRING</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_strset)(EIF_REFERENCE, EIF_INTEGER); 
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
rt_public void (*egc_arrmake)(EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER);	

/*
doc:	<attribute name="egc_routdisp" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine ROUTINE.set_rout_disp used to initialize new ROUTINE objects of type PROCEDURE, FUNCTION or PREDICATE.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>ROUTINE, PROCEDURE, FUNCTION, PREDICATE</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_routdisp)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE); 

/*
doc:	<attribute name="egc_correct_mismatch" return_type="fnptr" export="public">
doc:		<summary>Address of Eiffel routine ANY.internal_correct_mismatch which is used to fix a mismatch while retrieving objects from a storable.</summary>
doc:		<thread_safety>Safe as initialized once at the very beginning of an execution.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<eiffel_classes>ANY</eiffel_classes>
doc:	</attribute>
*/
rt_public void (*egc_correct_mismatch)(EIF_REFERENCE); 

rt_public int egc_str_dtype;
rt_public int egc_arr_dtype;
rt_public int egc_tup_dtype;
rt_public int32 egc_disp_rout_id;
rt_public int egc_bit_dtype;

rt_public uint32 egc_sp_bool;
rt_public uint32 egc_sp_char;
rt_public uint32 egc_sp_wchar;
/* Note remove initialization to -1 when compiler will generate
 * their initialization. */
rt_public uint32 egc_sp_uint8 = -1;
rt_public uint32 egc_sp_uint16 = -1;
rt_public uint32 egc_sp_uint32 = -1;
rt_public uint32 egc_sp_uint64 = -1;
rt_public uint32 egc_sp_int8;
rt_public uint32 egc_sp_int16;
rt_public uint32 egc_sp_int32;
rt_public uint32 egc_sp_int64;
rt_public uint32 egc_sp_real32;
rt_public uint32 egc_sp_real64;
rt_public uint32 egc_sp_pointer;
rt_public uint32 egc_sp_ref;

rt_public int egc_uint8_ref_dtype = -1;	
rt_public int egc_uint16_ref_dtype = -1;	
rt_public int egc_uint32_ref_dtype = -1;	
rt_public int egc_uint64_ref_dtype = -1;	
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

rt_public int egc_uint8_dtype = -1;
rt_public int egc_uint16_dtype = -1;	
rt_public int egc_uint32_dtype = -1;	
rt_public int egc_uint64_dtype = -1;	
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

rt_public struct ctable egc_ce_type;
rt_public struct ctable egc_ce_exp_type;
rt_public struct cnode *egc_fsystem;	
rt_public struct conform **egc_fco_table;  
rt_public struct eif_par_types **egc_partab;
rt_public int egc_partab_size;
rt_public void (*egc_system_mod_init) (void);	
rt_public int egc_type_of_gc;


#ifdef WORKBENCH

rt_public fnptr *egc_frozen;			
rt_public int *egc_fpatidtab;		
rt_public struct eif_opt *egc_foption;	
rt_public fnptr **egc_address_table;	
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

rt_public EIF_REFERENCE (*egc_twin)(EIF_REFERENCE); /* {ANY}.twin */

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

#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/

