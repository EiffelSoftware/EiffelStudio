indexing
	description: "EiffelVision dialog. A dialog is a window with%
				% predefine containers and widgets : a vertical%
				% box inside and a panel of button in the%
				% action-area (horizontal_box)."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG

inherit
	EV_WINDOW
		redefine 
			make,
			implementation
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create the dialog box.
		do
			!EV_DIALOG_IMP!implementation.make (par)
			implementation.set_interface (Current)
			implementation.plateform_build (par.implementation)
			implementation.build
		end

feature -- Access

	display_area: EV_VERTICAL_BOX is
				-- The display area on the top of the window
		do
			Result := implementation.display_area
		end

	action_area: EV_HORIZONTAL_BOX is
				-- The action area on the bottom of the window
		do
			Result := implementation.action_area
		end

feature {NONE} -- Implementation

	implementation: EV_DIALOG_I
			-- Implementation of the dialog

end -- class EV_DIALOG

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
