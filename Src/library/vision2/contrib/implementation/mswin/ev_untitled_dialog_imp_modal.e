indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP_MODAL

inherit
	EV_DIALOG_IMP_MODAL
		undefine
			extra_minimum_height,
			promote_to_dialog_window,
			update_style
		redefine
			interface,
			other_imp
		end

	EV_UNTITLED_DIALOG_IMP_COMMON
		undefine
			hide
		redefine
			interface,
			other_imp
		end

create
	make_with_dialog_window

feature {EV_DIALOG_I} -- Implementation

	other_imp: EV_UNTITLED_DIALOG_IMP
			-- Previous Implementation if any, Void otherwise.

	interface: EV_UNTITLED_DIALOG
			-- Interface for `Current'.

end -- class EV_DIALOG_IMP_MODAL

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
