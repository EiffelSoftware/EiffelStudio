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
		end

create
	make

feature {NONE} -- Initialization

	make (a_routine: like routine; a_name: like implementation_feature_name) is
			-- Initialize instance.
		require
			non_void_routine: a_routine /= Void
			non_void_name: a_name /= Void
		do
			routine := a_routine
			implementation_feature_name := a_name
		ensure
			routine_set: routine = a_routine
			name_set: implementation_feature_name = a_name
		end

feature -- Access

	routine: CODE_ROUTINE
			-- Routine containing try/catch statement

	implementation_feature_name: STRING
			-- Implementation feature name

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
			l_locals: LIST [CODE_VARIABLE]
		do
			create Result.make (100)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append (Indent_string)
			Result.append (implementation_feature_name)
			l_locals := routine.locals
			l_arguments := routine.arguments
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
				Result.append (")")
				Result.append (Line_return)
			end
		end

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end

invariant
	non_void_routine: routine /= Void
	non_void_implementation_feature_name: implementation_feature_name /= Void

end -- class CODE_TRY_CATCH_FINALLY_STATEMENT_STATEMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
