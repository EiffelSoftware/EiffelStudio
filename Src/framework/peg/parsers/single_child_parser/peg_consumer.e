note
	description: "[
		This PEG parser tries to parse with its child parser. If the child is successful
		it replaces the parsing result by the string extracted from the starting parse point
		to the current parse poitn. Every result of the child is overwritten.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_CONSUMER

inherit
	PEG_SINGLE_CHILD

create
	make

feature -- Implementation

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			l_index: INTEGER
		do
			l_index := a_string.current_internal_position
			Result := child.parse (a_string)
			if Result.success then
				Result.replace_result (a_string.substring_internal (l_index, Result.left_to_parse.current_internal_position - 1))
				Result := build_result (Result)
			else
				Result := fix_result (Result)
			end
		end

	default_parse_info: READABLE_STRING_8
				-- <Precursor>	
			do
				Result := "consumer (" + child.short_debug_info + ")"
			end

	short_debug_info: READABLE_STRING_8
			-- <Precursor>		
		do
			Result := "consumer"
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): READABLE_STRING_8
			-- <Precursor>
		do
			if not already_serialized (a_already_visited, Current) then
				Result := "consume(" + child.internal_serialize (a_already_visited) + ")"
			else
				Result := "recursion"
			end
		end
end
