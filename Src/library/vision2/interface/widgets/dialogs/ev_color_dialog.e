indexing 
	description: "EiffelVision color selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_DIALOG

inherit
	EV_SELECTION_DIALOG
		redefine
			implementation
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			!EV_COLOR_DIALOG_IMP! implementation.make (par)
			implementation.set_interface (Current)
		end

feature -- Access

	color: EV_COLOR is
			-- Current selected color
		require
			exists: not destroyed
		do
			Result := implementation.color
		end

feature -- Element change

	select_color (a_color: EV_COLOR) is
			-- Select `a_color'.
		require
			exists: not destroyed
		do
			implementation.select_color (a_color)
		end

feature -- Event - command association

	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Help" button is pressed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_help_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_help_commands is
			-- Empty the list of commands to be executed when
			-- "Help" button is pressed.
		require
			exists: not destroyed
		do
			implementation.remove_help_commands
		end

feature -- Implementation

	implementation: EV_COLOR_DIALOG_I

end -- class EV_COLOR_DIALOG

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------
