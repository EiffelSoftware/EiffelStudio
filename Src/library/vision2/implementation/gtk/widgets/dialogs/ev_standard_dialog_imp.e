indexing
	description:
		"EiffelVision standard dialog. Deferred class,%
		% ancestor of the standard dialogs.%
		% All the standard dialogs are modal. Therefore%
		% nothing can be done until the user close the%
		% window."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit

	EV_STANDARD_DIALOG_I

	EV_DIALOG_IMP
		rename
			make as old_make
		end

feature {EV_MESSAGE_DIALOG_IMP} -- Execute procedure

	execute (argument: EV_ARGUMENT1[EV_STANDARD_DIALOG_I]; data: EV_EVENT_DATA) is
			-- Command to close the dialog
		local
			dialog_imp: EV_STANDARD_DIALOG_IMP
		do
--			argument.first.interface.destroy
--				-- destroy the gtk object
			dialog_imp ?= argument.first
			dialog_imp.hide
				-- Hide the gtk object
				-- The user must no forget to destroy
				-- the dialog when no more needed.
		end

end -- class EV_STANDARD_DIALOG_IMP

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
