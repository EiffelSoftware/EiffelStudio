indexing
	description: "Snippet inheritance export clause"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SNIPPET_EXPORT_CLAUSE

inherit
	CODE_SNIPPET_INHERITANCE_CLAUSE
		rename
			make as make_inheritance_clause
		end

create
	make

feature {NONE} -- Initialization

	make (a_routine_name: STRING; a_type_list: LIST [STRING]) is
			-- Set `routine_name' with `a_routine_name' and `type_list' with `a_type_list'.
		require
			non_void_routine_name: a_routine_name /= Void
			non_void_type_list: a_type_list /= Void
		do
			make_inheritance_clause (a_routine_name)
			type_list := a_type_list
		ensure
			routine_name_set: routine_name = a_routine_name
			type_list_set: type_list = a_type_list
		end

feature -- Access

	type_list: LIST [STRING]
				-- Types to which feature with eiffel name `feature_name' is exported

end -- class CODE_SNIPPET_EXPORT_CLAUSE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------	
