indexing
	description: "EiffelVision dialog. Mswindows interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	
	EV_DIALOG_IMP

inherit

	EV_DIALOG_I
		rename
			expandable as never_displayed
		end

	EV_WINDOW_IMP
		redefine
			plateform_build
		end

creation
	make

feature -- Initialization

	plateform_build (par: EV_CONTAINER_IMP) is
			-- Put the component inside the dialog
		local
			vbox: EV_VERTICAL_BOX
			container_interface: EV_CONTAINER
		do
			container_interface ?= interface
			check
				container_not_void: container_interface /= Void
		end
			{EV_WINDOW_IMP} Precursor (par)

			!! vbox.make (container_interface)
			vbox.set_homogeneous (False)
			vbox.set_spacing (10)

			!! display_area.make (vbox)
			display_area.set_minimum_height (100)
			display_area.set_minimum_width (100)

			!! action_area.make (vbox)
			action_area.set_expand (False)
			action_area.set_minimum_height (20)
			action_area.set_minimum_width (100)

			show
		end

end -- class EV_DIALOG_IMP

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
