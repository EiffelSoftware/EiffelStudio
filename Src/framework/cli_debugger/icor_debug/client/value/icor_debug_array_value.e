﻿note
	description: "ICorDebugArrayValue"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_ARRAY_VALUE

inherit
	ICOR_DEBUG_HEAP_VALUE

create
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_element_type: INTEGER
			-- GetElementType returns the simple type of the elements
			-- in the array
		do
			last_call_success := cpp_get_element_type (item, $Result)
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_rank: NATURAL_32
			-- GetRank returns the number of dimensions in the array.
		do
			last_call_success := cpp_get_rank (item, $Result)
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_count_as_integer_32: INTEGER
			-- Truncated from NATURAL_32
		do
			Result := get_count.as_integer_32
		end

	get_count: NATURAL_32
			-- GetCount returns the number of elements in all dimensions of
			-- the array.
		do
			last_call_success := cpp_get_count (item, $Result)
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_dimensions (a_indicies_count: INTEGER): ARRAY [NATURAL_32]
			-- GetDimensions returns the dimensions of the array.
			-- FIXME jfiat [2008/11/07] : a_indicies_count could be NATURAL_32
		require
			a_indicies_count > 0
		local
			mp_tab: MANAGED_POINTER
			l_elt_size: INTEGER
			i: INTEGER
		do
			l_elt_size := {PLATFORM}.Natural_32_bytes
			create mp_tab.make (a_indicies_count * l_elt_size)

			last_call_success := cpp_get_dimensions (item, a_indicies_count.as_natural_32, mp_tab.item)
			from
				i := 1
				create Result.make_filled (0, 1, a_indicies_count)
			until
				i > a_indicies_count
			loop
				Result.put (mp_tab.read_natural_32 ((i - 1) * l_elt_size), i)
				i := i + 1
			end
		end

	has_base_indicies: BOOLEAN
			-- HasBaseIndicies returns whether or not the array has base indicies.
			-- If the answer is no, then all dimensions have a base index of 0.
		local
			r: INTEGER
		do
			last_call_success := cpp_has_base_indicies (item, $r)
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_base_indicies (a_indicies_count: INTEGER): ARRAY [NATURAL_32]
			-- GetBaseIndicies returns the base index of each dimension in
			-- the array
			-- FIXME jfiat [2008/11/07] : a_indicies_count could be NATURAL_32
		require
			a_indicies_count > 0
		local
			mp_tab: MANAGED_POINTER
			l_elt_size: INTEGER
			i: INTEGER
		do
			l_elt_size := {PLATFORM}.Natural_32_bytes
			create mp_tab.make (a_indicies_count * l_elt_size)

			last_call_success := cpp_get_base_indicies (item, a_indicies_count.as_natural_32, mp_tab.item)
			from
				i := 1
				create Result.make_filled (0, 1, a_indicies_count)
			until
				i > a_indicies_count
			loop
				Result.put (mp_tab.read_natural_32 ((i - 1) * l_elt_size), i)
				i := i + 1
			end
		end

	get_element (a_indexes: ARRAY [NATURAL_32]): ICOR_DEBUG_VALUE
			-- GetElement returns a value representing the given element in the array.
		local
			l_p: POINTER
			l_mp_indexes: MANAGED_POINTER
			l_elt_size: INTEGER
			i: INTEGER
		do
				--| create table of 'a_ranges.count' struct COR_DEBUG_STEP_RANGE |--

			l_elt_size := {PLATFORM}.Natural_32_bytes
			create l_mp_indexes.make (a_indexes.count * l_elt_size)
			from
				i := a_indexes.lower
			until
				i > a_indexes.upper
			loop
				l_mp_indexes.put_natural_32 (a_indexes [i], i * l_elt_size)
				i := i + 1
			end
			last_call_success := cpp_get_element (item, a_indexes.count.as_natural_32, l_mp_indexes.item, $l_p)
			if l_p /= default_pointer then
				create Result.make_value_by_pointer (l_p)
			end
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_element_at_integer_position (a_pos: INTEGER): like get_element_at_position
			-- Call `get_element_at_position' with integer argument position
		do
			Result := get_element_at_position (a_pos.as_natural_32)
		end

	get_element_at_position (a_position: NATURAL_32): ICOR_DEBUG_VALUE
			-- GetElementAtPosition returns a value representing the given
			-- element at the given position in the array. The position is
			-- over all dimensions of the array.
		local
			p: POINTER
		do
			last_call_success := cpp_get_element_at_position (item, a_position, $p)
			if p /= default_pointer then
				create Result.make_value_by_pointer (p)
			end
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

feature {NONE} -- Implementation

	cpp_get_element_type (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugArrayValue signature(CorElementType*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetElementType"
		end

	cpp_get_rank (obj: POINTER; a_result: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetRank"
		end

	cpp_get_count (obj: POINTER; a_result: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCount"
		end

	cpp_get_dimensions (obj: POINTER; a_cdim: NATURAL_32; a_p: POINTER): INTEGER
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32,ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetDimensions"
		end

	cpp_has_base_indicies (obj: POINTER; a_has_base_indicies: TYPED_POINTER [INTEGER]): INTEGER
			-- Call `ICorDebugArrayValue->HasBaseIndicies'.
		external
			"[
				C++ ICorDebugArrayValue signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"HasBaseIndicies"
		end

	cpp_get_base_indicies (obj: POINTER; a_cdim: NATURAL_32; a_p: POINTER): INTEGER
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32,ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetBaseIndicies"
		end

	cpp_get_element (obj: POINTER; a_indexes_count: NATURAL_32; a_indexes: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32, ULONG32*, ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetElement"
		end

	cpp_get_element_at_position (obj: POINTER; a_pos: NATURAL_32; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32, ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetElementAtPosition"
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
