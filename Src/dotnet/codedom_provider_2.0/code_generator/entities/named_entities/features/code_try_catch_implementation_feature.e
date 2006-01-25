indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TRY_CATCH_IMPLEMENTATION_FEATURE

inherit
	CODE_NAMED_ENTITY

create
	make

feature {NONE} -- Initialization

 make (a_name: like name; a_routine: like routine; a_catch_clauses: like catch_clauses; a_try_statements: like try_statements; a_finally_statements: like finally_statements) is
 		-- Initialize instance.
 	require
 		non_void_name: a_name /= Void
 		non_void_routine: a_routine /= Void
 	do
 		set_name (a_name)
 		routine := a_routine
 		catch_clauses := a_catch_clauses
 		try_statements := a_try_statements
 		finally_statements := a_finally_statements
 	ensure
 		name_set: name = a_name
 		routine_set: routine = a_routine
 		catch_clauses_set: catch_clauses = a_catch_clauses
 		try_statements_set: try_statements = a_try_statements
 		finally_statements_set: finally_statements = a_finally_statements
 	end
 	
feature -- Access

	routine: CODE_ROUTINE
			-- Routine which calls implementation feature

	catch_clauses: LIST [CODE_CATCH_CLAUSE]
			-- Catch clauses
	
	try_statements: LIST [CODE_STATEMENT]
			-- Try statements
	
	finally_statements: LIST [CODE_STATEMENT]
			-- Finally statements

	code: STRING is
			-- Generate implementation feature that actually implements the try/catch paradigm.
		local
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_locals: LIST [CODE_VARIABLE]
			l_old_indent_string: STRING
		do
			create Result.make (500)
			Result.append_character ('%T')
			Result.append (name)
			l_locals := routine.locals
			l_arguments := routine.arguments
			if l_locals.count > 0 or l_arguments.count > 0 then
				Result.append (" (")
				from
					l_arguments.start
					if not l_arguments.after then
						Result.append (l_arguments.item.variable.eiffel_name)
						Result.append (": ")
						Result.append (l_arguments.item.variable.type.eiffel_name)
						l_arguments.forth
					end
				until
					l_arguments.after
				loop
					Result.append ("; ")
					Result.append (l_arguments.item.variable.eiffel_name)
					Result.append (": ")
					Result.append (l_arguments.item.variable.type.eiffel_name)
					l_arguments.forth
				end
				from
					l_locals.start
					if not l_locals.after then
						Result.append (l_locals.item.variable.eiffel_name)
						Result.append (": ")
						Result.append (l_locals.item.variable.type.eiffel_name)
						l_locals.forth
					end
				until
					l_locals.after
				loop
					Result.append ("; ")
					Result.append (l_locals.item.variable.eiffel_name)
					Result.append (": ")
					Result.append (l_locals.item.variable.type.eiffel_name)
					l_locals.forth
				end
				Result.append_character (')')
			end
			Result.append (" is%N")
			Result.append ("%T%Tlocal%N")
			from
				catch_clauses.start
			until
				catch_clauses.after
			loop
				Result.append ("%T%T%T")
				Result.append (catch_clauses.item.variable.variable.eiffel_name)
				Result.append (": ")
				Result.append (catch_clauses.item.variable.variable.type.eiffel_name)
				Result.append_character ('%N')
				catch_clauses.forth
			end
			Result.append ("%T%T%Tl_retried: BOOLEAN%N")
			Result.append ("%T%Tdo%N")
			Result.append ("%T%T%Tif not l_retried then%N")
			l_old_indent_string := indent_string
			if try_statements /= Void then
				set_indent_string ("%T%T%T%T")
				from
					try_statements.start
				until
					try_statements.after
				loop
					Result.append (try_statements.item.code)
					try_statements.forth
				end
			end
			Result.append ("%T%T%Tend%N")
			if finally_statements /= Void then
				set_indent_string ("%T%T%T")
				from
					finally_statements.start
				until
					finally_statements.after
				loop
					Result.append (finally_statements.item.code)
					finally_statements.forth
				end
			end
			Result.append ("%T%Trescue%N")
			if catch_clauses /= Void then
				set_indent_string ("%T%T%T")
				from
					catch_clauses.start
				until
					catch_clauses.after
				loop
					Result.append (catch_clauses.item.code)
					catch_clauses.forth
				end
			end
			Result.append ("%T%Tend%N")
			set_indent_string (l_old_indent_string)
		end

invariant
	non_void_name: name /= Void
	non_void_routine: routine /= Void

end -- class CODE_TRY_CATCH_IMPLEMENTATION_FEATURE

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