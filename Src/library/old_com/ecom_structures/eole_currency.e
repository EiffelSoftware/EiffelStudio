indexing

	description: "CURRENCY structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_CURRENCY

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
		
feature -- Element change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_currency_allocate
		end

	set_lo (l: INTEGER) is
			-- Set 'Lo' member of
			-- corresponding C++ structure.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_currency_set_lo (ole_ptr, l)
		ensure
			lo_set: lo = l
		end

	set_hi (h: INTEGER) is
			-- Set 'Hi' member of
			-- corresponding C++ structure.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_currency_set_hi (ole_ptr, h)
		ensure
			hi_set: hi = h
		end

feature -- Access

	lo: INTEGER is
			-- Value of 'Lo' member of
			-- corresponding C++ structure
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_currency_get_lo (ole_ptr)
		end

	hi: INTEGER is
			-- Value of 'Hi' member of
			-- corresponding C++ structure
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_currency_get_hi (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_currency_allocate: POINTER is
		external
			"C"
		alias
			"eole2_currency_allocate"
		end

	ole2_currency_set_lo (this: POINTER; l: INTEGER) is
		external
			"C"
		alias
			"eole2_currency_set_Lo"
		end

	ole2_currency_set_hi (this: POINTER; h: INTEGER) is
		external
			"C"
		alias
			"eole2_currency_set_Hi"
		end

	ole2_currency_get_lo (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_currency_get_Lo"
		end

	ole2_currency_get_hi (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_currency_get_Hi"
		end
	
end -- class EOLE_CURRENCY

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


