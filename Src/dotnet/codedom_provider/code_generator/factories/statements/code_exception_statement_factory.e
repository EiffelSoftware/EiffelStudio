indexing
	description: "Code generator for exception statements"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EXCEPTION_STATEMENT_FACTORY

inherit
	CODE_STATEMENT_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_try_catch_finally_statement (a_source: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Create instance of `CODE_TRY_CATCH_FINALLY_STATEMENT'.
			-- | And iniatilize this instance with `a_source'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_catch_clauses: ARRAYED_LIST [CODE_CATCH_CLAUSE]
			l_source_catch_clauses: SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION
			i, l_count: INTEGER
			l_catch_clause: SYSTEM_DLL_CODE_CATCH_CLAUSE
		do
			l_source_catch_clauses := a_source.catch_clauses
			if l_source_catch_clauses /= Void then
				l_count := l_source_catch_clauses.count
				from
					create l_catch_clauses.make (l_count)
				until
					i = l_count
				loop
					l_catch_clause := l_source_catch_clauses.item (i)
					l_catch_clauses.extend (create {CODE_CATCH_CLAUSE}.make (create {CODE_VARIABLE_REFERENCE}.make (l_catch_clause.local_name, Type_reference_factory.type_reference_from_reference (l_catch_clause.catch_exception_type), Type_reference_factory.type_reference_from_code (current_type)), statements_from_collection (l_catch_clause.statements)))
					i := i + 1
				end
			end
			set_last_statement (create {CODE_TRY_CATCH_FINALLY_STATEMENT}.make (statements_from_collection (a_source.try_statements), statements_from_collection (a_source.finally_statements), l_catch_clauses))
		ensure
			non_void_last_statement: last_statement /= Void
		end
		
end -- class CODE_EXCEPTION_STATEMENT_FACTORY

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