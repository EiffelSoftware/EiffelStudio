indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	
PRIMITIVE_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end


creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			l1: EV_LABEL
		do
			{ANY_TAB} Precursor (par)
				-- Creates the objects and their commands
			create l1.make_with_text(Current,"EV_PRIMITIVE is a deferred class and therefore,%N there are no features that can be modified.")
			set_child_position (l1, 0, 0, 1, 1)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Primitive"
		end

	current_widget: EV_PRIMITIVE
			-- Current widget we are working on.

end -- class BOX_TAB


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

