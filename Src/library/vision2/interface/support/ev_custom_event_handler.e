indexing
	description:
		"EiffelVision custom event handler. Keeps track%
		%of associated commands and dispaches to%
		%the subscribed commands if a corresponding event%
		%occurs";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CUSTOM_EVENT_HANDLER [G -> HASHABLE]
creation
	make
feature {NONE} -- Initialisation

	make (n: INTEGER) is
			-- Create the event handler with an estimate
			-- of `n' event entries.
		do
			create event_table.make (n)
		end

feature -- Access

	has_command (event_key: G): BOOLEAN is
			-- Does the object has at least one command on the 
			-- event given by `event_key'.
		do
			Result := event_table.has (event_key)
		end

	
feature -- Element Change

	add_command (event_key: G; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add a command that will be executed everytime the
			-- event associated with `event_key' will be triggered.
		require
			cmd_not_void: cmd /= Void
		local
			list: DYNAMIC_LIST [EV_INTERNAL_COMMAND]
			internal_command: EV_INTERNAL_COMMAND
		do
			if
				event_table.has (event_key)
			then
				list := event_table.item(event_key)
			else
				create {LINKED_LIST [EV_INTERNAL_COMMAND]} list.make
				event_table.put (list, event_key)
			end
		
			create internal_command.make (cmd, arg)
			list.extend (internal_command)
		ensure
			has_command: has_command (event_key)
		end

feature -- Removal

	remove_all_commands (event_key: G) is
			-- Remove all the commands associated with
			-- the event `event_key'. 
		do
			event_table.remove (event_key)
		end

feature -- Basic operation

	execute_command (event_key: G; data: EV_EVENT_DATA) is
			-- Execute the command that correspond to the event
			-- `event_key'.
		local
			list: DYNAMIC_LIST [EV_INTERNAL_COMMAND]
			i: INTEGER
		do
					print ("executing ")
					print (event_key.out)
					print ("%N")
			if
				has_command (event_key)		
			then
				list := event_table.item (event_key)

				check
					list_not_void: list /= Void
				end
				
				from
					list.start
				until
					list.off
				loop
					list.item.execute (data)
					list.forth
				end
			end
						
		end
	
feature {NONE} -- Implementation

	event_table: HASH_TABLE [DYNAMIC_LIST [EV_INTERNAL_COMMAND], G]
	

end -- class EV_CUSTOM_EVENT_HANDLER

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
