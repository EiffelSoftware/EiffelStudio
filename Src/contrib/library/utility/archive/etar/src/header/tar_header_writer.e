note
	description: "[
			Abstract parent class for all classes that write tar headers
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAR_HEADER_WRITER

inherit
	TAR_UTILS

feature -- Status

	required_blocks: INTEGER
			-- How many blocks are required to write `active_header'?
		require
			has_active_header: attached active_header
		deferred
		ensure
			valid_size: Result > 0
		end

	writable (a_header: TAR_HEADER): BOOLEAN
			-- Can `a_header' be written?
		deferred
		end

	active_header: detachable TAR_HEADER
			-- The header for which writing is in progress.

	finished_writing: BOOLEAN
			-- Has `active_header' been completely written?
		do
			Result := attached active_header and then written_blocks = required_blocks
		end

	written_blocks: INTEGER
			-- Indicates how many blocks have been written so far.

feature -- Setup

	set_active_header (a_header: TAR_HEADER)
			-- Set `active_header' to `a_header'.
		require
			writable: writable (a_header)
		do
			active_header := a_header.twin
			written_blocks := 0
			prepare_header
		ensure
			has_active_header: attached active_header
--			header_set: active_header ~ a_header 		-- pax will change the header to make it fit in ustar
		end

feature -- Output

	write_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Write next block of `active_header' to `p', starting at positin `a_pos'.
		require
			non_negative_position: a_pos >= 0
			enough_space: p.count >= a_pos + {TAR_CONST}.tar_block_size
			has_active_header: attached active_header
			not_finished: not finished_writing
		deferred
		ensure
			another_block_written: written_blocks = old written_blocks + 1
		end

	next_block: MANAGED_POINTER
			-- Write next block of `active_header' to a new managed pointer with block size.
		require
			has_active_header: attached active_header
			not_finished: not finished_writing
		do
			create Result.make ({TAR_CONST}.tar_block_size)
			write_block_to_managed_pointer (Result, 0)
		ensure
			block_size: Result.count = {TAR_CONST}.tar_block_size
			another_block_written: written_blocks = old written_blocks + 1
		end

feature {NONE} -- Utilities

	prepare_header
			-- prepare `active_header' after set_header.
		require
			has_active_header: attached active_header
		deferred
		end

invariant
	can_always_write_header: attached active_header as header implies writable(header)
	non_negative_blocks_written: written_blocks >= 0

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
