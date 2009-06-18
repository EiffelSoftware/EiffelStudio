note
	description: "[
		{PEG_OPTIONAL}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_OPTIONAL

inherit
	PEG_SINGLE_CHILD


create
	make

feature -- Implementation

	parse (a_string: STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			Result := child.parse (a_string)
			if Result.success then
				Result := build_result (Result)
			else
				create Result.make (a_string, True, a_string)
			end
		end

	serialize: STRING
			-- <Precursor>
		do
			Result := "(" + child.serialize + ")?"
		end
end
