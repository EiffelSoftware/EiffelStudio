note
	description: "[
		{PEG_ANY}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_ANY

inherit
	PEG_SINGLE_CHARACTER_PARSER

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
			else
				create Result.make (a_string.substring (2, a_string.count), True)
				Result.append_result (a_string [1])
				if not ommit then
					Result := build_result (Result)
				end
			end
		end

	serialize: STRING
			-- <Precursor>
		do
			Result := "."
		end

end
