note
	description: "[
			Common ancestor for tar header parsers
			
			Additionally provides a string parsing utility
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAR_HEADER_PARSER

inherit
	ERROR_HANDLER

feature -- Status

	parsing_finished: BOOLEAN
			-- Has parsing step finished yet?
			-- On parse failure this is True as well.

feature -- Parsing

	parse_block (a_block: MANAGED_POINTER; a_pos: INTEGER)
			-- parse `a_block' (starting from `a_pos').
		require
			block_size_large_enough: a_pos + {TAR_CONST}.tar_block_size <= a_block.count
			non_negative_length: a_pos >= 0
		deferred
		end

feature -- Result query

	parsed_header: detachable TAR_HEADER
			-- Return the last parsed header if no error occured.
		require
			completely_parsed: parsing_finished
		do
			if not has_error then
				Result := last_parsed_header
			else
				Result := Void
			end
		end

feature {NONE} -- Implementation

	last_parsed_header: detachable TAR_HEADER
			-- The current header (based on the parsed blocks).
			-- Void in case of parse failures.

feature {NONE} -- Utilities

	next_block_string (a_block: MANAGED_POINTER; a_pos, a_length: INTEGER): STRING
			-- Parse a string in `a_block' from `a_pos' with length at most `a_length'
			-- A string is a sequence of characters, stopping at the first '%U'
			-- that occurs. In case no '%U' occurs, it ends after at `a_length'
			-- characters.
			-- FIXME: Slow implementation.
		require
			enough_characters: a_pos + a_length <= a_block.count
			non_negative_pos: a_pos >= 0
			positive_length: a_length > 0
		local
			c: CHARACTER_8
			i: INTEGER
		do
			create Result.make (a_length)
			from
				i := 0
				c := ' ' -- dummy character different from %U
			until
				i >= a_length or c = '%U'
			loop
				c := a_block.read_character (a_pos + i)
				if c /= '%U' then
					Result.append_character (c)
				end
				i := i + 1
			end
		end

invariant
	valid_header_if_no_errors: not has_error and parsing_finished implies attached last_parsed_header
	parsing_finished_on_error: has_error implies parsing_finished
note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
