note
	description: "Provide input validation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_INPUT_VALIDATOR


feature -- Basic Operations

	validate_input (a_source: READABLE_STRING_32; a_arg: READABLE_STRING_32)
			-- Validate input for control `a_source'.
		local
			l_valid: BOOLEAN
			l_count: INTEGER
		do
			l_count := a_arg.count
			min_text_lengths.search (a_source)
			if min_text_lengths.found and then l_count >= min_text_lengths.found_item then
				max_text_lengths.search (a_source)
				if max_text_lengths.found then
					l_valid := l_count <= max_text_lengths.found_item
				end
			end
		end



feature {NONE} -- Private Access

	max_text_lengths: HASH_TABLE [INTEGER, STRING] is
			-- Maximum text lengths of text edit controls, keyed by control ID
			-- Must correspond to size of data type in database!
		deferred
		end

	min_text_lengths: HASH_TABLE [INTEGER, STRING] is
			-- Maximum text lengths of text edit controls, keyed by control ID
			-- Must correspond to size of data type in database!
		deferred
		end

end -- class EFA_INPUT_VALIDATOR
