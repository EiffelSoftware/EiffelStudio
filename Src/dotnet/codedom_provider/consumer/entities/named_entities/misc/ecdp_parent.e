indexing
	description: "Parents of an Eiffel class with corresponding inheritance clauses"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_PARENT

inherit
	ECDP_NAMED_ENTITY
		redefine
			ready
		end

create
	make
	
feature -- Initialization

	make is
			-- Call Precursor {ECDP_NAMED_ENTITY}
		do
			default_create
			create rename_clauses.make
			create undefine_clauses.make
			create redefine_clauses.make
			create select_clauses.make
			create export_clauses.make
		ensure then
			non_void_name: name /= Void
		end
		
feature	-- Access

	rename_clauses: LINKED_LIST [ECDP_RENAME_CLAUSE]
			-- Rename inheritance clauses

	undefine_clauses: LINKED_LIST [ECDP_UNDEFINE_CLAUSE]
			-- Rename inheritance clauses

	redefine_clauses: LINKED_LIST [ECDP_REDEFINE_CLAUSE]
			-- Rename inheritance clauses

	select_clauses: LINKED_LIST [ECDP_SELECT_CLAUSE]
			-- Rename inheritance clauses

	export_clauses: LINKED_LIST [ECDP_EXPORT_CLAUSE]
			-- Rename inheritance clauses

	code: STRING is
			-- | Result := "`name' [`inheritace_clauses']"
		local
			first_element: BOOLEAN
			no_clauses: BOOLEAN
		do
			check
				name_set: not name.is_empty
			end
			create Result.make (250)
			
			Result.append (dictionary.Tab)
			Result.append (eiffel_types.eiffel_type_name (name))
			Result.append (dictionary.New_line)

			Result.append (generate_clauses (rename_clauses, Dictionary.Rename_keyword))
			Result.append (generate_clauses (undefine_clauses, Dictionary.Undefine_keyword))
			Result.append (generate_clauses (redefine_clauses, Dictionary.Redefine_keyword))
			Result.append (generate_clauses (select_clauses, Dictionary.Select_keyword))
			Result.append (generate_clauses (export_clauses, Dictionary.Export_keyword))
			

			if  rename_clauses.count > 0 or undefine_clauses.count > 0 or redefine_clauses.count > 0
			or select_clauses.count > 0 or export_clauses.count > 0 then
				Result.append (dictionary.Tab)
				Result.append (dictionary.Tab)
				Result.append (Dictionary.End_keyword)
				Result.append (Dictionary.New_line)
			end
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is attribute ready to be generated?
		do
			Result := True
		end

feature -- Status Setting Inheritance Clauses

	add_rename_clause (a_clause: ECDP_RENAME_CLAUSE) is
			-- Add `a_clause' to `inheritance_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			rename_clauses.extend (a_clause)
		ensure
			rename_clause_added: rename_clauses.has (a_clause)
		end

	add_undefine_clause (a_clause: ECDP_UNDEFINE_CLAUSE) is
			-- Add `a_clause' to `inheritance_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			undefine_clauses.extend (a_clause)
		ensure
			undefine_clause_added: undefine_clauses.has (a_clause)
		end

	add_redefine_clause (a_clause: ECDP_REDEFINE_CLAUSE) is
			-- Add `a_clause' to `inheritance_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			redefine_clauses.extend (a_clause)
		ensure
			redefine_clause_added: redefine_clauses.has (a_clause)
		end

	add_select_clause (a_clause: ECDP_SELECT_CLAUSE) is
			-- Add `a_clause' to `inheritance_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			select_clauses.extend (a_clause)
		ensure
			select_clause_added: select_clauses.has (a_clause)
		end

	add_export_clause (a_clause: ECDP_EXPORT_CLAUSE) is
			-- Add `a_clause' to `inheritance_clauses' for parent `a_parent'.
		require
			non_void_inheritance_clause: a_clause /= Void
		do
			export_clauses.extend (a_clause)
		ensure
			export_clause_added: export_clauses.has (a_clause)
		end

feature {NONE} -- Implementation
	
	generate_clauses (a_list: LINKED_LIST [ECDP_INHERITANCE_CLAUSE]; keyword: STRING): STRING is
			-- 
		require
			a_list_internalt: a_list = rename_clauses or a_list = undefine_clauses or a_list = redefine_clauses or a_list = select_clauses or a_list = export_clauses
			keword: keyword = Dictionary.Rename_keyword or keyword = Dictionary.Undefine_keyword or keyword = Dictionary.Redefine_keyword or keyword = Dictionary.Select_keyword or keyword = Dictionary.Export_keyword
		local
			first_element: BOOLEAN
		do
			create Result.make (120)
					
			from
				a_list.start
				first_element := True
			until
				a_list.after
			loop
				if first_element then
					Result.append (dictionary.Tab)
					Result.append (dictionary.Tab)
					Result.append (keyword)
					Result.append (dictionary.New_line)
					first_element := False
				else
					Result.append (Dictionary.Comma)
					Result.append (Dictionary.New_line)
				end
				Result.append (dictionary.Tab)
				Result.append (dictionary.Tab)
				Result.append (dictionary.Tab)
				Result.append (a_list.item.code)
				a_list.forth
			end
			if not first_element then
				Result.append (Dictionary.New_line)
			end
		end

invariant
	non_void_name: name /= Void

end -- class ECDP_PARENT

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