note
	description: "[
		{PEG_ANY}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_ANY

inherit
	PEG_ABSTRACT_PEG

create
	make

feature -- Initialization

	make
		do
		end

feature -- Implementation

	parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			if a_string.is_empty then
				create Result.make (a_string, False)
				Result := fix_result (Result)
			else
				create Result.make (a_string.substring_index (2), True)
				if not ommit then
					Result.append_result (a_string [1])
				end
				Result := build_result (Result)
			end
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): STRING
			-- <Precursor>
		do
			Result := "."
		end

end
