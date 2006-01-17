indexing
	description: "[
		ICorDebugArrayValue
		]"
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

	get_element_type: INTEGER is
			-- GetElementType returns the simple type of the elements 
			-- in the array
		do
			last_call_success := cpp_get_element_type (item, $Result)
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_rank: INTEGER is
			-- GetRank returns the number of dimensions in the array.
		do
			last_call_success := cpp_get_rank (item, $Result)
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_count: INTEGER is
			-- GetCount returns the number of elements in all dimensions of
     		-- the array.
		do
			last_call_success := cpp_get_count (item, $Result)
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_dimensions (a_indicies_count: INTEGER): ARRAY [INTEGER] is
			-- GetDimensions returns the dimensions of the array.
		require
			a_indicies_count > 0
		local
			mp_tab: MANAGED_POINTER
			l_integer_size: INTEGER
			i: INTEGER
			l_element: INTEGER
		do
			l_integer_size := (create {PLATFORM}).Integer_bytes
			create mp_tab.make (a_indicies_count * l_integer_size)

			last_call_success := cpp_get_dimensions (item, a_indicies_count, mp_tab.item)
			from
				i := 1
				create Result.make (1, a_indicies_count)
			until
				i > a_indicies_count
			loop
				l_element := mp_tab.read_integer_32 ((i - 1) * l_integer_size)
				Result.put (l_element, i)
				i := i + 1
			end
		end

	has_base_indicies: BOOLEAN is
			-- HasBaseIndicies returns whether or not the array has base indicies.
     		-- If the answer is no, then all dimensions have a base index of 0.
		local
			l_result: INTEGER
		do
			last_call_success := cpp_has_base_indicies (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0			
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_base_indicies (a_indicies_count: INTEGER): ARRAY [INTEGER] is
			-- GetBaseIndicies returns the base index of each dimension in 
	 		-- the array
		require
			a_indicies_count > 0
		local
			mp_tab: MANAGED_POINTER
			l_integer_size: INTEGER
			i: INTEGER
			l_element: INTEGER
		do
			l_integer_size := (create {PLATFORM}).Integer_bytes
			create mp_tab.make (a_indicies_count * l_integer_size)

			last_call_success := cpp_get_base_indicies (item, a_indicies_count, mp_tab.item)
			from
				i := 1
				create Result.make (1, a_indicies_count)
			until
				i > a_indicies_count
			loop
				l_element := mp_tab.read_integer_32 ((i - 1) * l_integer_size)
				Result.put (l_element, i)
				i := i + 1
			end
		end

	get_element (a_indexes: ARRAY [INTEGER]): ICOR_DEBUG_VALUE is
			-- GetElement returns a value representing the given element in the array.
		local
			l_p: POINTER
			l_mp_indexes: MANAGED_POINTER
			l_integer_size: INTEGER
			i: INTEGER
		do
			--| create table of 'a_ranges.count' struct COR_DEBUG_STEP_RANGE |--
			
			l_integer_size := (create {PLATFORM}).Integer_bytes
			create l_mp_indexes.make (a_indexes.count * l_integer_size)
			from
				i := a_indexes.lower
			until
				i > a_indexes.upper
			loop
				l_mp_indexes.put_integer_32 (a_indexes @ i, i * l_integer_size)
				i := i + 1
			end		
			last_call_success := cpp_get_element (item, a_indexes.count, l_mp_indexes.item, $l_p)
			if l_p /= default_pointer then
				create Result.make_value_by_pointer (l_p)
			end
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_element_at_position (a_position: INTEGER): ICOR_DEBUG_VALUE is
			-- GetElementAtPosition returns a value representing the given
			-- element at the given position in the array. The position is
			-- over all dimensions of the array.
		local
			l_p: POINTER
		do
			last_call_success := cpp_get_element_at_position (item, a_position, $l_p)
			if l_p /= default_pointer then
				create Result.make_value_by_pointer (l_p)
			end
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

feature {NONE} -- Implementation

	cpp_get_element_type (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugArrayValue signature(CorElementType*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetElementType"
		end

	cpp_get_rank (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetRank"
		end

	cpp_get_count (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCount"
		end

	cpp_get_dimensions (obj: POINTER; a_cdim: INTEGER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32,ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetDimensions"
		end

	cpp_has_base_indicies (obj: POINTER; a_has_base_indicies: POINTER): INTEGER is
			-- Call `ICorDebugArrayValue->HasBaseIndicies'.
		external
			"[
				C++ ICorDebugArrayValue signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"HasBaseIndicies"
		end

	cpp_get_base_indicies (obj: POINTER; a_cdim: INTEGER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32,ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetBaseIndicies"
		end

	cpp_get_element (obj: POINTER; a_indexes_count: INTEGER; a_indexes: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32, ULONG32*, ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetElement"
		end

	cpp_get_element_at_position (obj: POINTER; a_pos: INTEGER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugArrayValue signature(ULONG32, ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetElementAtPosition"
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

end -- class ICOR_DEBUG_ARRAY_VALUE

