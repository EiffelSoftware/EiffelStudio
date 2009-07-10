note
	description: "[
		{PEG_NEGATE}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_NEGATE

inherit
	PEG_SINGLE_CHILD

create
	make

feature -- Implementation

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			Result := child.parse (a_string)
			create Result.make (a_string, not Result.success)
			if Result.success then
				Result := build_result (Result)
			else
				Result := fix_result (Result)
			end
		end

	default_parse_info: STRING
			-- <Precursor>	
		do
			Result := "negate(" + child.short_debug_info + ")"
		end

	short_debug_info: STRING
			-- <Precursor>		
		do
			Result := "negate"
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): STRING
			-- <Precursor>
		do
			if not already_serialized (a_already_visited, Current) then
				Result := "!(" + child.internal_serialize (a_already_visited) + ")"
			else
				Result := "recursion"
			end
		end

end
