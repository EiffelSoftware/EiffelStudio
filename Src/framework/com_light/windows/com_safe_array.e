note
	description: "[
		This C structure holds a safe array and its attributes for basic types. Currently it is limited to the following
		basic types: INTEGER_xx, NATURAL_xx and POINTER.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_SAFE_ARRAY [G -> ANY]

create
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make (min_index, max_index: INTEGER)
			-- Initialize current with a default value `a_default_value' and bounds `min_index' .. `max_index'.
		require
			has_default: ({G}).has_default
			is_expanded: ({G}).is_expanded
		local
			l_ppv_data: POINTER
			l_result: INTEGER
		do
			lower := min_index
			upper := max_index
			compute_vt_type
			if vt_type /= {COM_EXTERNALS}.vt_unknown then
				safe_array_item := c_safe_array_create_vector (vt_type, min_index, count.as_natural_32)
				if safe_array_item /= default_pointer then
					l_result := c_safe_array_access_data (safe_array_item, $l_ppv_data)
					if l_result = {COM_EXTERNALS}.s_ok and then l_ppv_data /= default_pointer then
						l_ppv_data.memory_set (0, count * element_size)
						l_result := c_safe_array_unaccess_data (safe_array_item)
					else
							-- An error occurred, we simply free the newly allocated array.
						l_result := c_safe_array_destroy (safe_array_item)
						check l_result = {COM_EXTERNALS}.s_ok end
						safe_array_item := default_pointer
					end
				end
			end
		end

	make_from_pointer (a_ptr: POINTER)
			-- Initialize current using the SAFEARRAY structure pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			has_default: ({G}).has_default
			is_expanded: ({G}).is_expanded
		local
			l_lower, l_upper: INTEGER
		do
			compute_vt_type
			if c_safe_array_bounds (a_ptr, $l_lower, $l_upper) = {COM_EXTERNALS}.s_ok then
				safe_array_item := a_ptr
				lower := l_lower
				upper := l_upper
			end
		end

feature -- Access

	to_array: ARRAY [G]
		require
			is_valid_array: is_valid_array
		local
			i, nb: INTEGEr
		do
			from
				i := lower
				nb := upper
				create Result.make_filled (({G}).default, i, nb)
			until
				i > nb
			loop
				Result.put (item (i), i)
				i := i + 1
			end
		end

	to_managed_pointer: MANAGED_POINTER
			-- Convert current to a MANAGED_POINTER
		require
			is_valid_array: is_valid_array
		local
			l_result: INTEGER_32
			l_ppv_data: POINTER
		do
			l_result := c_safe_array_access_data (safe_array_item, $l_ppv_data)
			if l_result = {COM_EXTERNALS}.s_ok and then l_ppv_data /= default_pointer then
				create Result.make_from_pointer (l_ppv_data, count * element_size)
				l_result := c_safe_array_unaccess_data (safe_array_item)
				check l_result = {COM_EXTERNALS}.s_ok end
			else
				create Result.make (0)
			end
		end

	safe_array_item: POINTER
			-- Safe array pointer

