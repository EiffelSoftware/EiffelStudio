indexing

	description: "SAFEARRAY structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_SAFEARRAY

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
	EOLE_VAR_TYPE

feature -- Element change

	set_dims (d: INTEGER) is
			-- Set number of dimensions at creation
			-- time to `d'
		do
			dims := d
		end

	set_type (t: INTEGER) is
			-- Set type of data at creation time with `t'
			-- See class EOLE_VARTYPE for `t' possible values
		do
			type := t
		end
	
	set_bounds (bnds: EOLE_SAFEARRAY_BOUNDS) is
			-- Set bounds at creation time with `bnds'
		do
			bounds := bnds
		end

	allocate: POINTER is
			-- Allocate C structure
			-- `set_dims', `set_type' and `set_bounds' must
			-- be called before.
		do
			Result := safearray_allocate
		end

	safearray_destroy is
			-- Destroy associated OLE structure.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_safearray_destroy (ole_ptr)
		end

	safearray_destroy_data is
			-- Destroy datas of associated OLE structure
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_safearray_destroy_data (ole_ptr)
		end
		
	put_element (index: ARRAY [INTEGER]; var: EOLE_VARIANT) is
			-- Set element at `index' with `var'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_variant: var /= Void and then var.ole_ptr /= default_pointer and 
							var.vartype /= Vt_array and
							var.vartype /= Vt_null and
							var.vartype /= Vt_empty and
							not var.is_reference
			valid_index: is_valid_index (index)
		do
			ole2_safearray_put_element (ole_ptr, index.to_c, var.ole_ptr)
		end

feature -- Access
		
	upper_bound (dim_number: INTEGER): INTEGER is
			-- Upper bound of dimension `dim_number'
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_dim_number: dim_number > 0 and dim_number < dim
		do
			Result := ole2_safearray_upper_bound (ole_ptr, dim_number)
		end
		
	lower_bound (dim_number: INTEGER): INTEGER is
			-- Lower bound of dimension `dim_number'
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_dim_number: dim_number > 0 and dim_number < dim
		do
			Result := ole2_safearray_lower_bound (ole_ptr, dim_number)
		end
		
	element (index: ARRAY [INTEGER]): EOLE_VARIANT is
			-- Element at `index'
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_index: is_valid_index (index)
		do
			!! Result 
			Result.attach (ole2_safearray_element (ole_ptr, index.to_c))
		end
		
	dim: INTEGER is
			-- Dimension of array
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_safearray_dim (ole_ptr)
		end

	element_size: INTEGER is
			-- Size of element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_safearray_element_size (ole_ptr)
		end

	is_valid_index (index: ARRAY [INTEGER]): BOOLEAN is
			-- Is `index' valid?
		local
			i: INTEGER
		do
			Result := index /= Void
			if Result then
				from
					Result := index.count = dim
					i := index.lower
				until
					not Result or i > index.upper
				loop
					Result := index.item (i) <= upper_bound (i)
						and index.item (i) >= lower_bound (i)
					i := i + 1
				end
			end
		end
		
		are_valid_bounds: BOOLEAN is
				-- Are `bounds' of each dimension valid?
			require
				valid_c_structure: ole_ptr /= default_pointer
			local
				i: INTEGER
			do
				from
					Result := True
					i := 1
				until
					not Result or i > dim
				loop
					Result := lower_bound (i) <= upper_bound (i)
				end
			end
			
feature {NONE} -- Implementation
	
	bounds: EOLE_SAFEARRAY_BOUNDS
		-- Bounds of safearray used for `allocate'

	dims: INTEGER
			-- Dimension of array at creation time

	type: INTEGER
			-- Type of data in array at creation time
			-- See class EOLE_VARTYPE for possible values

	safearray_allocate: POINTER is
			-- Create associated OLE structure with `dims' 
			-- dimensions and element type `type'.
			-- Bounds of each dimension are set with `bounds'.
			-- See EOLE_VARTYPE for `type' values.
		require
			valid_bounds: bounds /= Void and then bounds.ole_ptr /= default_pointer
		do
			Result := ole2_safearray_allocate (type, dims, bounds.ole_ptr)
		end

feature {NONE} -- Externals

	ole2_safearray_allocate (t: INTEGER; d: INTEGER; bnds:POINTER): POINTER is
		external
			"C"
		alias
			"eole2_safearray_allocate"
		end
		
	ole2_safearray_destroy (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_safearray_destroy"
		end
	
	ole2_safearray_destroy_data (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_safearray_destroy_data"
		end
		
	ole2_safearray_copy (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_safearray_copy"
		end

	ole2_safearray_put_element (ptr: POINTER; index: ANY; var:POINTER) is
		external
			"C"
		alias
			"eole2_safearray_put_element"
		end

	ole2_safearray_upper_bound (ptr: POINTER; dim_number: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_safearray_upper_bound"
		end

	ole2_safearray_lower_bound (ptr: POINTER; dim_number: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_safearray_lower_bound"
		end
		
	ole2_safearray_element (ptr: POINTER; index: ANY): POINTER is
		external
			"C"
		alias
			"eole2_safearray_element"
		end
		
	ole2_safearray_dim (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_safearray_dim"
		end
		
	ole2_safearray_element_size (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_safearray_element_size"
		end

invariant

	valid_bounds: ole_ptr /= default_pointer implies are_valid_bounds
	
end -- class EOLE_SAFEARRAY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

