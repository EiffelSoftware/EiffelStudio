note
	description: "[
			Common ancestor for classes that allow to unarchive payload parts of archives.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARCHIVER

inherit
	ERROR_HANDLER
		redefine
			default_create
		end

	TAR_UTILS
		export
			{NONE} all
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
				-- Default initialization for UNARCHIVER.
		do
--			active_header := Void
--			unarchived_blocks := 0
			Precursor {ERROR_HANDLER}
		ensure then
			no_unarchiving_in_progress: unarchiving_finished
		end

feature -- Access

	name: STRING_8
			-- Name used when printing error messages reported by Current unarchiver.

	active_header: detachable TAR_HEADER
			-- Current header during unarchiving.

	required_blocks: INTEGER
			-- Number of blocks required to unarchive related payload with respect to `active_header'.
		require
			has_active_header: attached active_header
		deferred
		end

feature -- Status			

	unarchived_blocks: INTEGER
			-- How many blocks have been unarchived so far?

	unarchiving_finished: BOOLEAN
			-- Unarchiving finished?
		do
			Result := has_error or attached active_header implies unarchived_blocks = required_blocks
		end

	unarchivable (a_header: TAR_HEADER): BOOLEAN
			-- Can this unarchiver unarchive payload that belongs to `a_header'?
		deferred
		end

feature -- Basic unarchiving operations.

	frozen initialize (a_header: TAR_HEADER)
			-- Initialize for unarchiving payload for `a_header'.
		require
			can_handle: unarchivable (a_header)
			no_unarchiving_in_progress: unarchiving_finished
		do
			active_header := a_header
			unarchived_blocks := 0
			do_internal_initialization
		ensure
			header_attached: attached active_header
			nothing_unarchived: unarchived_blocks = 0
		end

	unarchive_block (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Unarchive next block, stored in `p' starting at `a_pos'.
		require
			non_negative_position: a_pos >= 0
			enough_payload: p.count >= a_pos + {TAR_CONST}.tar_block_size
			header_attached: attached active_header
			not_finished: not unarchiving_finished
		deferred
		ensure
			another_block_unarchived: unarchived_blocks = old unarchived_blocks + 1
			still_attached: attached active_header
			last_block_unarchived_iff_finished: attached active_header as header and then ((unarchived_blocks.as_natural_64 = needed_blocks (header.size)) = unarchiving_finished)
		end

feature {NONE} -- Implementation

	do_internal_initialization
			-- Initialize subclass specific internals after initialize has done its job.
		require
			header_attached: attached active_header
		deferred
		end

invariant
	unarchiving_in_progress_needs_header: not unarchiving_finished implies attached active_header
	unarchived_blocks_needs_header: unarchived_blocks > 0 implies attached active_header
	non_negative_number_of_blocks: unarchived_blocks >= 0

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
