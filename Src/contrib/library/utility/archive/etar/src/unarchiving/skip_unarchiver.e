note
	description: "[
			Simple UNARCHIVER that skips all payload (useful as fallback)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SKIP_UNARCHIVER

inherit
	UNARCHIVER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create new instance.
		do
			name := "skip unarchiver"

			Precursor
		end

feature -- Status

	unarchivable (a_header: TAR_HEADER): BOOLEAN
			-- Is Current able to handle payload that belongs to `a_header'?
			-- Note: SKIP_UNARCHIVER takes all headers and skips the payload
		once
			Result := True
		end

	required_blocks: INTEGER
			-- Indicate how many blocks are required to unarchive the payload that belongs to `active_header'.
		do
			if attached active_header as l_header then
				if not {TAR_CONST}.tar_header_only_typeflags.has (l_header.typeflag) then
					Result := needed_blocks (l_header.size).as_integer_32
				else
						--|	Result := 0		-- Initialized to 0 anyway
				end
			else
					-- Unreachable (precondition)
			end
		end

feature -- Unarchiving

	unarchive_block (a_block: MANAGED_POINTER; a_pos: INTEGER)
			-- Unarchive `a_block' starting from `a_pos'.
		do
			unarchived_blocks := unarchived_blocks + 1
		end

feature {NONE} -- Implementation

	do_internal_initialization
			-- Initialize internals.
		do
				--| do_nothing
		end

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
