--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" This class gives the attributes and the features needed to handle%
		% the event on the widgets, items, dialogs..."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_EVENT_HANDLER_IMP

feature {NONE} -- Initialization

	initialize_list is
			-- Create the `command_list' and the `arguments_list' with a length
			-- of command_count.
		do
		end

feature {NONE} -- Status report

	has_command (event_id: INTEGER): BOOLEAN is
			-- Does the object has at least one command on the 
			-- event given by `event_id'.
		do
		end

feature {EV_PND_SOURCE_IMP} -- Element change

	add_command (event_id: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' and `arg' to the list corresonding to `event_id'
			-- in the table of commands and arguments of the widget.
			-- If the tables don't exist, it creates them.
		require
			valid_command: cmd /= Void
			valid_id: event_id >= 1 and event_id <= command_count
		do
		end

	remove_single_command (event_id: INTEGER; cmd: EV_COMMAND) is
			-- Remove `cmd' from the list of commmands associated
			-- with the event `event_id'.
		require
			valid_command: cmd /= Void
			valid_id: event_id >= 1 and event_id <= command_count
		do
		end

	remove_command (event_id: INTEGER) is
			-- Remove all the commands associated with
			-- the event `event_id'. If the array of command
			-- is then empty, we set it to Void.
		require
			valid_id: event_id >= 1 and event_id <= command_count
		do
		end

feature -- Deferred features

	command_count: INTEGER is
			-- Length of the array to store the commands and the arguments.
		deferred
		end

end -- class EV_EVENT_HANDLER_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.10.3  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.10.2  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.16.10.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
