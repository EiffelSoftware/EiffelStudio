indexing
	description:
		" This class gives the attributes and the features needed to handle%
		% the accelerator_list on the widgets, items, dialogs..."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ACCELERATOR_HANDLER_IMP

feature {NONE} -- Initialization

	initialize_accel_list is
			-- Initialize the list of accelerator_list added to
			-- the window.
		do
			create accelerator_list.make (1)
		end

feature {NONE} -- Access

	accelerator_list: HASH_TABLE [LINKED_LIST [EV_INTERNAL_COMMAND], INTEGER]
			-- Hash-table that keep the commands according to the
			-- accelerator they are linked with. The accelerators
			-- are represented by an integer.

feature {EV_APPLICATION_IMP} -- Access

	accelerator_table: EV_ACCELERATOR_TABLE_IMP is
			-- Table that memories and passes the accelerators to the
			-- system. In this table, all the accelerators are unique.
		once
			!! Result
		end

feature {NONE} -- Status report

	has_accel_command (id: INTEGER): BOOLEAN is
			-- Does the object has at least one command on the
			-- acceleraor given by `id'.
		do
			if accelerator_list = Void then
				Result := False
			else
				Result := accelerator_list.item (id) /= Void
			end
		end

feature {NONE} -- Element change

	add_accel_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `acc' to the list of accelerator_list.
		require
			valid_command: cmd /= Void
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			com: EV_INTERNAL_COMMAND
			id: INTEGER
		do
			-- First, we create the lists if they don't exists.
			if accelerator_list = Void then
				initialize_accel_list
			end

			-- Then, we create the list linked to the given
			-- accelerator if it doesn't exists already.
			id := acc.id
			if accelerator_list.has (id) then
				list := accelerator_list.item (id)
			else
				!! list.make
				accelerator_list.extend (list, id)
			end
			!! com.make (cmd, arg)
			list.extend (com)
			accelerator_table.add (acc)	
		end

	remove_accel_commands (acc: EV_ACCELERATOR) is
			-- Remove an accelerator from the table.
		local
			id: INTEGER
		do
			if accelerator_list /= Void then
				id := acc.id
				accelerator_list.remove (id)
				accelerator_table.remove (acc)
			end
		end

feature {EV_ACCELERATOR_HANDLER_IMP} -- Basic operation

	execute_accel_command (id: INTEGER; data: EV_EVENT_DATA) is
			-- Execute the command that correspond to the accelerator
			-- represented by id.
			-- If there are no command, it calls the execution of the
			-- parent.
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			i: INTEGER
		do
			if accelerator_list /= Void and then accelerator_list.has (id) then
				list := (accelerator_list @ id)
				from
					i := 1
				until
					i > list.count
				loop
					(list @ i).execute (data)
					i := i + 1
				end
			elseif parent_imp /= Void then
				parent_imp.execute_accel_command (id, data)
			else
				application.item.execute_accel_command (id, data)
			end
		end

feature {NONE} -- WEL Implementation

	on_accelerator_command (id: INTEGER) is
			-- The `acelerator_id' has been activated.
		do
			focus_on_widget.item.execute_accel_command (id, Void)
		end

feature {NONE} -- Deferred feature

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of the current widget.
		deferred
		end

	application: CELL [EV_APPLICATION_IMP] is
			-- The current application. Needed for the
			-- accelerators.
		deferred
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that currently have the focus.
		deferred
		end

end -- class EV_ACCELERATOR_HANDLER_IMP

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
