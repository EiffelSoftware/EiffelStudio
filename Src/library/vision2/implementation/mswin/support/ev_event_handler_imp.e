indexing
	description: "This class is a heir of EV_WIDGET_IMP, EV_ITEM_IMP%
				% and EV_MESSAGE_DIALOG_IMP"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_EVENT_HANDLER_IMP

feature {NONE} -- Initialization

	initialize_list (count: INTEGER) is
			-- Create the `command_list' and the `arguments_list' with a length
			-- of count.
		do
			!! command_list.make (1, count)
			!! argument_list.make (1, count)
		end

feature {NONE} -- Access

	command_list: ARRAY [LINKED_LIST [EV_COMMAND]]
			-- The list of the commands asociated with the widget
			-- The command are sort by event_id. For this ids,
			-- See the class EV_EVENT_CONSTANTS

	argument_list: ARRAY [LINKED_LIST [EV_ARGUMENT]]
			-- The list of the arguments asociated with the commands
			-- The arguments follow the same order than the commands.

feature {NONE} -- status setting

	add_command (event_id: INTEGER; a_command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Add a command to a widget that means create an ev_wel_command
			-- and put it to the wel_window of the widget.
			-- For the meaning of the message, see wel_wm_message.
			-- The argument can be `Void', in this case, there is 
			-- no argument passed to the command.
		require
			valid_command: a_command /= Void
			valid_id: event_id >= 1 and event_id <= command_list.count
			valid_lists: command_list /= Void and argument_list /= Void
		local
			list_com: LINKED_LIST [EV_COMMAND]
			list_arg: LINKED_LIST [EV_ARGUMENT]
		do
			if (command_list @ event_id) = Void then
				!! list_com.make
				!! list_arg.make
				command_list.force (list_com, event_id)
				argument_list.force (list_arg, event_id)
			end
			(command_list @ event_id).extend (a_command)
			(argument_list @ event_id).extend (arguments)
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
			-- Return `True' if the default processing is disabled,
			-- False otherwise
		require
			valid_commands: command_list /= Void
			valid_arguments: argument_list /= Void
			valid_id: event_id >= 1 and event_id <= command_list.count
		local
			com_list: LINKED_LIST [EV_COMMAND]
			arg_list: LINKED_LIST [EV_ARGUMENT]
		do
			if (command_list @ event_id) /= Void then
				com_list := (command_list @ event_id)
				arg_list := (argument_list @ event_id)
				from
					com_list.start
					arg_list.start
				until
					com_list.after
				loop
					com_list.item.execute (arg_list.item, data)
					com_list.forth
					arg_list.forth
				end
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
