note
	description: "Summary description for {PEG_EPSILON}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_EPSILON

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
			create Result.make (a_string.twin, True)
			Result := build_result (Result)
		end

	internal_serialize: STRING
			-- <Precursor>
		do
			Result := "e"
		end

end
