indexing 
	description: "EiffelVision file save dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG

inherit
	EV_FILE_SELECTION_DIALOG
		redefine
			implementation
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create a window with a parent.
		do
			!EV_FILE_SAVE_DIALOG_IMP! implementation.make (par)
		end

feature -- Implementation

	implementation: EV_FILE_SAVE_DIALOG_I

end -- class EV_FILE_SAVE_DIALOG

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
