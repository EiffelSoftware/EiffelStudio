note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_ARRAY_VALUE

inherit
	ICOR_DEBUG_HEAP_VALUE

feature {ICOR_EXPORTER} -- Access

	get_element_type: INTEGER
			-- GetElementType returns the simple type of the elements
			-- in the array
		do
			set_last_call_success (cpp_get_element_type (item, $Result))
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_rank: NATURAL_32
			-- GetRank returns the number of dimensions in the array.
		do
			set_last_call_success (cpp_get_rank (item, $Result))
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
			set_last_call_success (cpp_get_count (item, $Result))
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

			set_last_call_success (cpp_get_dimensions (item, a_indicies_count.as_natural_32, mp_tab.item))
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
			set_last_call_success (cpp_has_base_indicies (item, $r))
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

			set_last_call_success (cpp_get_base_indicies (item, a_indicies_count.as_natural_32, mp_tab.item))
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
			set_last_call_success (cpp_get_element (item, a_indexes.count.as_natural_32, l_mp_indexes.item, $l_p))
			if l_p /= default_pointer then
				Result := new_value (l_p)
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
			set_last_call_success (cpp_get_element_at_position (item, a_position, $p))
			if p /= default_pointer then
				Result := new_value (p)
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


end
