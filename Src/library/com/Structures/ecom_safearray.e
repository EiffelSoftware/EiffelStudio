indexing
	description: "COM SAFEARRAY"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_SAFEARRAY [G -> ECOM_SAFEARRAY_ELEMENT create make end]

inherit
	ECOM_WRAPPER
		redefine
			make_from_pointer
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

creation
	make_from_pointer,
	make_by_dimensions,
	make_from_array,
	make_from_table

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Create from pointer to SAFEARRAY structure
		do
			Precursor (a_pointer)
			from_com := True
		ensure then
			from_com: from_com
		end

	make_by_dimensions (some_bounds: ARRAY[ECOM_SAFE_ARRAY_BOUND]) is
			-- Create new SAFEARRAY structure 
			-- 
		require
			valid_bounds: some_bounds /= Void
		local 
			ptr_array: ARRAY[POINTER]
			i, j: INTEGER
			tmp: G
			any: ANY
		do
			from
				i := some_bounds.lower
				create ptr_array.make (some_bounds.lower, some_bounds.upper)
			until
				i > some_bounds.upper
			loop
				ptr_array.put (some_bounds.item (i).item, i)
				i := i + 1
			end

			create tmp.make
			any := ptr_array.to_c
			initializer := ccom_create_by_dimensions (tmp.type, some_bounds.count, $any)
			item := ccom_item (initializer)
		end

	make_from_array (elements: ARRAY[G]) is
			-- Create SAFEARRAY from ARRAY
		require
			valid_elements: elements /= Void
		local
			l_bound, count: INTEGER
			i: INTEGER
		do
			l_bound := elements.lower
			initializer := ccom_create_array (elements.item (l_bound).type, l_bound, count)
			item := ccom_item (initializer)

			from
				i := l_bound
			variant 
				count - i + l_bound
			until
				i > elements.upper
			loop
				ccom_put_element (initializer, $i, elements.item (i).item)
				i := i + 1
			end
		ensure
			one_dimentional: dimension_count = 1
		end

	make_from_table (elements: ARRAY2[G]) is
			-- Create SAFEARRAY from ARRAY2
		require
			valid_elements: elements /= Void
		local
			sa_bound: ECOM_SAFE_ARRAY_BOUND
			sa_bound_array: ARRAY [ECOM_SAFE_ARRAY_BOUND]
			i, j: INTEGER
			indeces: ARRAY [INTEGER]
			any: ANY
		do
			create sa_bound_array.make (0,1)
			create sa_bound.make
			sa_bound.set_lower_bound (1)
			sa_bound.set_count (elements.height)
			sa_bound_array.put (sa_bound, 0)
			create sa_bound.make
			sa_bound.set_lower_bound (1)
			sa_bound.set_count (elements.width)
			sa_bound_array.put (sa_bound, 1)
			make_by_dimensions (sa_bound_array)

			from
				i := 1
			until
				i > elements.height
			loop
				from
					j := 1
				until
					j > elements.width
				loop
					create indeces.make (1, 2)
					indeces.put (j, 1)
					indeces.put (i, 2)
					any := indeces.to_c
					ccom_put_element (initializer, $any, elements.item (i, j).item)
					j := j + 1	
				end
				i := i + 1
			end
		ensure
			two_dimentional: dimension_count = 2
		end

feature -- Access

	element (indeces: ARRAY [INTEGER]): G is
			-- Element of SAFEARRAY
		require
			valid_indeces: are_indeces_valid (indeces)
		local
			any: ANY
			i, j: INTEGER
			reverse_indeces: ARRAY [INTEGER]
		do
			create reverse_indeces. make (1, dimension_count)
			from
				i := 1
				j := dimension_count
			until
				i > dimension_count
			loop
				reverse_indeces.put (indeces.item (i), j)
				i := i + 1
				j := j - 1
			end
			any := reverse_indeces.to_c
			create Result.make
			ccom_element (initializer, $any, Result.item)
		end

feature -- Measurement

	dimension_count: INTEGER is
			-- Number of dimensions in SAFEARRAY
		do
			Result := ccom_dim_count (initializer)
		end

	lower_bound (a_dimension: INTEGER): INTEGER is
			-- Minimum index in `a_dimension' dimension
		require
			valid_dimension: a_dimension >= 1 and a_dimension <= dimension_count
		do
			Result := ccom_lower_bound (initializer, a_dimension)
		end

	upper_bound (a_dimension: INTEGER): INTEGER is
			-- Maximum index in `a_dimension' dimension
		require
			valid_dimension: a_dimension >= 1 and a_dimension <= dimension_count
		do
			Result := ccom_upper_bound (initializer, a_dimension)
		end

