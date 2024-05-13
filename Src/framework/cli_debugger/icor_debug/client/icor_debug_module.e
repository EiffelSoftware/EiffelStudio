note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_MODULE

inherit
	ICOR_DEBUG_I

	OPERATING_ENVIRONMENT

feature {ICOR_EXPORTER} -- Access

	interface_md_import: like internal_md_import
			-- IMetaDataImport Interface current ICorDebugModule.
		do
			Result := internal_md_import
			if Result = Void then
				Result := get_md_import_interface
				internal_md_import := Result
			end
		end

feature {ICOR_OBJECTS_MANAGER} -- Dispose

	clean_on_dispose
			-- Clean data on dispose
		do
--			Precursor
			if attached internal_md_import as i then
				i.clean_on_dispose
				internal_md_import := Void
			end
		end

feature {ICOR_EXPORTER} -- Meta Data queries

	md_member_token_by_names (a_type_name: STRING; a_feat_name: STRING): NATURAL_32
		require
			a_type_name_attached: a_type_name /= Void
			a_feat_name_attached: a_feat_name /= Void
		local
			l_type_token: NATURAL_32
		do
			l_type_token := interface_md_import.find_type_def_by_name (a_type_name, 0)
			Result := md_member_token (l_type_token, a_feat_name)
		end

	md_class_token_by_type_name (a_type_name: STRING): NATURAL_32
			-- class token for full type name `a_type_name' using the Meta Data
		require
			a_type_name_attached: a_type_name /= Void
		do
			Result := interface_md_import.find_type_def_by_name (a_type_name, 0)
		end

	md_member_token (a_class_token: NATURAL_32; a_feat_name: STRING): NATURAL_32
			-- member token for type identified by `a_class_token' and `a_feat_name'
		require
			a_feat_name_attached: a_feat_name /= Void
		do
			Result := interface_md_import.find_member (a_class_token, a_feat_name)
		end

	md_field_token (a_class_token: NATURAL_32; a_field_name: STRING): NATURAL_32
			-- field token for type identified by `a_class_token' and `a_field_name'
		require
			a_feat_name_attached: a_field_name /= Void
		do
			Result := interface_md_import.find_field (a_class_token, a_field_name)
		end

	md_feature_token (a_class_token: NATURAL_32; a_name: STRING): NATURAL_32
			-- Function or Method token
		require
			a_name_attached: a_name /= Void
		do
			Result := interface_md_import.find_method (a_class_token, a_name)
		end

	md_type_name (a_class_token: NATURAL_32): detachable STRING_32
			-- Type (Class) name for `a_class_token'.
		do
			Result := interface_md_import.get_typedef_props (a_class_token)
		end

	md_member_name (a_feat_token: NATURAL_32): detachable STRING_32
			-- (Feature) name for `a_feat_token'.
		do
			if attached interface_md_import.get_member_props (a_feat_token) as t then
				Result := t.name
			end
		end

feature {ICOR_EXPORTER} -- Access

	name: STRING_32
			-- Module's name
		do
			Result := private_name
			if Result = Void then
				if attached get_name as l_name then
					Result := l_name
				else
					check module_has_name: False end
					create Result.make_from_string_general ("Module-" + item.out + "-")
				end
				private_name := Result
			else
				set_last_call_success (0)
			end
		end

	module_name: STRING_32
			-- Only the module name
			-- remove the path
		require
			name_attached: name /= Void
		local
			l_pos: INTEGER
		do
			Result := name
			l_pos := Result.last_index_of (Directory_separator, Result.count)
			if l_pos > 0 then
				Result := Result.substring (l_pos + 1, Result.count)
			end
		end

	has_short_name (n: READABLE_STRING_GENERAL): BOOLEAN
			-- Is Current's short name `n' ?
			-- i.e: is `get_name' ends with `n.dll' or `n.exe' ?
		local
			mn: STRING_32
			i, j: INTEGER
		do
			mn := name
			from
				Result := mn.count >= n.count + 4 -- i.e: (n + ".dll").count
				i := mn.count - 4
				j := n.count
			until
				not Result or j = 0 -- (or i = 0, but j = 0 before i)
			loop
				Result := mn.item (i).lower = n.item (j).lower
				i := i - 1
				j := j - 1
			end
		end

