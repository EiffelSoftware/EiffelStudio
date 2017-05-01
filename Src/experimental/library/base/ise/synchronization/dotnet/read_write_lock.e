note
	description: "Read/Write synchronization object, allows multiple reader threads to have %
		%access to a resource, and only one writer thread."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	READ_WRITE_LOCK

create
	make

feature {NONE} -- Initialization

	make
			-- Create read/write lock.
		do
			create item.make
			is_set := True
		ensure
			item_set: is_set
		end

feature -- Access

	is_set: BOOLEAN
			-- Is read/write lock initialized?

feature -- Status setting

	acquire_read_lock
			-- Lock current on a read.
		require
			is_set: is_set
		do
				-- (-1) to force an infinite wait.
			item.acquire_reader_lock (-1)
		end

	acquire_write_lock
			-- Lock current on a write.
		require
			is_set: is_set
		do
				-- (-1) to force an infinite wait.
			item.acquire_writer_lock (-1)
		end

	release_read_lock
			-- Unlock Reader lock.
		require
			is_set: is_set
		do
			item.release_reader_lock
		end

	release_write_lock
			-- Unlock writer lock.
		require
			is_set: is_set
		do
				-- We do not use `item.release_writer_lock' because when calling this routine
				-- we must have the lock, in which case the documentation states that it calls
				-- `item.release_writer_lock'. This is consistent with our implementation for classic Eiffel.
			item.release_reader_lock
		end

	destroy
			-- Destroy read/write lock.
		require
			is_set: is_set
		do
			is_set := False
		ensure
			not_set: not is_set
		end

feature -- Obsolete

	release_reader_lock, release_writer_lock
			-- Unlock Reader or Writer lock.
		obsolete
			"Use `release_read_lock' or `release_write_lock'. [2017-05-31]"
		require
			is_set: is_set
		do
			item.release_reader_lock
		end

feature {NONE} -- Implementation

	item: READER_WRITER_LOCK;
			-- Underlying .NET object.

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
