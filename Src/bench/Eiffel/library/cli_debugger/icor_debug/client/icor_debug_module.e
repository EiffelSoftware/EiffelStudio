indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_MODULE
	
inherit

	ICOR_OBJECT
		redefine
			init_icor
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
	
feature {ICOR_EXPORTER} -- Access

	name: STRING
	
	token: INTEGER
	
	file_name: STRING is
			-- 
		local
			l_pos: INTEGER
		do
			Result := get_name
			l_pos := Result.last_index_of (Directory_separator, Result.count)
			if l_pos >0 then
				Result := Result.substring (l_pos + 1, Result.count)			
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
		ensure
			success: last_call_success = 0
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
				create Result.make_by_pointer (p)
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
				create Result.make_by_pointer (p)
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

end -- class ICOR_DEBUG_MODULE

