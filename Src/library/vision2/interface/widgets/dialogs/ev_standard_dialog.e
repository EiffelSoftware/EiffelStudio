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
	EV_STANDARD_DIALOG

inherit
	EV_ANY
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a message dialog with `par' as parent.
		require
			valid_parent: is_valid (par)
		deferred
		end

feature -- Status setting

	show is
			-- Show the window.
			-- As the window is modal, nothing can be done
			-- until the user closed the window.
		require
			exists: not destroyed
		do
			implementation.show
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the dialog.
		require
			exists: not destroyed
			valid_parent: is_valid (par)
		do
			implementation.set_parent (par)
		end

feature -- Implementation

	implementation: EV_STANDARD_DIALOG_I

end -- class EV_STANDARD_DIALOG

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
