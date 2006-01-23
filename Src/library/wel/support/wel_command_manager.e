indexing
	description: "Command manager which is able to retrieve the command %
		%associated to a Windows message."
	legal: "See notice at end of class."
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

create
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

	Table_size: INTEGER is 5;
			-- Initial hash table size

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_COMMAND_MANAGER

