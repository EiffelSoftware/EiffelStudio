indexing

	description: "Shared instance of {CODE_INHERITANCE_CLAUSE_PARSER}"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_INHERITANCE_CLAUSE_PARSER

feature -- Access

	Inheritance_clause_parser: CODE_INHERITANCE_CLAUSE_PARSER is
			-- Shared instance
		once
			create Result.make
		end

end -- class CODE_SHARED_INHERITANCE_CLAUSE_PARSER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------