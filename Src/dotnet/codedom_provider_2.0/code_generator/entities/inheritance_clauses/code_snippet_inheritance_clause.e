indexing
	description: "Common ancestor to all snippet inheritance clauses"
	date: "$date$"
	revision: "$revision$"	

deferred class
	CODE_SNIPPET_INHERITANCE_CLAUSE

feature {NONE} -- Initialization

	make (a_routine_name: like routine_name) is
			-- Set `routine_name' with `a_routine_name'
		require
			non_void_routine_name: a_routine_name /= Void
		do
			routine_name := a_routine_name
		ensure
			routine_name_set: routine_name = a_routine_name
		end

feature	-- Access
	
	routine_name: STRING
			-- Clause target routine

invariant
	non_void_routine_name: routine_name /= Void

end -- class CODE_SNIPPET_INHERITANCE_CLAUSE

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