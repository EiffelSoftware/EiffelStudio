indexing
	description: "This class is a heir of EV_WIDGET_IMP, EV_ITEM_IMP%
				% and EV_MESSAGE_DIALOG_IMP"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_EVENT_HANDLER_IMP

feature {NONE} -- Initialization

	initialize_list is
			-- Create the `command_list' and the `arguments_list'.
		deferred
		end

feature {NONE} -- Access

	command_list: ARRAY [EV_COMMAND]
			-- The list of the commands asociated with the widget
			-- The command are sort by event_id. For this ids,
			-- See the class EV_EVENT_CONSTANTS

	argument_list: ARRAY [EV_ARGUMENTS]
			-- The list of the arguments asociated with the commands
			-- The arguments follow the same order than the commands.

feature {NONE} -- status setting

	add_command (event_id: INTEGER; a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command to a widget that means create an ev_wel_command
			-- and put it to the wel_window of the widget.
			-- For the meaning of the message, see wel_wm_message.
			-- The argument can be `Void', in this case, there is 
			-- no argument passed to the command.
		require
			command_not_void: a_command /= Void
		local
			com: EV_COMMAND
		do
			if command_list = Void then
				initialize_list
			end
			if a_command.event_data /= Void then
				com := deep_clone (a_command)
			else	
				com := a_command
			end
			command_list.force (com, event_id)
			argument_list.force (arguments, event_id)
		end

	remove_command (command_id: INTEGER) is
			-- Remove the command associated with
			-- 'command_id' from the list of actions for
			-- this context. If there is no command
			-- associated with 'command_id', nothing
			-- happens.
		do	
			check
				not_yet_implemented: False
			end
		end

feature {NONE} -- Basic operation

	execute_command (event_id: INTEGER; data: EV_EVENT_DATA) is
			-- Execute the command that correspond to the event `event_id'.
		do
			if command_list /= Void and command_list @ event_id /= Void then
				(command_list @ event_id).set_event_data (data)
				(command_list @ event_id).execute (argument_list @ event_id)
			end
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
