indexing
	description: "Read/Write synchronization object, allows multiple reader threads to have %
		%access to a resource, and only one writer thread."
	date: "$Date$"
	revision: "$Revision$"

class
	READ_WRITE_LOCK

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature -- Initialization

	default_create is
			-- Create read/write lock.
		do
			create item.make
		ensure then
			item_set: is_set
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is read/write lock initialized?
		do
			Result := (item /= Void)
		end

feature -- Status setting

	acquire_read_lock is
			-- Lock current on a read.
		require
			exists: is_set
		do
				-- (-1) to force an infinite wait.
			item.acquire_reader_lock (-1)
		end

	acquire_write_lock is
			-- Lock current on a write.
		require
			exists: is_set
		do
				-- (-1) to force an infinite wait.
			item.acquire_writer_lock (-1)
		end

	release_reader_lock is
			-- Unlock Reader lock.
		require
			exists: is_set
		do
			item.release_reader_lock
		end

	release_writer_lock is
			-- Unlock writer lock.
		require
			exists: is_set
		do
			item.release_writer_lock
		end

	destroy is
			-- Destroy read/write lock.
		require
			exists: is_set
		do
			item := Void
		end

feature {NONE} -- Implementation

	item: READER_WRITER_LOCK
			-- Underlying .NET object.

end -- class READ_WRITE_LOCK
