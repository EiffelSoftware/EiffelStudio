indexing
	description:
		"EiffelVision cursor, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_IMP

inherit
	EV_CURSOR_I

	WEL_CURSOR

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_code,
	make_by_pixmap

feature {NONE} -- Initialization

	make is
			-- Create a cursor with the default appearance.
		local
			code: EV_CURSOR_CODE
		do
			create code.make
			make_by_predefined_id (code.standard)
		end

	make_by_code (code: INTEGER) is
			-- Create a cursor with the appearance corresponding
			-- to `value'. See class EV_CURSOR_CODE fo the code.
		do
			make_by_predefined_id (code)
		end

	make_by_pixmap (pix: EV_PIXMAP) is
			-- Create a cursor with `pix' as appearance
-- 		require
-- 			valid_width: pix.width <= 32
-- 			valid_height: pix.height <= 32
		local
			pix_imp: EV_PIXMAP_IMP
			list, mask: ARRAY [CHARACTER]
			i: INTEGER
			c: CHARACTER
		do
			pix_imp ?= pix.implementation
			list := pix_imp.character_representation
			c := '%/255/'
-- 			from
-- 				i := 1
-- 			until
-- 				i = list.count
-- 			loop
-- 				list.put (c, i)
-- 				i := i + 1
-- 			end

			create mask.make (1, list.count)
			from
				i := 1
			until
				i = mask.count
			loop
				mask.put ('%U', i)
				i := i + 1
			end
			-- Mask first, then pixmap
			make_by_bitmask (0, 0, list, mask)
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not exists
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			destroy_item
		end

feature {NONE} -- Implementation

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
