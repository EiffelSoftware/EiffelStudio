indexing

	description: "EOLE_PICTURE.select_picture result structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_SELECT_PICTURE
	
inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
feature -- Element change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_select_picture_allocate
		end
		
	set_hdc_out (hout: INTEGER) is
			-- Set `hdcOut' with `hout'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_select_picture_set_hdc_out (ole_ptr, hout)
		ensure
			hdc_out_set: hdc_out = hout
		end

	set_hbmp_out (hbp_out: INTEGER) is
			-- Set `hbmpOut' with `bmp_out'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_select_picture_set_hbmp_out (ole_ptr, hbp_out)
		ensure
			hbmp_out_set: hbmp_out = hbp_out
		end

feature -- Access

	hdc_out: INTEGER is
			-- Previous device context
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_select_picture_hdc_out (ole_ptr)
		end

	hbmp_out: INTEGER is
			-- GDI handle of picture
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_select_picture_hbmp_out (ole_ptr)
		end

feature {NONE} -- Externals

	ole2_select_picture_allocate: POINTER is
		external
			"C"
		alias
			"eole2_select_picture_allocate"
		end
		
	ole2_select_picture_set_hdc_out (ptr: POINTER; hout: INTEGER) is
		external
			"C"
		alias
			"eole2_select_picture_set_hdc_out"
		end

	ole2_select_picture_set_hbmp_out (ptr: POINTER; bmp_out: INTEGER) is
		external
			"C"
		alias
			"eole2_select_picture_set_hbmp_out"
		end

	ole2_select_picture_hdc_out (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_select_picture_hdc_out"
		end

	ole2_select_picture_hbmp_out (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_select_picture_hbmp_out"
		end
	
end -- class EOLE_SELECT_PICTURE

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
