indexing
	description: "Eiffel representation of a CodeDom try catch finally statement"
	date: "$$"
	revision: "$$"		
	
class
	CODE_TRY_CATCH_FINALLY_STATEMENT

inherit
	CODE_STATEMENT

	CODE_SHARED_EMPTY_ENTITIES
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_try_statements, a_finally_statements: like try_statements; a_catch_clauses: like catch_clauses) is
			-- Initialize instance.
		do
			try_statements := a_try_statements
			finally_statements := a_finally_statements
			catch_clauses := a_catch_clauses
		ensure
			statements_set: try_statements = a_try_statements
			finally_statements_set: finally_statements = a_finally_statements
			catch_clauses_set: catch_clauses = a_catch_clauses
		end
		
feature -- Access

	try_statements: LIST [CODE_STATEMENT]
			-- Statements in try clause
			
	finally_statements: LIST [CODE_STATEMENT]
			-- Statements in finally clause
			
	catch_clauses: LIST [CODE_CATCH_CLAUSE]
			-- Catch clauses
						
	code: STRING is
			-- Eiffel code of try catch finally statement
			-- | Insert new routine with following code and calls routine:
			-- | 		local 
			-- |			l_retried: BOOLEAN
			-- |		do 
			-- |			if not l_retried then
			-- |				`try_statements'
			-- |			end
			-- |			`finally_statements'
			-- |		rescue
			-- |			`catch_clauses'
			-- |		end"
		local
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_locals: LIST [CODE_VARIABLE_DECLARATION_STATEMENT]
		do
			if current_routine /= Void then
				create Result.make (100)
				Result.append (Indent_string)
				Result.append (implementation_feature_name)
				l_locals := current_routine.locals
				l_arguments := current_routine.arguments
				if l_locals.count > 0 or l_arguments.count > 0 then
					Result.append (" (")
					from
						l_arguments.start
						if not l_arguments.after then
							Result.append (l_arguments.item.variable.eiffel_name)
							l_arguments.forth
						end
					until
						l_arguments.after
					loop
						Result.append (", ")
						Result.append (l_arguments.item.variable.eiffel_name)
						l_arguments.forth
					end
					from
						l_locals.start
						if not l_locals.after then
							Result.append (l_locals.item.variable.eiffel_name)
							l_locals.forth
						end
					until
						l_locals.after
					loop
						Result.append (", ")
						Result.append (l_locals.item.variable.eiffel_name)
						l_locals.forth
					end
					Result.append (")%N")
				end
				generate_implementation_feature
			end
		end
		
feature {NONE} -- Code Generation
		
	implementation_feature_name: STRING is
			-- Implementation feature name
		local
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_implementation_features: HASH_TABLE [CODE_FEATURE, STRING]
			i: INTEGER
			l_ok: BOOLEAN
		do
			if internal_feature_name = Void then
				create internal_feature_name.make (current_feature.eiffel_name.count + 5)
				internal_feature_name.append ("safe_")
				internal_feature_name.append (current_feature.eiffel_name)
				l_features := current_type.features
				l_implementation_features := current_type.implementation_features
				from
					l_ok := not l_features.has (internal_feature_name) and not l_implementation_features.has (internal_feature_name)
					if not l_ok then
						internal_feature_name.append ("_2")
						l_ok := not l_features.has (internal_feature_name) and not l_implementation_features.has (internal_feature_name)
					end
					i := 3
				until
					l_ok
				loop
					internal_feature_name.keep_head (internal_feature_name.last_index_of ('_', internal_feature_name.count))
					internal_feature_name.append (i.out)
					i := i + 1
					l_ok := not l_features.has (internal_feature_name) and not l_implementation_features.has (internal_feature_name)				
				end
			end
			Result := internal_feature_name
		ensure
			non_void_feature_name: Result /= Void
		end
		
	generate_implementation_feature is
				-- Generate implementation feature that actually implements the try/catch paradigm.
				-- Add the implementation feature to the currently generated type.
		require
			non_void_current_routine: current_routine /= Void
		local
			l_feature: CODE_SNIPPET_FEATURE
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_locals: LIST [CODE_VARIABLE_DECLARATION_STATEMENT]
			l_old_indent_string: STRING
			l_code: STRING
		do
			create l_code.make (500)
			l_code.append_character ('%T')
			l_code.append (implementation_feature_name)
			l_locals := current_routine.locals
			l_arguments := current_routine.arguments
			if l_locals.count > 0 or l_arguments.count > 0 then
				l_code.append (" (")
				from
					l_arguments.start
					if not l_arguments.after then
						l_code.append (l_arguments.item.variable.eiffel_name)
						l_code.append (": ")
						l_code.append (l_arguments.item.variable.type.eiffel_name)
						l_arguments.forth
					end
				until
					l_arguments.after
				loop
					l_code.append ("; ")
					l_code.append (l_arguments.item.variable.eiffel_name)
					l_code.append (": ")
					l_code.append (l_arguments.item.variable.type.eiffel_name)
					l_arguments.forth
				end
				from
					l_locals.start
					if not l_locals.after then
						l_code.append (l_locals.item.variable.eiffel_name)
						l_code.append (": ")
						l_code.append (l_locals.item.variable.type.eiffel_name)
						l_locals.forth
					end
				until
					l_locals.after
				loop
					l_code.append ("; ")
					l_code.append (l_locals.item.variable.eiffel_name)
					l_code.append (": ")
					l_code.append (l_locals.item.variable.type.eiffel_name)
					l_locals.forth
				end
				l_code.append_character (')')
			end
			l_code.append (" is%N")
			l_code.append ("%T%Tlocal%N")
			from
				catch_clauses.start
			until
				catch_clauses.after
			loop
				l_code.append ("%T%T%T")
				l_code.append (catch_clauses.item.variable.variable.eiffel_name)
				l_code.append (": ")
				l_code.append (catch_clauses.item.variable.variable.type.eiffel_name)
				l_code.append_character ('%N')
				catch_clauses.forth
			end
			l_code.append ("%T%T%Tl_retried: BOOLEAN%N")
			l_code.append ("%T%Tdo%N")
			l_code.append ("%T%T%Tif not l_retried then%N")
			l_old_indent_string := indent_string
			if try_statements /= Void then
				set_indent_string ("%T%T%T%T")
				from
					try_statements.start
				until
					try_statements.after
				loop
					l_code.append (try_statements.item.code)
					try_statements.forth
				end
			end
			l_code.append ("%T%T%Tend%N")
			if finally_statements /= Void then
				set_indent_string ("%T%T%T")
				from
					finally_statements.start
				until
					finally_statements.after
				loop
					l_code.append (finally_statements.item.code)
					finally_statements.forth
				end
			end
			l_code.append ("%T%Trescue%N")
			if catch_clauses /= Void then
				set_indent_string ("%T%T%T")
				from
					catch_clauses.start
				until
					catch_clauses.after
				loop
					l_code.append (catch_clauses.item.code)
					catch_clauses.forth
				end
			end
			l_code.append ("%T%Tend%N")
			set_indent_string (l_old_indent_string)
			create l_feature.make (implementation_feature_name, l_code)
			l_feature.set_feature_kind ("Support")
			l_feature.add_feature_clause (None_type_reference)
			current_type.add_implementation_feature (l_feature)
		end

feature {NONE} -- Private Access

	internal_feature_name: STRING
			-- Cached implementation feature name

invariant
	non_void_try_statements: try_statements /= Void
	non_void_finally_statements: finally_statements /= Void
	non_void_catch_clauses: catch_clauses /= Void
	
end -- class CODE_TRY_CATCH_FINALLY_STATEMENT_STATEMENT

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