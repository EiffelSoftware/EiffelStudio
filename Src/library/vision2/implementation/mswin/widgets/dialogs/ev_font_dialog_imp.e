indexing 
	description: "EiffelVision font selection dialog, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_SELECTION_DIALOG_IMP

inherit
	EV_FONT_SELECTION_DIALOG_I

	EV_STANDARD_DIALOG_IMP

	WEL_CHOOSE_FONT_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		end

creation
	make

<<<<<<< ev_font_selection_dialog_imp.e
feature {NONE} -- Implementation

	dispatch_events is
		do
		end

=======
feature {NONE} -- Implementation

	dispatch_events is
		do
			check
				not_yet_implemented: False
			end
		end

>>>>>>> 1.2
end -- class EV_FONT_SELECTION_DIALOG_IMP

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