feature -- Status report

	from_com: BOOLEAN
			-- Did SAFEARRAY structure come from COM?

	is_valid_type (a_type: INTEGER): BOOLEAN is
			-- Is `a_type' valid SAFEARRAY type?
		do
			Result := a_type = Vt_i2 or
					a_type = Vt_i4 or
					a_type = Vt_r4 or
					a_type = Vt_r8 or
					a_type = Vt_cy or
					a_type = Vt_date or
					a_type = Vt_bstr or
					a_type = Vt_dispatch or
					a_type = Vt_error or
					a_type = Vt_bool or
					a_type = Vt_variant or
					a_type = Vt_unknown or
					a_type = Vt_decimal or
					a_type = Vt_ui1
		end

	are_indeces_valid (indeces: ARRAY [INTEGER]): BOOLEAN is
			-- Are indeces valid?
		local 
			i: INTEGER
		do
			Result := indeces /= Void and then 
						indeces.count = dimension_count and then
						indeces.lower = 1 
			if Result then
				from
					i := 1
				until
					i > dimension_count
				loop
					if not (indeces.item (i) >= lower_bound (i) and indeces.item (i) <= upper_bound (i)) 
					then
						Result := False
					end
					i := i + 1
				end
			end
		end

feature -- Element change

	put_element (indeces: ARRAY [INTEGER]; an_element: G) is
			-- Put element into SAFEARRAY
		require
			valid_indeces: are_indeces_valid (indeces)
		local
			any: ANY
			i, j: INTEGER
			reverse_indeces: ARRAY [INTEGER]
		do
			create reverse_indeces. make (1, dimension_count)
			from
				i := 1
				j := dimension_count
			until
				i > dimension_count
			loop
				reverse_indeces.put (indeces.item (i), j)
				i := i + 1
				j := j - 1
			end
			any := reverse_indeces.to_c
			ccom_put_element (initializer, $any, an_element.item)
		end

feature -- Conversion

	array: ARRAY [G] is
			-- Array of elements
		require
			one_dimentional: dimension_count = 1
		local
			i: INTEGER
			indeces: ARRAY[INTEGER]
		do
			create Result.make (lower_bound (1), upper_bound (1))
			create indeces.make (1, 1)
			from
				i := lower_bound (1)
			until
				i > upper_bound (1)
			loop
				indeces.put (i, 1)
				Result.put (element (indeces), i)
				i := i + 1
			end
		ensure
			valid_result: Result /= Void and then 
					Result.count = upper_bound (1) - lower_bound (1) + 1
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_by_pointer (a_pointer)
		end

	delete_wrapper is
		do
			if from_com then
				ccom_destroy_struct (initializer)
			end
			ccom_delete_wrapper (initializer)
		end

feature {NONE} -- Externals

	ccom_create_by_pointer (a_pointer: POINTER): POINTER is
		external
			"C++ [new E_safe_array %"E_safe_array.h%"] (EIF_POINTER)"
		end

	ccom_create_by_dimensions (a_var_type, dim_count: INTEGER; some_bounds: POINTER): POINTER is
		external
			"C++ [new E_safe_array %"E_safe_array.h%"] (EIF_INTEGER, EIF_INTEGER, EIF_POINTER)"
		end

	ccom_create_array (var_type: INTEGER; l_bound: INTEGER; el_count: INTEGER): POINTER is
		external
			"C++ [new E_safe_array %"E_safe_array.h%"] (EIF_INTEGER, EIF_INTEGER, EIF_INTEGER)"
		end

	ccom_delete_wrapper (cpp_obj: POINTER) is
		external
			"C++ [delete E_safe_array %"E_safe_array.h%"]()"
		end

	ccom_destroy_struct (cpp_obj: POINTER) is
		external
			"C++ [E_safe_array %"E_safe_array.h%"]()"
		end

	ccom_put_element (cpp_obj: POINTER; indeces: POINTER; an_element: POINTER) is
		external
			"C++ [E_safe_array %"E_safe_array.h%"](EIF_INTEGER *, EIF_POINTER)"
		end

	ccom_dim_count (cpp_obj: POINTER): INTEGER is
		external
			"C++ [E_safe_array %"E_safe_array.h%"](): EIF_INTEGER"
		end

	ccom_lower_bound (cpp_obj: POINTER; dim: INTEGER): INTEGER is
		external
			"C++ [E_safe_array %"E_safe_array.h%"](EIF_INTEGER): EIF_INTEGER"
		end

	ccom_upper_bound (cpp_obj: POINTER; dim: INTEGER): INTEGER is
		external
			"C++ [E_safe_array %"E_safe_array.h%"](EIF_INTEGER): EIF_INTEGER"
		end

	ccom_element (cpp_obj: POINTER; indeces: POINTER; an_element: POINTER) is
		external
			"C++ [E_safe_array %"E_safe_array.h%"](EIF_INTEGER*, EIF_POINTER)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_safe_array %"E_safe_array.h%"](): (SAFEARRAY *)"
		end

invariant
	non_void_initializer: initializer /= Default_pointer 
	non_void_item: item /= Default_pointer

end -- class ECOM_SAFEARRAY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

