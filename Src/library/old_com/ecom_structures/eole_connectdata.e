indexing

	description: "CONNECTDATA structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_CONNECTDATA

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end

feature -- Element change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_connect_data_allocate
		end

	set_p_unk (punk: EOLE_UNKNOWN) is
			-- Set 'pUnk' member of corresponding
			-- C++ structure to `punk'
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_eole_unknown: punk /= Void and then punk.ole_interface_ptr /= default_pointer
		do
			ole2_connect_data_set_p_unk (ole_ptr, punk.ole_interface_ptr)
		end


	set_cookie (cook: INTEGER) is
			-- Set 'dwCookie' member of corresponding
			-- C++ structure to `cook'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_connect_data_set_cookie (ole_ptr, cookie)
		ensure
			cookie_set: cookie = cook
		end

feature -- Access

	p_unk: EOLE_UNKNOWN is
				-- IUnknown interface on connected advisory sink
		require
			valid_c_structure: ole_ptr /= default_pointer
		local
			punk: POINTER
		do
			punk := ole2_connect_data_get_p_unk (ole_ptr)
			if punk /= default_pointer then
				!! Result.make
				Result.attach_ole_interface_ptr (punk)
			end
		end
		
	cookie: INTEGER is
			-- Connection where this value is same token that is returned 
			-- originally from calls to `EOLE_CONNECTION_POINT.advise'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_connect_data_get_cookie (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_connect_data_allocate: POINTER is
		external
			"C"
		alias
			"eole2_connect_data_allocate"
		end

	ole2_connect_data_set_p_unk (this: POINTER; punk: POINTER) is
		external
			"C"
		alias
			"eole2_connect_data_set_p_unk"
		end

	ole2_connect_data_get_p_unk (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_connect_data_get_p_unk"
		end

	ole2_connect_data_set_cookie (this: POINTER; cook: INTEGER) is
		external
			"C"
		alias
			"eole2_connect_data_set_cookie"
		end

	ole2_connect_data_get_cookie (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_connect_data_get_cookie"
		end
	
end -- class EOLE_CONNECTDATA

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

