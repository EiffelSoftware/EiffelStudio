indexing
	description: "Parents of an Eiffel class with corresponding inheritance clauses as declared in snippet code"
	date: "$Date$"
	revision: "$Revision$"
	note: "We cannot use CODE_PARENT for snippets because it relies on CODE_TYPE_REFERENCE instances%
				%to identify parent clauses and in snippets we only have the Eiffel name of the type not the%
				%.NET name which is required to initialize an instance of CODE_TYPE_REFERENCE."

class
	CODE_SNIPPET_PARENT

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

invariant
	non_void_type: type /= Void

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