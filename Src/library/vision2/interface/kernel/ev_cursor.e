indexing
	description:
		"EiffelVision cursor.Small picture whose location on the%
		% screen is controlled by a pointing device."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR

inherit
	EV_ANY
		redefine
			implementation
		end

creation
	make,
	make_by_code
--	make_by_pixmap

feature {NONE} -- Initialization

	make is
			-- Create a cursor with the default appearance.
		do
			create {EV_CURSOR_IMP} implementation.make
			implementation.set_interface (current)
		end

	make_by_code (code: INTEGER) is
			-- Create a cursor with the appearance corresponding
			-- to `value'. See class EV_CURSOR_CODE fo the code.
		do
			create {EV_CURSOR_IMP} implementation.make_by_code (code)
			implementation.set_interface (current)
		end

--	make_by_pixmap (pix: EV_PIXMAP) is
--			-- Create a cursor with `pix' as appearance
--		do
--			create {EV_CURSOR_IMP} implementation.make_by_pixmap (pix)
--			implementation.set_interface (current)
--		end

feature -- Implementation

	implementation: EV_CURSOR_I
		-- Platform dependent access

end -- class EV_CURSOR

--|----------------------------------------------------------------
--| EiffelVision Library: Example for the ISE EiffelVision library.
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
