indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result.append (" is")
			Result.append (Line_return)
			Result.append ("%T%Tlocal")
			Result.append (Line_return)
			from
				catch_clauses.start
			until
				catch_clauses.after
			loop
				Result.append ("%T%T%T")
				Result.append (catch_clauses.item.variable.variable.eiffel_name)
				Result.append (": ")
				Result.append (catch_clauses.item.variable.variable.type.eiffel_name)
				Result.append (Line_return)
				catch_clauses.forth
			end
			Result.append ("%T%T%Tl_retried: BOOLEAN")
			Result.append (Line_return)
			Result.append ("%T%Tdo")
			Result.append (Line_return)
			Result.append ("%T%T%Tif not l_retried then")
			Result.append (Line_return)
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
			Result.append ("%T%T%Tend")
			Result.append (Line_return)
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
			Result.append ("%T%Trescue")
			Result.append (Line_return)
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
			Result.append ("%T%Tend")
			Result.append (Line_return)
			set_indent_string (l_old_indent_string)
		end

invariant
	non_void_name: name /= Void
	non_void_routine: routine /= Void

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
end -- class CODE_TRY_CATCH_IMPLEMENTATION_FEATURE

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