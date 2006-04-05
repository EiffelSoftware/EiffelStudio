indexing
	description: "[
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_CODE

inherit
	ICOR_OBJECT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	is_il: BOOLEAN is
			-- IsIL returns whether the code is IL (as opposed to native)
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_il (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
--		ensure
--			success: last_call_success = 0
		end

	get_function: ICOR_DEBUG_FUNCTION is
		local
			p: POINTER
		do
			last_call_success := cpp_get_function (item, $p)
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_function (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_address: INTEGER_64 is
			-- GetAddress returns the address of the code
		do
			last_call_success := cpp_get_address (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_size: INTEGER is
			-- GetSize returns the size in bytes of the code
		do
			last_call_success := cpp_get_size (item, $Result)
		ensure
			success: last_call_success = 0
		end

	create_breakpoint (a_offset: INTEGER_64): ICOR_DEBUG_FUNCTION_BREAKPOINT is
		local
			p: POINTER
		do
			last_call_success := cpp_create_breakpoint (item, a_offset, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
--		ensure
--			success: last_call_success = 0
		end


	get_code (a_size: INTEGER): STRING is
			-- Returns the code of the method suitable for disassembly.
			-- Note that instruction boundaries aren't checked
		local
			l_codesize: INTEGER
			p_buffersize: INTEGER
			mp_code: MANAGED_POINTER
			i, nb: INTEGER
--			l_opcode_dico: EIFNET_OPCODE_CONSTANTS
			l_platform: PLATFORM
		do

			l_codesize := a_size

			create mp_code.make (l_codesize)

			last_call_success := cpp_get_code (item, 
					0, l_codesize, l_codesize, -- [IN]
					mp_code.item, $p_buffersize  -- [OUT]
				)
--			Result := (create {UNI_STRING}.make_by_pointer (mp_code.item)).string
			from
				i := 1
				nb := p_buffersize
				create Result.make (l_codesize)
				create l_platform
			until
				i > nb
			loop
				Result.append ("0x")
				Result.append (mp_code.read_integer_8 ((i - 1) * l_platform.Integer_8_bytes).to_hex_string)
				i := i + 1
			end
		ensure
			success: last_call_success = 0
		end

	get_version_number: INTEGER is
			-- Returns version number of code
		do
			last_call_success := cpp_get_version_number (item, $Result)
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_is_il (obj: POINTER; a_p_is_il: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugCode signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsIL"
		end

	cpp_get_function (obj: POINTER; a_p_function: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugCode signature(ICorDebugFunction**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetFunction"
		end

	cpp_get_address (obj: POINTER; a_p_start: TYPED_POINTER [INTEGER_64]): INTEGER is
		external
			"[
				C++ ICorDebugCode signature(CORDB_ADDRESS*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetAddress"
		end

	cpp_get_size (obj: POINTER; a_p_size: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugCode signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetSize"
		end
		
	cpp_create_breakpoint (obj: POINTER; a_offset: INTEGER_64; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugCode signature(ULONG32, ICorDebugFunctionBreakpoint**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CreateBreakpoint"
		end
		
	cpp_get_code (obj: POINTER; a_startoffset, a_endoffset: INTEGER; a_bufferalloc: INTEGER;
					a_buffer: POINTER; a_buffersize: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugCode signature(ULONG32, ULONG32, ULONG32, BYTE*, ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCode"
		end		

	cpp_get_version_number (obj: POINTER; a_p_vers_number: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugCode signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetVersionNumber"
		end

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

end -- class ICOR_DEBUG_CODE

