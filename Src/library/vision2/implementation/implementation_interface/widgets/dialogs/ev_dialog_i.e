indexing
	description: "EiffelVision dialog. Implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	
	EV_DIALOG_I

inherit

	EV_WINDOW_IMP
		export
			{EV_DIALOG} make 
		redefine
			build
		end

creation

	make

feature {EV_DIALOG} -- Initialization

	build is
			-- Put the component inside the dialog
		local
			dbox: EV_VERTICAL_BOX
			container_interface: EV_CONTAINER
		do
			container_interface ?= interface
			check
				container_not_void: container_interface /= Void
			end
			{EV_WINDOW_IMP} Precursor

			!! dbox.make (container_interface)
			dbox.set_homogeneous (False)
			dbox.set_border_width (12)
			dbox.set_spacing (4)

			!! display_area.make (dbox)
			display_area.set_spacing (3)
			display_area.set_minimum_height (100)
			display_area.set_minimum_width (250)

			!! action_area.make (dbox)
			--action_area.set_border_width (3)
			action_area.set_spacing (4)
			action_area.set_expand (False)
			action_area.set_minimum_height (30)
			action_area.set_minimum_width (250)
		end

feature -- Access

	display_area: EV_VERTICAL_BOX
				-- The display area on the top of the window

	action_area: EV_HORIZONTAL_BOX
				-- The action area on the bottom of the window

feature {NONE} -- Implementation

	seperator: EV_SEPARATOR

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