feature {NONE} -- Access

	private_name: like name
			-- Module's name

feature {ICOR_DEBUG_MODULE} -- Restricted Access

	get_md_import_interface: ICOR_MD_IMPORT
			-- Return a meta data interface pointer that can be used to examine the
			-- meta data for this module
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_MetaDataImport_interface (item, $p))
			if p /= default_pointer then
				debug ("debugger_icor_data")
					io.put_string ("ICOR_DEBUG_MODULE.get_md_import_interface : called %N")
					io.put_string_32 ({STRING_32} "     for [" + module_name + "] %N")
				end
				Result := new_md_import (p)
			end
		end

feature {ICOR_EXPORTER} -- Access

	get_process: ICOR_DEBUG_PROCESS
			-- Reference to the ICorDebugProcess
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_process (item, $p))
			if p /= default_pointer then
				Result := new_process (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_base_address: NATURAL_64
		do
			set_last_call_success (cpp_get_base_address (item, $Result))
		ensure
			success: last_call_success = 0
		end

	get_assembly: ICOR_DEBUG_ASSEMBLY
			-- Reference to the ICorDebugAssembly
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_assembly (item, $p))
			if p /= default_pointer then
				Result := new_assembly (p)
			end
		ensure
			success: last_call_success = 0
		end

	enable_jit_debugging (a_trackjitinfo, a_allowjitopts: BOOLEAN)
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
			set_last_call_success (cpp_enable_jit_debugging (item, a_trackjitinfo.to_integer, a_allowjitopts.to_integer))
		end

	enable_class_load_callbacks (a_value: BOOLEAN)
			-- EnableClassLoadCallbacks controls whether on not ClassLoad
			-- callbacks are called for the particular module.  ClassLoad
			-- callbacks are off by default
		do
			set_last_call_success (cpp_enable_class_load_callbacks (item, a_value.to_integer))
		ensure
			success: last_call_success = 0
		end

	get_function_from_token (a_token: NATURAL_32): ICOR_DEBUG_FUNCTION
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_function_from_token (item, a_token, $p))
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_function (p, Current)
			end
			debug ("DBG")
				if not last_call_succeed then
					io.put_string ("ERROR [" + last_error_code_id + "] : while ICorDebugModule::GetFunctionFromToken (" + a_token.out + ")")
				end
			end
--		ensure
--			success: last_call_success = 0
		end

	get_class_from_token (a_token: NATURAL_32): ICOR_DEBUG_CLASS
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_class_from_token (item, a_token, $p))
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_class (p, Current)
			end
			debug ("DBG")
				if not last_call_succeed then
					io.put_string ("ERROR [" + last_error_code_id + "] : while ICorDebugModule::GetClassFromToken (" + a_token.out + ")")
				end
			end
