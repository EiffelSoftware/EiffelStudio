indexing
	description: "Code generator for exception statements"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_EXCEPTION_STATEMENT_FACTORY

inherit
	ECDP_STATEMENT_FACTORY

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_try_catch_finally_statement (a_source: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Create instance of `EG_TRY_CATCH_FINALLY_STATEMENT'.
			-- | And iniatilize this instance with `a_source' -> Call `initialize_try_catch_finally_statement'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT
		do
			create a_try_catch_statement.make
			initialize_try_catch_finally_statement (a_source, a_try_catch_statement)
			set_last_statement (a_try_catch_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			try_catch_finally_statement_ready: last_statement.ready
		end
		
feature {NONE} -- Implementation
		
	initialize_try_catch_finally_statement (a_source: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT; a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Call `generate_try_statements' if any.
			-- | Call `generate_finally_statements' if any.
			-- | Call `generate_catch_clauses' if any.
			-- | Add BOOLEAN local variable `not_first_try' in `current_feature'.
			-- | If `current_type' is Void, generate only try statements???

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_routine: current_routine /= Void
			non_void_try_catch_statement: a_try_catch_statement /= Void
		local
			a_local_variable: ECDP_VARIABLE_DECLARATION_STATEMENT
			a_event_manager: ECDP_EVENT_MANAGER
		do
			a_event_manager.raise_event (feature {ECDP_EVENTS_IDS}.Not_implemented, ["try catch finally statement"])
			generate_try_statements (a_source, a_try_catch_statement)
			generate_finally_statements (a_source, a_try_catch_statement)
			generate_catch_clauses (a_source, a_try_catch_statement)
			
			if current_routine /= Void then
				a_local_variable.set_name ("not_first_try")
				a_local_variable.set_eiffel_type ("BOOLEAN")
				current_routine.add_local (a_local_variable)
			end
			if current_type = Void then
				-- TO BE DONE.......
			end
		ensure
			try_catch_finally_statement_ready: a_try_catch_statement.ready
		end
	
	generate_try_statements (a_source: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT; a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate try statements.
		require
			non_void_source: a_source /= Void
			non_void_try_catch_statement: a_try_catch_statement /= Void
			not_empty_try_statements: a_source.try_statements.count > 0
		local
			i: INTEGER
			try_catch_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			l_try_catch_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			try_catch_statements := a_source.finally_statements
			from
			until
				try_catch_statements = Void or else
				i = try_catch_statements.count
			loop
				l_try_catch_statement := try_catch_statements.item (i)
				if a_try_catch_statement /= Void then
					code_dom_generator.generate_statement_from_dom (l_try_catch_statement)
					a_try_catch_statement.add_try_statement (last_statement)
				end
				i := i + 1
			end
		end
	
	generate_finally_statements (a_source: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT; a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate finally statements.
		require
			non_void_source: a_source /= Void
			non_void_try_catch_statement: a_try_catch_statement /= Void
			not_empty_finally_statements: a_source.finally_statements.count > 0
		local
			i: INTEGER
			finally_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			a_finally_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			finally_statements := a_source.finally_statements
			from
			until
				finally_statements = Void or else
				i = finally_statements.count
			loop
				a_finally_statement := finally_statements.item (i)
				if a_finally_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_finally_statement)
					a_try_catch_statement.add_finally_statement (last_statement)
				end
				i := i + 1
			end
		end	

	generate_catch_clauses (a_source: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT; a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Call in loop `generate_catch_clause'.

			-- Generate catch clauses.
		require
			non_void_source: a_source /= Void
			non_void_try_catch_statement: a_try_catch_statement /= Void
			not_empty_catch_clauses: a_source.catch_clauses.count > 0
		local
			i: INTEGER
			catch_clauses_statements: SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION
			a_catch_clauses_statement: SYSTEM_DLL_CODE_CATCH_CLAUSE
		do
			catch_clauses_statements := a_source.catch_clauses
			from
			until
				catch_clauses_statements = Void or else
				i = catch_clauses_statements.count
			loop
				a_catch_clauses_statement := catch_clauses_statements.item (i)
				if a_catch_clauses_statement /= Void then
					generate_catch_statements (a_catch_clauses_statement, a_try_catch_statement)
				end
				i := i + 1
			end
		end
		
	generate_catch_statements (a_source: SYSTEM_DLL_CODE_CATCH_CLAUSE; a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate catch statements from `a_source'.
		require
			non_void_source: a_source /= Void
			not_empty_statements: a_source.statements.count > 0
			non_void_try_catch_statement: a_try_catch_statement /= Void
		local
			i: INTEGER
			catch_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			a_catch_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			catch_statements := a_source.statements
			from
			until
				catch_statements = Void or else
				i = catch_statements.count
			loop
				a_catch_statement := catch_statements.item (i)
				if a_catch_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_catch_statement)
					a_try_catch_statement.add_catch_clause (last_statement) 
				end
				i := i + 1
			end
		end	
		
end -- class ECDP_EXCEPTION_STATEMENT_FACTORY

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