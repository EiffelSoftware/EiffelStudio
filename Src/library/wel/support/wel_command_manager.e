indexing
	description: "Command manager which is able to retrieve the command %
		%associated to a Windows message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMAND_MANAGER

inherit
	HASH_TABLE [WEL_COMMAND_EXEC, INTEGER]
		rename
			make as hash_table_make,
			force as hash_table_force,
			remove as hash_table_remove
		end

creation
	make

feature -- Initialization

	make is
			-- Make a command manager.
		do
			hash_table_make (Table_size)
		end

feature -- Basic routines

	force (command: WEL_COMMAND_EXEC; message: INTEGER) is
			-- Put `command' associated to `message'.
		require
			command_not_void: command /= Void
			positive_message: message >= 0
		do
			hash_table_force (command, message)
		ensure
			exists: exists (message)
		end

	remove (message: INTEGER) is
			-- Remove the command associated to `message'.
		require
			positive_message: message >= 0
		do
			hash_table_remove (message)
		ensure
			not_exists: not exists (message)
		end

feature -- Status report

	exists (message: INTEGER): BOOLEAN is
			-- Does a command associated to `message' exist?
		require
			positive_message: message >= 0
		do
			Result := has (message)
		end

feature {NONE} -- Implementation

	Table_size: INTEGER is 5
			-- Initial hash table size

end -- class WEL_COMMAND_MANAGER


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

