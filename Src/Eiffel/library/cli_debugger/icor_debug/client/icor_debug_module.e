indexing
	description: "[
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_MODULE
	
inherit

	ICOR_OBJECT
		redefine
			init_icor, clean_on_dispose
		end

	OPERATING_ENVIRONMENT
		undefine
			out
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	init_icor is
			-- 
		do
			Precursor
			name := get_name
			token := get_token
		end

	interface_md_import: like internal_md_import is
			-- IMetaDataImport Interface current ICorDebugModule.
		do
			Result := internal_md_import
			if Result = Void then
				Result := get_md_import_interface
				internal_md_import := Result
			end
		end

feature -- Dispose

	clean_on_dispose is
			-- Clean data on dispose
		do
			Precursor
			if internal_md_import /= Void then
				internal_md_import.clean_on_dispose
				internal_md_import := Void
			end
		end
		
feature {ICOR_EXPORTER} -- Meta Data queries

	md_member_token_by_names (a_type_name: STRING; a_feat_name: STRING): INTEGER is
		local
			l_type_token: INTEGER
		do
			l_type_token := interface_md_import.find_type_def_by_name (a_type_name, 0)
			Result := md_member_token (l_type_token, a_feat_name)
		end

	md_class_token_by_type_name (a_type_name: STRING): INTEGER is
			-- class token for full type name `a_type_name' using the Meta Data
		do
			Result := interface_md_import.find_type_def_by_name (a_type_name, 0)
		end

	md_member_token (a_class_token: INTEGER; a_feat_name: STRING): INTEGER is
			-- member token for type identified by `a_class_token' and `a_feat_name'
		do
			Result := interface_md_import.find_member (a_class_token, a_feat_name)
		end
		
	md_feature_token (a_class_token: INTEGER; a_name: STRING): INTEGER is
			-- Function or Method token
		do
			Result := interface_md_import.find_method (a_class_token, a_name)
		end

	md_type_name (a_class_token: INTEGER): STRING is
			-- Type (Class) name for `a_class_token'.
		do
			Result := interface_md_import.get_typedef_props (a_class_token)
		end
		
	md_member_name (a_feat_token: INTEGER): STRING is
			-- (Feature) name for `a_feat_token'.
		do
			Result := interface_md_import.get_member_props (a_feat_token)
		end		
	
feature {ICOR_EXPORTER} -- Access

	name: STRING
	
	token: INTEGER
	
	module_name: STRING is
			-- Only the module name
			-- remove the path
		local
			l_pos: INTEGER
		do
			Result := get_name
			l_pos := Result.last_index_of (Directory_separator, Result.count)
			if l_pos > 0 then
				Result := Result.substring (l_pos + 1, Result.count)
			end
		end

feature {ICOR_DEBUG_MODULE} -- Restricted Access	

	get_md_import_interface: MD_IMPORT is
			-- Return a meta data interface pointer that can be used to examine the
			-- meta data for this module
		local
			p: POINTER
		do
			last_call_success := cpp_get_MetaDataImport_interface (item, $p)
			if p /= default_pointer then
				debug ("debugger_icor_data")
					io.put_string ("ICOR_DEBUG_MODULE.get_md_import_interface : called %N")					
					io.put_string ("     for [" + module_name + "] %N")					
				end
				create Result.make_by_pointer (p)
			end			
		end
		
