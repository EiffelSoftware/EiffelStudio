indexing
	description: "Common ancestor to all Eiffel inheritance clauses"
	date: "$$"
	revision: "$$"	

deferred class
	ECDP_INHERITANCE_CLAUSE

inherit
	ECDP_NAMED_ENTITY

feature	-- Access
	
	parent: STRING
		-- Name of class attached to the clause
		
feature -- Status Setting

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		require
			non_void_parent: a_parent /= Void
			valid_parent: not a_parent.is_empty
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end		

end -- class ECDP_INHERITANCE_CLAUSE

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