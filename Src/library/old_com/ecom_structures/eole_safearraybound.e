indexing

	description: "SAFEARRAYBOUND structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_SAFEARRAY_BOUNDS
	
inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
feature -- Element change

	allocate: POINTER is
			-- Create associated C++ structure.
		do
			Result := ole2_safearraybound_allocate
		end

	set_element_count (count: INTEGER) is
			-- Set `element_count' with `count'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_safearraybound_set_element_count (ole_ptr, count)
		ensure
			element_count_set: element_count = count
		end
		
	set_lower_bound (bnd: INTEGER) is
			-- Set `lower_bound' with `bnd'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_safearraybound_set_lower_bound (ole_ptr, bnd)
		ensure
			lower_bound_set: lower_bound = bnd
		end
		
feature -- Access

	element_count: INTEGER is
			-- Number of elements in dimension
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_safearraybound_element_count (ole_ptr)
		end

	lower_bound: INTEGER is
			-- Lower bound of dimension
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_safearraybound_lower_bound (ole_ptr)
		end
				
feature -- Externals

	ole2_safearraybound_allocate: POINTER is
		external
			"C"
		alias
			"eole2_safearraybound_allocate"
		end
		
	ole2_safearraybound_set_element_count (ptr: POINTER; count: INTEGER) is
		external
			"C"
		alias
			"eole2_safearraybound_set_element_count"
		end
		
	ole2_safearraybound_set_lower_bound (ptr: POINTER; bnd: INTEGER) is
		external
			"C"
		alias
			"eole2_safearraybound_set_lower_bound"
		end
		
	ole2_safearraybound_element_count (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_safearraybound_element_count"
		end
		
	ole2_safearraybound_lower_bound (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_safearraybound_lower_bound"
		end
		
end -- class EOLE_SAFEARRAYBOUND

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


