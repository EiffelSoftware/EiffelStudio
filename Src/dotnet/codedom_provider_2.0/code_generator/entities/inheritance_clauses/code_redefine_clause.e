indexing
	description: "Eiffel redefine inheritance clause"
	date: "$$"
	revision: "$$"	

class
	CODE_REDEFINE_CLAUSE

inherit
	CODE_INHERITANCE_CLAUSE

create
	make

feature -- Access

	keyword: STRING is "redefine"
			-- Associated Eiffel keyword

end -- class CODE_REDEFINE_CLAUSE

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