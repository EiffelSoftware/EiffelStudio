indexing
	description:
		" EiffelVision tool-bar toggle button. A two state%
		% button for the tool-bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		redefine
			implementation,
			make_with_text,
			make
		end

creation
	make,
	make_with_text,
	make_with_pixmap,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_TOOL_BAR) is
			-- Create the widget with `par' as parent.
		do
			!EV_TOOL_BAR_TOGGLE_BUTTON_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_TOOL_BAR; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_TOOL_BAR_TOGGLE_BUTTON_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the current button selected?
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.is_selected
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the current button if `flag', deselect it
			-- otherwise.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			implementation.set_selected (flag)
		end

feature -- Event : command association

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_unselect_command (cmd, arg)		
		end

feature -- Event -- removing command association

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		require
			exists: not destroyed
		do
			implementation.remove_unselect_commands	
		end

feature -- Implementation

	implementation: EV_TOOL_BAR_TOGGLE_BUTTON_I
			-- Platform dependent access.

end -- class EV_TOOL_BAR_TOGGLE_BUTTON

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
