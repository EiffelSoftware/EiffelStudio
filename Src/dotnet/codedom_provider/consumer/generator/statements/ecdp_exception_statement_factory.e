indexing
	-- Code code_generator for statements

class
	ECDP_EXCEPTION_STATEMENT_FACTORY

inherit
	ECDP_STATEMENT_FACTORY

create
	make

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

--	generate_throw_exception_statement (a_source: ECDP_CODE_DOM_THROW_EXCEPTION_STATEMENT) is
--			-- | Create instance of `EG_THROW_EXCEPTION_STATEMENT'.
--			-- | Set `last_statement'.
--			-- | Call `private_generate_throw_exception_statement'.
--			-- | NOT SUPPORTED YET !!
--
--			-- Generate Eiffel code from `a_source'."
--			-- GenerateThrowExceptionStatement"
--		require
--			non_void_source: a_source /= Void
--		do
--		ensure
--			non_void_last_statement: last_statement /= Void
--			throw_exception_statement_ready: last_statement.ready
--		end

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

--	private_generate_throw_exception_statement (a_source: ECDP_CODE_DOM_THROW_EXCEPTION_STATEMENT) is
--			-- | NOT SUPPORTED YET !!
--
--			-- Generate Eiffel code from `a_source'."
--			-- PrivateGenerateThrowExceptionStatement"
--		require
--			non_void_source: a_source /= Void
--			non_void_last_statement: last_statement /= Void
--		do
--		ensure
--			throw_exception_statement_ready: last_statement.ready
--		end	
		
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
				--	generate_catch_clause (a_catch_clauses_statement, a_try_catch_statement)
					generate_catch_statements (a_catch_clauses_statement, a_try_catch_statement)
				end
				i := i + 1
			end
		end

--	generate_catch_clause (a_source: SYSTEM_DLL_CODE_CATCH_CLAUSE; a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT) is
--			-- | Set `exception_type' by using `eg_generated_types' if already built, else build `EG_TYPE'.
--			-- | Call `generate_catch_statements' if any.
--
--			-- Generate catch clause from `a_source'.
--		require
--			non_void_source: a_source /= Void
--			non_void_try_catch_statement: a_try_catch_statement /= Void
--		local
--			a_catch_clause: ECDP_CATCH_CLAUSE
--			a_catch_clause_name: STRING
--		do
--			create a_catch_clause.make
--			create a_catch_clause_name.make_from_cil (a_source.base_type)
--			add_external_type_to_eg_types (a_catch_clause_name)
--			a_catch_clause.set_exception_type (a_catch_clause_name.hash_code)
--			generate_catch_statements (a_source, a_catch_clause, a_try_catch_statement)
--		ensure
----			no_catch_statement_implies_catch_statements_generated: a_source.statements.count = 0 implies catch_statements_generated
----			catch_clause_generated: catch_clause_generated
--		end
		
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
