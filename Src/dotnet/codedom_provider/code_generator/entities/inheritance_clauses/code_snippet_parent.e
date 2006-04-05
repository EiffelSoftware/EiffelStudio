indexing
	description: "Parents of an Eiffel class with corresponding inheritance clauses as declared in snippet code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	note: "We cannot use CODE_PARENT for snippets because it relies on CODE_TYPE_REFERENCE instances%
				%to identify parent clauses and in snippets we only have the Eiffel name of the type not the%
				%.NET name which is required to initialize an instance of CODE_TYPE_REFERENCE."

class
	CODE_SNIPPET_PARENT

inherit
	CODE_ENTITY

create
	make
	
feature -- Initialization

	make (a_type, a_generics: STRING; a_renames: like renames; a_exports: like exports;
			a_undefines: like undefines; a_redefines: like redefines; a_selects: like selects) is
			-- Set `type' with `a_type'
		require
			non_void_type: a_type /= Void
		do
			type := a_type.twin
			if a_generics /= Void then
				type.append (a_generics)
			end
			undefines := a_undefines
			redefines := a_redefines
			renames := a_renames
			exports := a_exports
			selects := a_selects
		ensure
			type_set: (a_generics = Void implies type.is_equal (a_type)) and
							(a_generics /= Void implies type.is_equal (a_type + a_generics))
		end
		
feature	-- Access

	type: STRING
			-- Associated type

	undefines: LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]
			-- Undefine inheritance clauses

	redefines: LIST [CODE_SNIPPET_REDEFINE_CLAUSE]
			-- Redefine inheritance clauses

	renames: LIST [CODE_SNIPPET_RENAME_CLAUSE]
			-- Rename inheritance clauses

	exports: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
			-- Export inheritance clauses

	selects: LIST [CODE_SNIPPET_SELECT_CLAUSE]
			-- Select inheritance clauses

	code: STRING is
			-- Code
		do
			create Result.make (1024)
			Result.append_character ('%T')
			Result.append (type)
			Result.append_character ('%N')
			Result.append (renames_code)
			Result.append (exports_code)
			Result.append (undefines_code)
			Result.append (redefines_code)
			Result.append (selects_code)
			if undefines /= Void or redefines /= Void or renames /= Void or exports /= Void then
				Result.append ("%T%Tend%N")
			end
			Result.append ("%N")
		end
	
	renames_code: STRING is
			-- Code for rename clauses
		local
			l_rename: CODE_SNIPPET_RENAME_CLAUSE
		do
			create Result.make (1024)
			if renames /= Void then
				Result.append ("%T%Trename%N")
				from
					renames.start
					if not renames.after then
						l_rename := renames.item
						Result.append ("%T%T%T")
						Result.append (l_rename.routine_name)
						Result.append (" as ")
						Result.append (l_rename.target_name)
						renames.forth
					end
				until
					renames.after
				loop
					Result.append (",%N")
					Result.append ("%T%T%T")
					Result.append (l_rename.routine_name)
					Result.append (" as ")
					Result.append (l_rename.target_name)
					renames.forth
				end
				Result.append_character ('%N')
			end
		ensure
			attached_code: Result /= Void
		end
		

	exports_code: STRING is
			-- Code for exports clauses
		local
			l_export: CODE_SNIPPET_EXPORT_CLAUSE
			l_types: LIST [STRING]
		do
			create Result.make (1024)
			if exports /= Void then
				Result.append ("%T%Texport%N")
				from
					exports.start
				until
					exports.after
				loop
					l_export := exports.item
					Result.append ("%T%T%T{")
					l_types := l_export.type_list
					from
						l_types.start
						if not l_types.after then
							Result.append (l_types.item)
							l_types.forth
						end
					until
						l_types.after
					loop
						Result.append (", ")
						Result.append (l_types.item)
						l_types.forth
					end
					Result.append ("} ")
					Result.append (l_export.routine_name)
					Result.append_character ('%N')
					exports.forth
				end
			end
		ensure
			attached_code: Result /= Void
		end
		
	undefines_code: STRING is
			-- Code for undefine clauses
		do
			Result := generic_code (undefines, "undefine")			
		ensure
			attached_code: Result /= Void
		end
	
	redefines_code: STRING is
			-- Code for redefine clauses
		do
			Result := generic_code (redefines, "redefine")			
		ensure
			attached_code: Result /= Void
		end
	
	selects_code: STRING is
			-- Code for select clauses
		do
			Result := generic_code (selects, "select")			
		ensure
			attached_code: Result /= Void
		end

feature -- Status Report

	is_empty: BOOLEAN is
			-- Are all clauses empty?
		do
			Result := renames = Void and exports = Void and undefines = Void and 
				redefines = Void and selects = Void
		end
		
feature {NONE} -- Implementation

	generic_code (a_clauses: LIST [CODE_SNIPPET_INHERITANCE_CLAUSE]; a_keyword: STRING): STRING is
			-- Generic inheritance clause code
		require
			non_void_keyword: a_keyword /= Void
		do
			create Result.make (1024)
			if a_clauses /= Void then
				Result.append ("%T%T")
				Result.append (a_keyword)
				from
					a_clauses.start
					if not a_clauses.after then
						Result.append ("%N%T%T%T")
						Result.append (a_clauses.item.routine_name)
						a_clauses.forth
					end	
				until
					a_clauses.after
				loop
					Result.append (",%N%T%T%T")
					Result.append (a_clauses.item.routine_name)
					a_clauses.forth
				end
				Result.append_character ('%N')
			end
		ensure
			attached_code: Result /= Void
		end
		
invariant
	non_void_type: type /= Void
	non_empty_renames_if_not_void: renames /= Void implies not renames.is_empty
	non_empty_exports_if_not_void: exports /= Void implies not exports.is_empty
	non_empty_undefines_if_not_void: undefines /= Void implies not undefines.is_empty
	non_empty_redefines_if_not_void: redefines /= Void implies not redefines.is_empty
	non_empty_selects_if_not_void: selects /= Void implies not selects.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CODE_SNIPPET_PARENT

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