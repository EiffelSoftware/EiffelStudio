indexing
	description: "Eiffel rename inheritance clause"
	date: "$Date$"
	revision: "$Revision$"	

class
	CODE_SNIPPET_RENAME_CLAUSE

inherit
	CODE_SNIPPET_INHERITANCE_CLAUSE
		rename
			make as inheritance_clause_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_routine: like routine_name; a_new_name: like target_name) is
			-- Set `routine' with `a_routine' and `target_name' with `a_new_name'.
		require
			non_void_routine: a_routine /= Void
			non_void_new_name: a_new_name /= Void
		do
			inheritance_clause_make (a_routine)
			target_name := a_new_name
		ensure
			routine_set: routine_name = a_routine
			target_name_set: target_name = a_new_name
		end

feature -- Access

	target_name: STRING
			-- Name of rename clause target

end -- class CODE_SNIPPET_RENAME_CLAUSE

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