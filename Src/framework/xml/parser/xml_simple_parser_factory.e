note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XML_SIMPLE_PARSER_FACTORY

inherit
	XML_PARSER_FACTORY

feature -- Status report

	is_parser_available: BOOLEAN = True
			-- Is XML parser available?

feature -- Access

	new_parser: XML_SIMPLE_PARSER
			-- New XML parser
		do
			create Result.make
		end

end
