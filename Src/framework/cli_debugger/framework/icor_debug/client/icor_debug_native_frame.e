note
	description: "[ 
		interface ICorDebugNativeFrame : ICorDebugFrame
			GetIP
			SetIP
			GetRegisterSet
			GetLocalRegisterValue
			GetLocalDoubleRegisterValue
			GetLocalMemoryValue
			GetLocalRegisterMemoryValue
			GetLocalMemoryRegisterValue
			CanSetIP
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_NATIVE_FRAME

inherit
	ICOR_DEBUG_FRAME

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_ip: NATURAL_32
			-- get OffSet
		do
			last_call_success := cpp_get_ip (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_register_set: ICOR_DEBUG_REGISTER_SET
			-- get OffSet
		local
			l_p: POINTER
		do
			last_call_success := cpp_get_register_set (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_ip (obj: POINTER; a_p_offset: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugNativeFrame signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetIP"
		end

	cpp_get_register_set (obj: POINTER; a_p_register: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugNativeFrame signature(ICorDebugRegisterSet**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetRegisterSet"
		end

note
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

end -- class ICOR_DEBUG_NATIVE_FRAME

