indexing
	description: "EiffelVision dialog. Implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	
	EV_DIALOG_I

inherit

	EV_WINDOW_I

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create the dialog box.
		deferred
		end

feature -- Access

	display_area: EV_VERTICAL_BOX
				-- The display area on the top of the window

	action_area: EV_HORIZONTAL_BOX
				-- The action area on the bottom of the window

end -- class EV_DIALOG_I

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
