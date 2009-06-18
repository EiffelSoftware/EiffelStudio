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

	parse (a_string: STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			Result := child.parse (a_string)
			create Result.make (a_string, not Result.success)
		end

	serialize: STRING
			-- <Precursor>
		do
			Result := "!(" + child.serialize + ")"
		end

end
