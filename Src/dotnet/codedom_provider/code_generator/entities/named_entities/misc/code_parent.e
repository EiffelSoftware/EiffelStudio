indexing
	description: "Parents of an Eiffel class with corresponding inheritance clauses"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PARENT

create
	make
	
feature -- Initialization

	make (a_type: like type) is
			-- Set `type' with `a_type'
		require
			non_void_type: a_type /= Void
		do
			type := a_type
			create {ARRAYED_LIST [CODE_UNDEFINE_CLAUSE]} undefine_clauses.make (4)
			create {ARRAYED_LIST [CODE_REDEFINE_CLAUSE]} redefine_clauses.make (4)
		ensure then
			type_set: type = a_type
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
		end
		
feature	-- Access

	type: CODE_TYPE_REFERENCE
			-- Associated type

	undefine_clauses: LIST [CODE_UNDEFINE_CLAUSE]
			-- Rename inheritance clauses

	redefine_clauses: LIST [CODE_REDEFINE_CLAUSE]
			-- Rename inheritance clauses

	code: STRING is
			-- | Result := "`name' [`inheritace_clauses']"
		do
			create Result.make (250)
			
			Result.append_character ('%T')
			Result.append (type.eiffel_name)
			Result.append_character ('%N')

			Result.append (clauses_code (undefine_clauses))
			Result.append (clauses_code (redefine_clauses))

			if undefine_clauses.count > 0 or redefine_clauses.count > 0 then
				Result.append ("%T%Tend%N")
				Result.append ("%N")
			end
		end
		
feature -- Status Setting Inheritance Clauses

	add_undefine_clause (a_clause: CODE_UNDEFINE_CLAUSE) is
			-- Add `a_clause' to `inheritance_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			undefine_clauses.extend (a_clause)
		ensure
			undefine_clause_added: undefine_clauses.has (a_clause)
		end

	add_redefine_clause (a_clause: CODE_REDEFINE_CLAUSE) is
			-- Add `a_clause' to `inheritance_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			redefine_clauses.extend (a_clause)
		ensure
			redefine_clause_added: redefine_clauses.has (a_clause)
		end

feature {NONE} -- Implementation
	
	clauses_code (a_list: LIST [CODE_INHERITANCE_CLAUSE]): STRING is
			-- Code for `a_list'
		require
			non_void_list: a_list /= Void
		do
			create Result.make (120)
					
			from
				a_list.start
				if not a_list.after then
					Result.append ("%T%T")
					Result.append (a_list.item.keyword)
					Result.append ("%N%T%T%T")
					Result.append (a_list.item.code)
					a_list.forth
				end
			until
				a_list.after
			loop
				Result.append (",%N%T%T%T")
				Result.append (a_list.item.code)
				a_list.forth
			end
			if a_list.count > 0 then
				Result.append_character ('%N')
			end
		end

invariant
	non_void_type: type /= Void
	non_void_undefine_clauses: undefine_clauses /= Void
	non_void_redefine_clauses: redefine_clauses /= Void

end -- class CODE_PARENT

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