note
	description: "[
			Common ancestor for storage backends usable by ARCHIVE
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STORAGE_BACKEND

inherit
	ERROR_HANDLER

feature -- Status setting

	open_read
			-- Open storage backend for reading.
		deferred
		ensure
			error_or_readable: has_error or else readable
		end

	open_write
			-- Open storage backend for writing.
		deferred
		ensure
			error_or_writable: has_error or else writable
		end

	close
			-- Close storage backend.
		deferred
		ensure
			closed: closed
		end

feature -- Status

	archive_finished: BOOLEAN
			-- Do the next two blocks only contain NUL bytes?
			-- This denotes the end of an archive, if not occuring in some payload.
		require
			readable: readable
		deferred
		end

	block_ready: BOOLEAN
			-- Is there a block ready?
		require
			readable: readable
		deferred
		ensure
			no_blocks_on_error: Result implies not has_error
		end

	readable: BOOLEAN
			-- Is Current backend readable?
		deferred
		ensure
			no_error_if_readable: Result implies not has_error
		end

	writable: BOOLEAN
			-- Is Current backend writable and accepts blocks to be written to Current?
		deferred
		ensure
			no_error_if_writable: Result implies not has_error
		end

	closed: BOOLEAN
			-- Is Current backend closed?
		deferred
		end

feature -- Reading

	last_block: MANAGED_POINTER
			-- Last read block.
		require
			has_block: block_ready
		deferred
		ensure
			correct_size: Result.count = {TAR_CONST}.tar_block_size
		end

	read_block
			-- Try to read next block.
		require
			readable: readable
		deferred
		ensure
			error_or_ready: has_error or block_ready
		end

feature -- Writing

	write_block (a_block: MANAGED_POINTER; a_pos: INTEGER)
			-- Write `a_block' starting at position `a_pos'.
		require
			writable: writable
			non_negative_pos: a_pos >= 0
			enough_space: a_block.count >= a_pos + {TAR_CONST}.tar_block_size
		deferred
		end

	finalize
			-- Finalize archive.
			-- i.e: write two 0 blocks and close.
		require
			writable: writable
		deferred
		ensure
			closed: closed
		end
note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