feature -- Status report

	lower, upper: INTEGER
			-- Lower and upper indexes of `Current'.

	count: INTEGER
			-- Number of elements in `Current'.
		do
			Result := upper - lower + 1
		end

	is_valid_array: BOOLEAN
			-- Is current a valid array?
		do
			Result := safe_array_item /= default_pointer and then vt_type /= {COM_EXTERNALS}.vt_unknown
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index value for `Current'?
		do
			Result := (lower <= i) and then (i <= upper)
		end

feature -- Element change

	put (v: like item; i: INTEGER)
			-- Replace `i'-th entry, if in index interval, by `v'.
		require
			valid_index: valid_index (i)
			is_valid_array: is_valid_array
		local
			l_result: INTEGER_32
			l_ppv_data: POINTER
		do
			l_result := c_safe_array_access_data (safe_array_item, $l_ppv_data)
			if l_result = {COM_EXTERNALS}.s_ok and then l_ppv_data /= default_pointer then
				c_put (l_ppv_data, v, i).do_nothing
				l_result := c_safe_array_unaccess_data (safe_array_item)
				check l_result = {COM_EXTERNALS}.s_ok end
			end
		end

	item alias "[]", at alias "@" (i: INTEGER): G assign put
			-- Entry at index `i', if in index interval
		require
			valid_index: valid_index (i)
			is_valid_array: is_valid_array
		local
			l_result: INTEGER_32
			l_ppv_data: POINTER
		do
			l_result := c_safe_array_access_data (safe_array_item, $l_ppv_data)
			if l_result = {COM_EXTERNALS}.s_ok and then l_ppv_data /= default_pointer then
				Result := c_item (l_ppv_data, i)
				l_result := c_safe_array_unaccess_data (safe_array_item)
				check l_result = {COM_EXTERNALS}.s_ok end
			else
				Result := ({G}).default
			end
		end

feature {NONE} -- Implementation

	vt_type: NATURAL_16
			-- Underlying COM type of elements of `Current'.

	compute_vt_type
			-- Compute `vt_type'.
		do
			if {G} ~ {INTEGER_8} then
				vt_type := {COM_EXTERNALS}.vt_i1
			elseif {G} ~ {INTEGER_16} then
				vt_type := {COM_EXTERNALS}.vt_i2
			elseif {G} ~ {INTEGER_32} then
				vt_type := {COM_EXTERNALS}.vt_i4
			elseif {G} ~ {INTEGER_64} then
				vt_type := {COM_EXTERNALS}.vt_i8
			elseif {G} ~ {NATURAL_8} then
				vt_type := {COM_EXTERNALS}.vt_ui1
			elseif {G} ~ {NATURAL_16} then
				vt_type := {COM_EXTERNALS}.vt_ui2
			elseif {G} ~ {NATURAL_32} then
				vt_type := {COM_EXTERNALS}.vt_ui4
			elseif {G} ~ {NATURAL_64} then
				vt_type := {COM_EXTERNALS}.vt_ui8
			elseif {G} ~ {POINTER} then
				vt_type := {COM_EXTERNALS}.vt_ptr
			else
				vt_type := {COM_EXTERNALS}.vt_unknown
			end
		end

	element_size: INTEGER
			-- Size of elements of Current at the memory level.
		do
			compute_size_of_g ($Result).do_nothing
		end

feature {NONE} -- Externals

	compute_size_of_g (a_size: TYPED_POINTER [INTEGER]): G
			-- Return size of `G' in `a_size'.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
				*(EIF_INTEGER *) $a_size = sizeof($$_result_type);
				return ($$_result_type) 0;
			]"
		end

	c_safe_array_create_vector (a_var_type: NATURAL_16; a_lower_bound: INTEGER_64; a_elements: NATURAL_32): POINTER
			-- Creates a one-dimensional array. A safe array created with SafeArrayCreateVector is a fixed size, so the constant FADF_FIXEDSIZE is always set.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) SafeArrayCreateVector ((VARTYPE) $a_var_type, (long) $a_lower_bound, (unsigned int) $a_elements);"
		end

	c_safe_array_access_data (a_psa: POINTER; a_ppv_data: TYPED_POINTER [POINTER]): INTEGER_32
			-- Increments the lock count of an array, and retrieves a pointer to the array data.
		external
			"C inline use <windows.h>"
		alias
			"return SafeArrayAccessData ((SAFEARRAY *)$a_psa, (void HUGEP **)$a_ppv_data);"
		end

	c_safe_array_unaccess_data (a_psa: POINTER): INTEGER_32
			-- Decrements the lock count of an array, and invalidates the pointer retrieved by SafeArrayAccessData.
		external
			"C inline use <windows.h>"
		alias
			"return SafeArrayUnaccessData ((SAFEARRAY *)$a_psa);"
		end

	c_safe_array_destroy (a_psa: POINTER): INTEGER_32
			-- Decrements the lock count of an array, and invalidates the pointer retrieved by SafeArrayAccessData.
		external
			"C inline use <windows.h>"
		alias
			"return SafeArrayDestroy ((SAFEARRAY *)$a_psa);"
		end

	c_safe_array_bounds (a_psa: POINTER; a_lower, a_upper: TYPED_POINTER [INTEGER]): INTEGER_32
			-- Get the bounds of the array `a_psa'.
		external
			"C inline use <windows.h>"
		alias
			"[
				HRESULT hresult = SafeArrayGetLBound($a_psa, 1, $a_lower);
				hresult = SafeArrayGetUBound($a_psa, 1, $a_upper);
				return hresult;
			]"
		end

	c_item (a_array: POINTER; i: INTEGER): like item
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return *(($$_result_type *) $a_array + $i);"
		end

	c_put (a_array: POINTER; v: like item; i: INTEGER): like item
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return *(($$_result_type *) $a_array + $i) = $v;"
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
