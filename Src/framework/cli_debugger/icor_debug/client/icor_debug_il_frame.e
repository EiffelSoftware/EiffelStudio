note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_IL_FRAME

inherit
	ICOR_DEBUG_FRAME

	COR_DEBUG_MAPPING_RESULT_ENUM
		undefine
			out
		end

feature {ICOR_EXPORTER} -- Properties

	last_cordebugmapping_result: INTEGER

	last_cordebugmapping_result_to_string: STRING
		do
			Result := enum_cor_debug_mapping_result_to_string (last_cordebugmapping_result)
		end

feature {ICOR_EXPORTER} -- Access

	get_ip_as_integer_32: INTEGER
			-- Truncated value from NATURAL_32
		do
			Result := get_ip.as_integer_32
		end

	get_ip: NATURAL_32
			-- get OffSet
			-- set `last_cordebugmapping_result' value
		local
			l_noffset: NATURAL_32
		do
			set_last_call_success (cpp_get_ip (item, $l_noffset, $last_cordebugmapping_result))
			Result := l_noffset
			debug ("DEBUGGER_EIFNET_DATA","DEBUGGER_TRACE_STEPPING")
				io.error.put_string (generator + "::GetIP -> 0x" + l_noffset.to_hex_string
							+ "  : MappingResult="
							+ enum_cor_debug_mapping_result_to_string (last_cordebugmapping_result)
					)
				io.error.put_string ("%N")
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_local_variables: ICOR_DEBUG_VALUE_ENUM
		local
			p: POINTER
		do
			set_last_call_success (cpp_enumerate_local_variables (item, $p))
			if p /= default_pointer then
				Result := new_value_enum (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_local_variable (a_index: INTEGER): ICOR_DEBUG_VALUE
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_local_variable (item, a_index, $p))
			if p /= default_pointer then
				Result := new_value (p)
			end
		ensure
			success: last_call_succeed
		end

	enumerate_arguments: ICOR_DEBUG_VALUE_ENUM
		local
			p: POINTER
		do
			set_last_call_success (cpp_enumerate_arguments (item, $p))
			if p /= default_pointer then
				Result := new_value_enum (p)
			end
		ensure
			success: last_call_succeed
		end

	get_argument (a_index: INTEGER): ICOR_DEBUG_VALUE
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_argument (item, a_index, $p))
			if p /= default_pointer then
				Result := new_value (p)
			end
		end

	get_stack_depth: NATURAL_32
		do
			set_last_call_success (cpp_get_stack_depth (item, $Result))
		end

feature {NONE} -- Implementation

	cpp_get_ip (obj: POINTER; a_p_offset: TYPED_POINTER [NATURAL_32]; a_p_mapping: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugILFrame signature(ULONG32*, CorDebugMappingResult*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetIP"
		end

	cpp_enumerate_local_variables (obj: POINTER; a_result: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugILFrame signature(ICorDebugValueEnum**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateLocalVariables"
		end

	cpp_get_local_variable (obj: POINTER; a_index: INTEGER; a_result: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugILFrame signature(DWORD,ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetLocalVariable"
		end

	cpp_enumerate_arguments (obj: POINTER; a_result: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugILFrame signature(ICorDebugValueEnum**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateArguments"
		end

	cpp_get_argument (obj: POINTER; a_index: INTEGER; a_result: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugILFrame signature(DWORD,ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetArgument"
		end

	cpp_get_stack_depth (obj: POINTER; a_depth: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugILFrame signature(ULONG32 *): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetStackDepth"
		end


end
