indexing
	description: "EiffelVision warning dialog. Mswindows implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_WARNING_DIALOG_IMP

inherit
	EV_WARNING_DIALOG_I

	EV_MESSAGE_DIALOG_IMP
		redefine
			make, make_default
		end
	
creation
	make, make_default

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a dialog, but do not displays it.
			-- This dialog has no buttons.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par)
			dialog_style := Mb_iconwarning
		end

	make_default (par: EV_CONTAINER; txt, title: STRING) is
			-- Create the default error dialog with `par' as
			-- parent, `title' as title and `txt' as message.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par, txt, title)
			dialog_style := Mb_iconwarning + Mb_ok
			display (txt, title)
		end

end -- class EV_WARNING_DIALOG_IMP

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
