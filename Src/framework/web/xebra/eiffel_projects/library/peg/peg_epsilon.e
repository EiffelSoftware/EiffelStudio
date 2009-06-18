note
	description: "Summary description for {PEG_EPSILON}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_EPSILON

inherit
	PARSING_EXPRESSION_GRAMMAR

create
	make

feature -- Initialization

	make
		do
		end

feature -- Implementation

	parse (a_string: STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			create Result.make (a_string.twin, True)
		end

	serialize: STRING
			-- <Precursor>
		do
			Result := "e"
		end

end