feature {ICOR_EXPORTER} -- Access

	get_process: ICOR_DEBUG_PROCESS is
			-- Reference to the ICorDebugProcess
		local
			p: POINTER
		do
			last_call_success := cpp_get_process (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_base_address: INTEGER is
		do
			last_call_success := cpp_get_base_address (item, $Result)
		ensure
			success: last_call_success = 0
		end
		
	get_assembly: ICOR_DEBUG_ASSEMBLY is
			-- Reference to the ICorDebugAssembly
		local
			p: POINTER
		do
			last_call_success := cpp_get_assembly (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_name: STRING is
			-- GetName returns the name of the Module
		local
			p_cchname: INTEGER
			mp_name: MANAGED_POINTER
		do
			create mp_name.make (256 * 2)
			
			last_call_success := cpp_get_name (item, 256, $p_cchname, mp_name.item)
			Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string
		ensure
			success: last_call_success = 0
		end

	enable_jit_debugging (a_trackjitinfo, a_allowjitopts: BOOLEAN) is
			-- EnableJITDebugging controls whether the jitter preserves
            --   debugging information for methods within this module.
            --   If bTrackJITInfo is true, then the jitter preserves
            --   mapping information between the IL version of a function and
            --   the jitted version for functions in the module.  If bAllowJitOpts
            --   is true, then the jitter will generate code with certain (JIT-specific)
            --   optimizations.
            --                                                                           
            --   JITDebug is enabled by default for all modules loaded when the
            --   debugger is active.  Programmatically enabling/disabling these
            --   settings will override global settings.
		do
			last_call_success := cpp_enable_jit_debugging (item, a_trackjitinfo.to_integer, a_allowjitopts.to_integer)
		end

	enable_class_load_callbacks (a_value: BOOLEAN) is
			-- EnableClassLoadCallbacks controls whether on not ClassLoad
	 		-- callbacks are called for the particular module.  ClassLoad
	 		-- callbacks are off by default
		do
			last_call_success := cpp_enable_class_load_callbacks (item, a_value.to_integer)
		ensure
			success: last_call_success = 0
		end

	get_function_from_token (a_token: INTEGER): ICOR_DEBUG_FUNCTION is
		local
			p: POINTER
		do
			last_call_success := cpp_get_function_from_token (item, a_token, $p)
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_function (p)
			end
			debug ("DBG")
				if not last_call_succeed then
					io.put_string ("ERROR [" + last_error_code_id + "] : while ICorDebugModule::GetFunctionFromToken ("+a_token.out+")")
				end
			end
--		ensure
--			success: last_call_success = 0
		end

	get_class_from_token (a_token: INTEGER): ICOR_DEBUG_CLASS is
		local
			p: POINTER
		do
			last_call_success := cpp_get_class_from_token (item, a_token, $p)
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_class (p)
			end
			debug ("DBG")
				if not last_call_succeed then
					io.put_string ("ERROR [" + last_error_code_id + "] : while ICorDebugModule::GetClassFromToken ("+a_token.out+")")
				end
			end
--		ensure
--			success: last_call_success = 0
		end

	create_breakpoint: ICOR_DEBUG_MODULE_BREAKPOINT is
		local
			p: POINTER
		do
			last_call_success := cpp_create_breakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end
		
	get_token: INTEGER is
		do
			last_call_success := cpp_get_token (item, $Result)
		ensure
			success: last_call_success = 0
		end

	is_dynamic: BOOLEAN is
			-- Is dynamic ?
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_dynamic (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

--	get_global_variable_value (a_index: INTEGER): ICOR_DEBUG_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_get_global_variable_value (item, a_index, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			success: last_call_success = 0
--		end

	get_size: INTEGER is
		do
			last_call_success := cpp_get_size (item, $Result)
		ensure
			success: last_call_success = 0
		end

	is_in_memory: BOOLEAN is
			-- If this is a module that exists only in the debuggee's memory,
	 		-- then `is_in_memory' will be set to TRUE
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_in_memory (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Implementation

	frozen cpp_get_process (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetProcess"
		end		
		
	frozen cpp_get_base_address (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(CORDB_ADDRESS*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetBaseAddress"
		end

	frozen cpp_get_assembly (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(ICorDebugAssembly**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetAssembly"
		end		

	frozen cpp_get_name (obj: POINTER; a_cchname: INTEGER; a_pcchname: POINTER; a_szname: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(ULONG32, ULONG32 *, WCHAR*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetName"
		end		

	frozen cpp_enable_jit_debugging (obj: POINTER; a_bool1, a_bool2: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(BOOL,BOOL): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnableJITDebugging"
		end		

	frozen cpp_enable_class_load_callbacks (obj: POINTER; a_bool: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(BOOL): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnableClassLoadCallbacks"
		end		

	frozen cpp_get_function_from_token (obj: POINTER; a_token: INTEGER; a_p_function: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(mdMethodDef, ICorDebugFunction**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetFunctionFromToken"
		end

	frozen cpp_get_class_from_token (obj: POINTER; a_token: INTEGER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(mdTypeDef, ICorDebugClass**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetClassFromToken"
		end

	frozen cpp_create_breakpoint (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(ICorDebugModuleBreakpoint**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CreateBreakpoint"
		end

	frozen cpp_get_meta_data_interface (obj: POINTER; a_refiid: POINTER; a_result_p: POINTER): INTEGER is
			--	 * Return a meta data interface pointer that can be used to examine the
			--	 * meta data for this module.
		external
			"[
				C++ ICorDebugModule signature(REFIID, IUnknown**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetMetaDataInterface"
		end	
	
	frozen cpp_get_token (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(mdModule*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetToken"
		end

	frozen cpp_is_dynamic (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsDynamic"
		end		

	frozen cpp_get_global_variable_value (obj: POINTER; a_index: INTEGER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(mdFieldDef, ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetGlobalVariableValue"
		end

	frozen cpp_get_size (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetSize"
		end	

	frozen cpp_is_in_memory (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugModule signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsInMemory"
		end	
		
feature {NONE} -- IID ...

	cpp_get_MetaDataImport_interface (a_obj: POINTER; a_ptr: POINTER): INTEGER is
			--	 * Return a MetaDataImport interface pointer that can be used to examine the
			--	 * meta data for this module.
		external
			"[
				C++ inline use "cli_headers.h"
			]"
		alias
			"[
   				((ICorDebugModule*)$a_obj)->GetMetaDataInterface(IID_IMetaDataImport,
                                           (IUnknown**)$a_ptr)				
			]"
		end

feature {NONE} -- Internal data

	internal_md_import: MD_IMPORT;
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ICOR_DEBUG_MODULE

