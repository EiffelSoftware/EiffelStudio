note
	description: "[
		ICorDebugStringValue
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_STRING_VALUE

inherit
	ICOR_DEBUG_HEAP_VALUE

create
	make_by_pointer,
	make_value_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_length: NATURAL_32
			-- GetLength
		do
			last_call_success := cpp_get_length (item, $Result)
		end

	get_string (a_len: NATURAL_32): detachable STRING_32
			-- GetString
		local
			p_nbfetched: NATURAL_32
			mp_name: MANAGED_POINTER
			ws: WEL_STRING
		do
			create mp_name.make ((1 + a_len.as_integer_32) * sizeof_WCHAR)

			last_call_success := cpp_get_string (item, a_len, $p_nbfetched, mp_name.item)
			if mp_name.item /= default_pointer then
				create ws.make_by_pointer (mp_name.item)
				Result := ws.string -- ubstring (1, a_len.min (p_nbfetched.to_integer_32))
			end
		end

feature {NONE} -- Implementation

	cpp_get_length (obj: POINTER; a_result: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugStringValue signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetLength"
		end

	cpp_get_string (obj: POINTER; a_cchstring: NATURAL_32; a_pcchstring: TYPED_POINTER [NATURAL_32]; a_pstring: POINTER): INTEGER
		external
			"[
				C++ ICorDebugStringValue signature(ULONG32, ULONG32*, WCHAR*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetString"
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

end -- class ICOR_DEBUG_STRING_VALUE

