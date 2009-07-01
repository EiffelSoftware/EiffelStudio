note
	description: "[
		{PEG_CONSUMER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_CONSUMER

inherit
	PEG_SINGLE_CHILD

create
	make

feature -- Implementation

	parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		local
			l_index: INTEGER
		do
			l_index := a_string.current_internal_position
			Result := child.parse (a_string)
			if Result.success then
				Result.replace_result (a_string.substring_internal (l_index, Result.left_to_parse.current_internal_position-1))
				Result := build_result (Result)
			else
				Result := fix_result (Result)
			end
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): STRING
			-- <Precursor>
		do
			if not already_serialized (a_already_visited, Current) then
				Result := "consume(" + child.internal_serialize (a_already_visited) + ")"
			else
				Result := "recursion"
			end
		end
end
