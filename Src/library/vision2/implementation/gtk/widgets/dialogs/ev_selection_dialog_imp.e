--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision selection dialog. Implementation interface."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECTION_DIALOG_IMP

inherit
	EV_SELECTION_DIALOG_I

	EV_STANDARD_DIALOG_IMP
		redefine
			which_event_id
		end

feature -- Access

	ok_widget: POINTER is
			-- Pointer to the gtk_button `OK' of the dialog.
		deferred
		end

	cancel_widget: POINTER is
			-- Pointer to the gtk_button `Cancel' of the dialog.
		deferred
		end

feature {NONE} -- Basic operation

	add_dialog_close_command (p: POINTER) is
			-- Add a close command to the given pointer (gtk_button)
			-- on a `clicked' signal.
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EV_SELECTION_DIALOG_IMP]

			list_com: EV_GTK_COMMAND_LIST			
		do
			create cmd.make (~execute)
			create arg.make (Current)
			add_command (p, "clicked", cmd, arg, NULL)
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
		deferred
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Cancel" button is pressed.
		local
			cancel_close_command: EV_COMMAND
		do
--			-- We have to remove the close command and put it back
--			-- to have it executed after all commands.

--			-- Remove the close command.
--			(event_command_array @ cancel_clicked_id).finish
--			cancel_close_command := (event_command_array @ cancel_clicked_id).command_list.item
--			remove_single_command (cancel_widget, cancel_clicked_id, cancel_close_command)

			-- Add the command.
			add_command (cancel_widget, "clicked", cmd, arg, NULL)

--			-- re-add a new close command.
--			add_dialog_close_command (cancel_widget)
		end


feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		deferred
		end

	remove_cancel_commands is
			-- Empty the list of commands to be executed when
			-- "Cancel" button is pressed.
		do
			-- remove commands
			remove_commands (cancel_widget, cancel_clicked_id)

			-- re-add a new close command.
			add_dialog_close_command (cancel_widget)
		end

feature {NONE} -- Implementation - Event handling -

	which_event_id (wid: POINTER; ev_str: STRING; mouse_but: INTEGER; double_clic: BOOLEAN): INTEGER is
			-- Gives the event_id number corresponding to the `event' string.
			-- We need to redefine this feature to be able to store commands associated
			-- to "clicked" event for `ok' and `cancel' button in separate location
			-- in `event_command_array'.
		do
			Result := {EV_STANDARD_DIALOG_IMP} Precursor (NULL, ev_str, mouse_but, double_clic)
			if (ev_str.is_equal ("clicked")) then
				if (wid = ok_widget) then
					-- "clicked" event for `ok' button.
					Result := ok_clicked_id
				elseif (wid = cancel_widget) then
					-- "clicked" event for `cancel' button.
					Result := cancel_clicked_id
				end
			end
		end

end -- class EV_SELECTION_DIALOG_IMP

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/05/02 18:55:27  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.3  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.2  2000/01/27 19:29:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:29:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
