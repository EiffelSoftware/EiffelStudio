indexing

	description: "DISPPARAMS structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_DISPPARAMS

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			destroy,
			allocate
		end

feature -- Element change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_allocate_dispparams
		end

	reset is
			-- Clear associated C++ structure.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_reset_dispparams (ole_ptr)
		end

	destroy is
			-- Destroy associated C++ structure.
		do
			if (not is_attached) and then (ole_ptr /= default_pointer) then
				ole2_destroy_dispparams (ole_ptr)
				ole_ptr := default_pointer
			end
		end

	add_argument (arg: EOLE_VARIANT) is
			-- Add `arg' at next available position.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_add_dispparams_arg (ole_ptr, arg.ole_ptr)
		ensure
			incrementality: number_of_arguments = old number_of_arguments + 1
		end

	put_argument (pos: INTEGER; arg: EOLE_VARIANT) is
			-- Put `arg' at position `pos'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_put_dispparams_arg (ole_ptr, pos, arg.ole_ptr)
		end
		
	add_named_arg_dispid (dispid: INTEGER) is
			-- Add named argument `dispid' at next available position.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_add_dispparams_dispid (ole_ptr, dispid)
		ensure
			incrementality: number_of_named_arguments = old number_of_named_arguments + 1
		end

	put_named_arg_dispid (pos, dispid: INTEGER) is
			-- Put named argument `dispid' at position `pos'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_put_dispparams_dispid (ole_ptr, pos, dispid)
		end
		
feature -- Access

	number_of_arguments: INTEGER is
			-- Number of arguments
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_dispparams_args (ole_ptr)
		end

	argument (pos: INTEGER): EOLE_VARIANT is
			-- Argument at `pos'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_get_dispparams_arg (ole_ptr, pos))
		end

	number_of_named_arguments: INTEGER is
			-- Number of named arguments
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_dispparams_dispids_number (ole_ptr)
		end
		
	named_arg_dispid (pos: INTEGER): INTEGER is
			-- Named argument at `pos'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_dispparams_dispid (ole_ptr, pos)
		end

feature {NONE} -- Externals

	ole2_allocate_dispparams: POINTER is
		external
			"C"
		alias
			"eole2_allocate_dispparams"
		end

	ole2_destroy_dispparams (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_destroy_dispparams"
		end

	ole2_reset_dispparams (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_reset_dispparams"
		end

	ole2_add_dispparams_arg (ptr, var: POINTER) is
		external
			"C"
		alias
			"eole2_add_dispparams_arg"
		end

	ole2_get_dispparams_arg (ptr: POINTER; num: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_get_dispparams_arg"
		end

	ole2_put_dispparams_arg (ptr: POINTER; num: INTEGER; var: POINTER) is
		external
			"C"
		alias
			"eole2_put_dispparams_arg"
		end

	ole2_get_dispparams_args (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_dispparams_args"
		end

	ole2_add_dispparams_dispid (ptr: POINTER; dispid: INTEGER) is
		external
			"C"
		alias
			"eole2_add_dispparams_dispid"
		end

	ole2_get_dispparams_dispid (ptr: POINTER; pos: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_get_dispparams_dispid"
		end

	ole2_put_dispparams_dispid (ptr: POINTER; pos, dispid: INTEGER) is
		external
			"C"
		alias
			"eole2_put_dispparams_dispid"
		end

	ole2_get_dispparams_dispids_number (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_dispparams_dispids_number"
		end
	
end -- class EOLE_DISPPARAMS

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