--		ensure
--			success: last_call_success = 0
		end

	create_breakpoint: ICOR_DEBUG_MODULE_BREAKPOINT
		local
			p: POINTER
		do
			set_last_call_success (cpp_create_breakpoint (item, $p))
			if p /= default_pointer then
				Result := new_module_breakpoint (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_token: NATURAL_32
		do
			set_last_call_success (cpp_get_token (item, $Result))
		ensure
			success: last_call_success = 0
		end

	is_dynamic: BOOLEAN
			-- Is dynamic ?
		local
			r: INTEGER
		do
			set_last_call_success (cpp_is_dynamic (item, $r))
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

--	get_global_variable_value (a_index: INTEGER): ICOR_DEBUG_VALUE is
--		local
--			p: POINTER
--		do
--			set_last_call_success (cpp_get_global_variable_value (item, a_index, $p))
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			success: last_call_success = 0
--		end

	get_size: NATURAL_32
		do
			set_last_call_success (cpp_get_size (item, $Result))
		ensure
			success: last_call_success = 0
		end

	is_in_memory: BOOLEAN
			-- If this is a module that exists only in the debuggee's memory,
			-- then `is_in_memory' will be set to TRUE
		local
			r: INTEGER
		do
			set_last_call_success (cpp_is_in_memory (item, $r))
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Access

	get_name: detachable STRING_32
			-- GetName returns the name of the Module
		local
			p_cchname: NATURAL_32
			mp_name: MANAGED_POINTER
		do
			set_last_call_success (0)
			create mp_name.make (256 * 2)

			set_last_call_success (cpp_get_name (item, 256, $p_cchname, mp_name.item))
			if mp_name.item /= Default_pointer then
				Result := (create {CLI_STRING}.make_by_pointer (mp_name.item)).string_32
			end
		ensure
			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Implementation

	frozen cpp_get_process (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetProcess"
		ensure
			is_class: class
		end

	frozen cpp_get_base_address (obj: POINTER; a_p: TYPED_POINTER [NATURAL_64]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(CORDB_ADDRESS*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetBaseAddress"
		ensure
			is_class: class
		end

	frozen cpp_get_assembly (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(ICorDebugAssembly**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetAssembly"
		ensure
			is_class: class
		end

	frozen cpp_get_name (obj: POINTER; a_cchname: NATURAL_32; a_pcchname: TYPED_POINTER [NATURAL_32]; a_szname: POINTER): INTEGER
		external
			"[
				C++ ICorDebugModule signature(ULONG32, ULONG32 *, WCHAR*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetName"
		ensure
			is_class: class
		end

	frozen cpp_enable_jit_debugging (obj: POINTER; a_bool1, a_bool2: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugModule signature(BOOL,BOOL): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnableJITDebugging"
		ensure
			is_class: class
		end

	frozen cpp_enable_class_load_callbacks (obj: POINTER; a_bool: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugModule signature(BOOL): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnableClassLoadCallbacks"
		ensure
			is_class: class
		end

	frozen cpp_get_function_from_token (obj: POINTER; a_token: NATURAL_32; a_p_function: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(mdMethodDef, ICorDebugFunction**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetFunctionFromToken"
		ensure
			is_class: class
		end

	frozen cpp_get_class_from_token (obj: POINTER; a_token: NATURAL_32; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(mdTypeDef, ICorDebugClass**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetClassFromToken"
		ensure
			is_class: class
		end

	frozen cpp_create_breakpoint (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(ICorDebugModuleBreakpoint**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CreateBreakpoint"
		ensure
			is_class: class
		end

	frozen cpp_get_meta_data_interface (obj: POINTER; a_refiid: POINTER; a_result_p: TYPED_POINTER [POINTER]): INTEGER
			--	 * Return a meta data interface pointer that can be used to examine the
			--	 * meta data for this module.
		external
			"[
				C++ ICorDebugModule signature(REFIID, IUnknown**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetMetaDataInterface"
		ensure
			is_class: class
		end

	frozen cpp_get_token (obj: POINTER; a_p: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(mdModule*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetToken"
		ensure
			is_class: class
		end

	frozen cpp_is_dynamic (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsDynamic"
		ensure
			is_class: class
		end

	frozen cpp_get_global_variable_value (obj: POINTER; a_index: NATURAL_32; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(mdFieldDef, ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetGlobalVariableValue"
		ensure
			is_class: class
		end

	frozen cpp_get_size (obj: POINTER; a_result: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetSize"
		ensure
			is_class: class
		end

	frozen cpp_is_in_memory (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugModule signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsInMemory"
		ensure
			is_class: class
		end

feature {NONE} -- IID ...

	cpp_get_MetaDataImport_interface (a_obj: POINTER; a_ptr: TYPED_POINTER [POINTER]): INTEGER
			--	 * Return a MetaDataImport interface pointer that can be used to examine the
			--	 * meta data for this module.
		external
			"[
				C++ inline use "cli_debugger_headers.h"
			]"
		alias
			"[
								((ICorDebugModule*)$a_obj)->GetMetaDataInterface(IID_IMetaDataImport,
				                                        (IUnknown**)$a_ptr)
			]"
		ensure
			is_class: class
		end

feature {NONE} -- Internal data

	internal_md_import: detachable ICOR_MD_IMPORT;


end
