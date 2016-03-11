note
	description: "[
			Common ancestor for all ARCHIVABLES
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARCHIVABLE

inherit
	ANY

	TAR_UTILS
		export
			{NONE} all
		end

feature -- Status

	finished_writing: BOOLEAN
			-- Is writing completed?
			-- (i.e everything was writte, usefull when using blockwise writing).
		do
			Result := written_blocks = required_blocks
		end

	required_blocks: INTEGER
			-- How many blocks are required to store this ARCHIVABLE?
		deferred
		ensure
			non_negative: Result >= 0
		end

	written_blocks: INTEGER
			-- How many blocks have been written so far?

	header: TAR_HEADER
			-- Header that belongs to the payload.
		deferred
		end

feature -- Output

	write_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Write next block to `p' starting from `a_pos'.
		require
			non_negative_position: a_pos >= 0
			enough_space: p.count >= a_pos + {TAR_CONST}.tar_block_size
			not_finished: not finished_writing
		deferred
		ensure
			block_written: written_blocks = old written_blocks + 1
		end

	next_block: MANAGED_POINTER
			-- Write next block to a new managed pointer and return it.
		do
			create Result.make ({TAR_CONST}.tar_block_size)
			write_block_to_managed_pointer (Result, 0)
		ensure
			block_written: written_blocks = old written_blocks + 1
			block_size: Result.count = {TAR_CONST}.tar_block_size
		end

invariant
	non_negative_written_blocks: written_blocks >= 0

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
