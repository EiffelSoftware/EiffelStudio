indexing
	description: "[ 
		interface ICorDebugILFrame : ICorDebugFrame
			GetIP
			SetIP
			EnumerateLocalVariables
			GetLocalVariable
			EnumerateArguments
			GetArgument
			GetStackDepth
			GetStackValue
			CanSetIP
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_IL_FRAME

inherit
	ICOR_DEBUG_FRAME
		redefine
			init_icor
		end

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	init_icor is
			-- 
		do
			Precursor
			ip := get_ip
		end		

feature {ICOR_EXPORTER} -- Properties

	ip: INTEGER

feature {ICOR_EXPORTER} -- Access

	get_ip: INTEGER is
			-- get OffSet
		local
			l_noffset: INTEGER
			l_cordebugmapping_result: INTEGER
		do
			last_call_success := cpp_get_ip (item, $l_noffset, $l_cordebugmapping_result)
			Result := l_noffset
			debug ("DEBUGGER_EIFNET_DATA","DEBUGGER_TRACE_STEPPING")
				io.error.put_string (generator + "::GetIP -> 0x" + l_noffset.to_hex_string
							+ "  : MappingResult="
--							+"0x"+ l_cordebugmapping_result.to_hex_string
					)
				inspect l_cordebugmapping_result 
				when 0x1 then io.error.put_string ("MAPPING_PROLOG"); 				
				when 0x2 then io.error.put_string ("MAPPING_EPILOG"); 				
				when 0x4 then io.error.put_string ("MAPPING_NO_INFO"); 				
				when 0x8 then io.error.put_string ("MAPPING_UNMAPPED_ADDRESS"); 				
				when 0x10 then io.error.put_string ("MAPPING_EXACT"); 				
				when 0x20 then io.error.put_string ("MAPPING_APPROXIMATE"); 						
				else io.error.put_string ("???")				
				end
				io.error.put_string ("%N")
			end
--	typedef enum CorDebugMappingResult
--	{
--		MAPPING_PROLOG              = 0x1,
--		MAPPING_EPILOG              = 0x2,
--		MAPPING_NO_INFO             = 0x4,
--		MAPPING_UNMAPPED_ADDRESS    = 0x8,
--		MAPPING_EXACT               = 0x10,
--		MAPPING_APPROXIMATE         = 0x20,
--	} CorDebugMappingResult;
		ensure
			success: last_call_success = 0
		end

	enumerate_local_variables: ICOR_DEBUG_VALUE_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_local_variables (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	get_local_variable (a_index: INTEGER): ICOR_DEBUG_VALUE is
		local
			l_p: POINTER
		do
			last_call_success := cpp_get_local_variable (item, a_index, $l_p)
			if l_p /= default_pointer then
				create Result.make_value_by_pointer (l_p)
			end
		ensure
			success: last_call_succeed
		end

	enumerate_arguments: ICOR_DEBUG_VALUE_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_arguments (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_succeed
		end

	get_argument (a_index: INTEGER): ICOR_DEBUG_VALUE is
		local
			l_p: POINTER
		do
			last_call_success := cpp_get_argument (item, a_index, $l_p)
			if l_p /= default_pointer then
				create Result.make_value_by_pointer (l_p)
			end
		end

	get_stack_depth: INTEGER is
		do
			last_call_success := cpp_get_stack_depth (item, $Result)
		end

feature {NONE} -- Implementation

	cpp_get_ip (obj: POINTER; a_p_offset: POINTER; a_p_mapping: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugILFrame signature(ULONG32*, CorDebugMappingResult*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetIP"
		end

	cpp_enumerate_local_variables (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugILFrame signature(ICorDebugValueEnum**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateLocalVariables"
		end

	cpp_get_local_variable (obj: POINTER; a_index: INTEGER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugILFrame signature(DWORD,ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetLocalVariable"
		end

	cpp_enumerate_arguments (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugILFrame signature(ICorDebugValueEnum**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateArguments"
		end

	cpp_get_argument (obj: POINTER; a_index: INTEGER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugILFrame signature(DWORD,ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetArgument"
		end

	cpp_get_stack_depth (obj: POINTER; a_depth: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugILFrame signature(ULONG32 *): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetStackDepth"
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ICOR_DEBUG_IL_FRAME

