indexing
	description:
		"EiffelVision cursor.Small picture whose location on the%
		% screen is controlled by a pointing device."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_IMP

inherit
	EV_CURSOR_I

creation
	make,
	make_by_code,
	make_by_pixmap

feature {NONE} -- Initialization

	make is
			-- Create a cursor with the default appearance.
		do
			check
				not_yet_implemented: False
			end
		end

	make_by_code (code: INTEGER) is
			-- Create a cursor with the appearance corresponding
			-- to `value'. See class EV_CURSOR_CODE fo the code.
		do
			check
				not_yet_implemented: False
			end
		end

	make_by_pixmap (pix: EV_PIXMAP) is
			-- Create a cursor with `pix' as appearance
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			check
				not_yet_implemented: False
			end
		end

end -- class EV_CURSOR_IMP

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
