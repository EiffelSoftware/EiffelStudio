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
			!! command_list.make (1, command_count)
		end

feature {NONE} -- Access

	command_list: ARRAY [LINKED_LIST [EV_INTERNAL_COMMAND]]
			-- The list of the commands asociated with the widget
			-- The command are sort by event_id. For this ids,
			-- See the class EV_EVENT_CONSTANTS

feature {NONE} -- Status report

	has_command (event_id: INTEGER): BOOLEAN is
			-- Does the object has at least one command on the 
			-- event given by `event_id'.
		do
			if command_list = Void then
				Result := False
			else
				Result := (command_list @ event_id) /= Void
			end
		end

feature {NONE} -- Element change

	add_command (event_id: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' and `arg' to the list corresonding to `event_id'
			-- in the table of commands and arguments of the widget.
			-- If the tables don't exist, it creates them.
		require
			valid_command: cmd /= Void
			valid_id: event_id >= 1 and event_id <= command_count
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			com: EV_INTERNAL_COMMAND
		do
			-- First, we create the lists if they don't exists.
			if command_list = Void then
				initialize_list
			end

			-- Then, we create the list linked to the given
			-- `event_id' if it doesn't exists already. 
			if (command_list @ event_id) = Void then
				!! list.make
				command_list.force (list, event_id)
			end

			-- Finally, we add the command and the argument
			-- to the list.
			!! com.make (cmd, arg)
			(command_list @ event_id).extend (com)
		end

	remove_command (event_id: INTEGER) is
			-- Remove all the commands associated with
			-- the event `event_id'. If the array of command
			-- is then empty, we set it to Void.
		require
			valid_id: event_id >= 1 and event_id <= command_count
		do
			if command_list /= Void then
				if (command_list @ event_id) /= Void then
					command_list.force (Void, event_id)
				end
				if command_list.all_cleared then
					command_list := Void
				end
			end
		end

	remove_single_command (event_id: INTEGER; cmd: EV_COMMAND) is
			-- Remove `cmd' from the list of commmands associated
			-- with the event `event_id'.
		require
			valid_command: cmd /= Void
			valid_id: event_id >= 1 and event_id <= command_count
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
		do
			if command_list /= Void and then 
					(command_list @ event_id) /= Void then
				list := command_list @ event_id
				from
					list.start
					if list.item.command = cmd then
						list.remove
					end
				until
					list.after
				loop
					list.forth
					if list.item.command = cmd then
						list.remove
					end
				end
			end
		end

feature {EV_ANY_I} -- Basic operation

	execute_command (event_id: INTEGER; data: EV_EVENT_DATA) is
			-- Execute the command that correspond to the event
			-- `event_id'.
		require
			valid_id: event_id >= 1 and event_id <= command_count
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			i: INTEGER
		do
			if command_list /= Void and then (command_list @ event_id) /= Void then
				list := (command_list @ event_id)
				from
					i := 1
				until
					i > list.count
				loop
					(list @ i).execute (data)
					i := i + 1
				end
			end
		end

feature {EV_ANY_I} -- Deferred features

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
