indexing

	description:

		"Filesystem's directories"

	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_DIRECTORY

inherit

	DIRECTORY
		rename
			make as ise_make,
			open_read as ise_open_read,
			close as ise_close
		end

creation

	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Create a new directory object.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.empty
		do
			ise_make (a_name)
		ensure
			name_set: name = a_name
		end

feature -- Access

	last_entry: STRING is
			-- Last entry (file or subdirectory name) read
		require
			is_open_read: is_open_read
			not_end_of_input: not end_of_input
		do
			Result := lastentry
		ensure
			last_entry_not_void: Result /= Void
		end

feature -- Status report

	is_open_read: BOOLEAN is
			-- Has directory been opened in read mode?
		do
			Result := not is_closed
		ensure
			not_closed: Result implies not is_closed
		end

	end_of_input: BOOLEAN is
			-- Have all entries been read?
		require
			is_open_read: is_open_read
		do
			Result := lastentry = Void
		end

feature -- Basic operations

	open_read is
			-- Try to open directory in read mode.  Set `is_open_read'
			-- to true and is ready to read first entry in directory
			-- if operation was successful.
		require
			closed: is_closed
		local
			rescued: BOOLEAN
		do
			if not rescued then
				ise_open_read
				lastentry := Dummy_entry
			elseif not is_closed then
				close
			end
		ensure
			not_end_of_input: is_open_read implies not end_of_input
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	close is
			-- Close directory.
		require
			not_closed: not is_closed
		do
			ise_close
			lastentry := Void
		ensure
			closed: is_closed
		end

feature -- Cursor movement

	read_entry is
			-- Read next entry in directory.
			-- Make result available in `last_entry'.
		require
			is_open_read: is_open_read
			not_end_of_input: not end_of_input
		do
			readentry
		end

feature {NONE} -- Implementation

	Dummy_entry: STRING is ""

invariant

	name_not_void: name /= Void
	name_not_empty: not name.empty

end -- class KL_DIRECTORY
