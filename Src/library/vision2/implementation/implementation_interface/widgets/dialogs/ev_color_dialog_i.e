--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision color selection dialog, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLOR_DIALOG_I

inherit
	EV_SELECTION_DIALOG_I

feature -- Access

	color: EV_COLOR is
			-- Current selected color
		require
		deferred
		end

feature -- Element change

	select_color (a_color: EV_COLOR) is
			-- Select `a_color'.
		require
			valid_color: is_valid (color)
		deferred
		end

feature -- Event - command association

	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Help" button is pressed.
		require
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_help_commands is
			-- Empty the list of commands to be executed when
			-- "Help" button is pressed.
		require
		deferred
		end

end -- class EV_COLOR_DIALOG_I

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.2  2000/01/27 19:29:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:08  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.3  1999/11/04 23:10:39  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
