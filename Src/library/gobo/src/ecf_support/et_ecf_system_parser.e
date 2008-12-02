indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ET_ECF_SYSTEM_PARSER

inherit
	ET_ECF_PARSER

create
	make, make_standard, make_with_factory

feature -- Parsing

	parse_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Parse ECF file `a_file'.
		do
		end

end
