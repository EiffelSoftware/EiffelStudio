indexing
	description: "Encapsulation of DISPPARAMS structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_DISP_PARAMS

inherit
	ECOM_STRUCTURE

creation
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	rgvarg: ECOM_VARIANT is
			-- No description available.
		do
			Result := ccom_dispparams_rgvarg (item)
		end

	rgdispid_named_args: INTEGER_REF is
			-- No description available.
		do
			Result := ccom_dispparams_rgdispid_named_args (item)
		ensure
			non_void_rgdispid_named_args: Result /= Void
		end

	c_args: INTEGER is
			-- No description available.
		do
			Result := ccom_dispparams_c_args (item)
		end

	c_named_args: INTEGER is
			-- No description available.
		do
			Result := ccom_dispparams_c_named_args (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of DISPPARAMS structure
		do
			Result := c_size_of_disp_params
		end

feature -- Basic Operations

	set_rgvarg (a_rgvarg: ECOM_VARIANT) is
			-- Set `rgvarg' with `a_rgvarg'.
		require
			non_void_a_rgvarg: a_rgvarg /= Void
			valid_a_rgvarg: a_rgvarg.item /= default_pointer
		do
			ccom_dispparams_set_rgvarg (item, a_rgvarg.item)
		end

	set_rgdispid_named_args (a_rgdispid_named_args: INTEGER_REF) is
			-- Set `rgdispid_named_args' with `a_rgdispid_named_args'.
		require
			non_void_a_rgdispid_named_args: a_rgdispid_named_args /= Void
		do
			ccom_dispparams_set_rgdispid_named_args (item, a_rgdispid_named_args)
		end

	set_c_args (a_c_args: INTEGER) is
			-- Set `c_args' with `a_c_args'.
		do
			ccom_dispparams_set_c_args (item, a_c_args)
		end

	set_c_named_args (a_c_named_args: INTEGER) is
			-- Set `c_named_args' with `a_c_named_args'.
		do
			ccom_dispparams_set_c_named_args (item, a_c_named_args)
		end
		
feature {NONE} -- Externals

	c_size_of_disp_params: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_DISPPARAMS.h%"]"
		alias
			"sizeof(DISPPARAMS)"
		end

	ccom_dispparams_rgvarg (a_pointer: POINTER): ECOM_VARIANT is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *):EIF_REFERENCE"
		end

	ccom_dispparams_set_rgvarg (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *, VARIANT *)"
		end

	ccom_dispparams_rgdispid_named_args (a_pointer: POINTER): INTEGER_REF is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *):EIF_REFERENCE"
		end

	ccom_dispparams_set_rgdispid_named_args (a_pointer: POINTER; arg2: INTEGER_REF) is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *, EIF_OBJECT)"
		end

	ccom_dispparams_c_args (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *):EIF_INTEGER"
		end

	ccom_dispparams_set_c_args (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *, UINT)"
		end

	ccom_dispparams_c_named_args (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *):EIF_INTEGER"
		end

	ccom_dispparams_set_c_named_args (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_DISPPARAMS.h%"](DISPPARAMS *, UINT)"
		end

end -- class ECOM_DISP_PARAMS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

