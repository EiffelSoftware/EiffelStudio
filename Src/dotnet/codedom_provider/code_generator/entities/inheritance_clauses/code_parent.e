indexing
	description: "Parents of an Eiffel class with corresponding inheritance clauses"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PARENT

inherit
	ANY

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
			create {ARRAYED_LIST [CODE_RENAME_CLAUSE]} rename_clauses.make (4)
		ensure then
			type_set: type = a_type
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
			non_void_rename_clauses: rename_clauses /= Void
		end
		
feature	-- Access

	type: CODE_TYPE_REFERENCE
			-- Associated type

	undefine_clauses: LIST [CODE_UNDEFINE_CLAUSE]
			-- Undefine inheritance clauses

	redefine_clauses: LIST [CODE_REDEFINE_CLAUSE]
			-- Redefine inheritance clauses

	rename_clauses: LIST [CODE_RENAME_CLAUSE]
			-- Rename inheritance clauses

	snippet_parent: CODE_SNIPPET_PARENT
			-- Corresponding snippet parent

	code: STRING is
			-- | Result := "`name' [`inheritace_clauses']"
		local
			l_has_snippet, l_has_clause: BOOLEAN
		do
			create Result.make (250)
			
			Result.append_character ('%T')
			Result.append (type.eiffel_name)
			Result.append_character ('%N')

			l_has_snippet := snippet_parent /= Void
			
			l_has_clause := l_has_snippet and then snippet_parent.renames /= Void
			if l_has_clause then
				Result.append (snippet_parent.renames_code)
			end
			Result.append (clauses_code (rename_clauses, not l_has_clause))

			l_has_clause := l_has_snippet and then snippet_parent.exports /= Void
			if l_has_clause then
				Result.append (snippet_parent.exports_code)
			end
			
			l_has_clause := l_has_snippet and then snippet_parent.undefines /= Void
			if l_has_clause then
				Result.append (snippet_parent.undefines_code)
			end
			Result.append (clauses_code (undefine_clauses, not l_has_clause))

			l_has_clause := l_has_snippet and then snippet_parent.redefines /= Void
			if l_has_clause then
				Result.append (snippet_parent.redefines_code)
			end
			Result.append (clauses_code (redefine_clauses, not l_has_clause))

			l_has_clause := l_has_snippet and then snippet_parent.selects /= Void
			if l_has_clause then
				Result.append (snippet_parent.selects_code)
			end

			if undefine_clauses.count > 0 or redefine_clauses.count > 0 or rename_clauses.count > 0 or 
				(l_has_snippet and then not snippet_parent.is_empty) then
				Result.append ("%T%Tend%N")
				Result.append ("%N")
			end
		end
		
feature -- Status Setting Inheritance Clauses

	add_undefine_clause (a_clause: CODE_UNDEFINE_CLAUSE) is
			-- Add `a_clause' to `undefine_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			undefine_clauses.extend (a_clause)
		ensure
			undefine_clause_added: undefine_clauses.has (a_clause)
		end

	add_redefine_clause (a_clause: CODE_REDEFINE_CLAUSE) is
			-- Add `a_clause' to `redefine_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			redefine_clauses.extend (a_clause)
		ensure
			redefine_clause_added: redefine_clauses.has (a_clause)
		end

	add_rename_clause (a_clause: CODE_RENAME_CLAUSE) is
			-- Add `a_clause' to `rename_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			rename_clauses.extend (a_clause)
		ensure
			rename_clause_added: rename_clauses.has (a_clause)
		end

	set_snippet_parent (a_parent: CODE_SNIPPET_PARENT) is
			-- Set `snippet_parent' with `a_parent'.
		require
			non_void_parent: a_parent /= Void
			valid_parent: a_parent.type.is_equal (type.eiffel_name)
		do
			snippet_parent := a_parent
		ensure
			snippet_parent_set: snippet_parent = a_parent
		end
		
feature {NONE} -- Implementation
	
	clauses_code (a_list: LIST [CODE_INHERITANCE_CLAUSE]; a_generate_keyword: BOOLEAN): STRING is
			-- Code for `a_list'
			-- Includes inheritance clause keyword iff `a_generate_keyword'
		require
			non_void_list: a_list /= Void
		do
			create Result.make (120)
					
			from
				a_list.start
				if not a_list.after then
					if a_generate_keyword then
						Result.append ("%T%T")
						Result.append (a_list.item.keyword)
						Result.append_character ('%N')
					else
						Result.append ("%T%T%T,%N")
					end
					Result.append ("%T%T%T")
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
	non_void_rename_clauses: rename_clauses /= Void

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