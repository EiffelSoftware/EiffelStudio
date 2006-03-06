indexing
	description: "Common ancestor to all Eiffel inheritance clauses"
	date: "$$"
	revision: "$$"	

deferred class
	CODE_INHERITANCE_CLAUSE

inherit
	CODE_ENTITY

feature {NONE} -- Initialization

	make (a_routine: like routine; a_parent: like parent) is
			-- Set `routine' with `a_routine' and `parent' with `a_parent'.
		require
			non_void_routine: a_routine /= Void
			non_void_parent: a_parent /= Void
		do
			parent := a_parent
			routine := a_routine
		ensure
			routine_set: routine = a_routine
			parent_set: parent = a_parent
		end

feature	-- Access
	
	routine: CODE_MEMBER_REFERENCE
			-- Clause target routine

	parent: CODE_TYPE_REFERENCE
			-- Clause target type
		
	keyword: STRING is
			-- Associated Eiffel keyword
		deferred
		end

	code: STRING is
			-- Generated line in inheritance clause
		do
			Result := routine.eiffel_name
		end

invariant
	non_void_parent: parent /= Void
	non_void_routine: routine /= Void

end -- class CODE_INHERITANCE_CLAUSE

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