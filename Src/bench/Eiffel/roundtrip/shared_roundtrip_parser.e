indexing
	description: "Shared roundtrip parser"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ROUNDTRIP_PARSER

feature -- Parser

	roundtrip_eiffel_parser: EIFFEL_PARSER is
			-- Roundtrip Eiffel parser
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_case_sensitive (True)
		ensure
			eiffel_parser_not_void: Result /= Void
		end

end
