indexing
	description: "List of default colors used by the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DEFAULT_COLORS

feature -- Access

	Color_dialog: EV_COLOR is
			-- Color usely used for the background of dialogs
		do
			Result := implementation.Color_dialog
		end

	Color_read_only: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are in read-only mode
		do
			Result := implementation.Color_read_only
		end

	Color_read_write: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are in read / write mode
		do
			Result := implementation.Color_read_write
		end

feature {NONE} -- Implementation

	implementation: EV_DEFAULT_COLORS_IMP is
		once
			!! Result
		end

end -- class EV_DEFAULT_COLORS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
