note
	description: "Summary description for {EVENT_NAMED_PIPE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_UNBLOCK_NAMED_PIPE


create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Init
		require
			name_not_void: a_name /= Void
		do
			name := a_name
		end

feature -- Access

	name: STRING
			-- Name of the pipe

	read_descriptor: INTEGER

feature -- Operation

	close
		do
		end

	create_read
			-- Open file in read mode;
			-- create it if it does not exist.
		do
		end

	create_write
			-- Open file in read mode;
			-- create it if it does not exist.
		do
		end

	read_to_end
			-- Read file into `last_string' until the end.
		do
		end

	delete
			-- Remove link with physical file.
			-- File does not physically disappear from the disk
			-- until no more processes reference it.
			-- I/O operations on it are still possible.
			-- A directory must be empty to be deleted.
		do
		end

feature -- Status report

	exists: BOOLEAN
			-- Does physical file exist?
			-- (Uses effective UID.)
		do
		end

end
