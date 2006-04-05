indexing 
	description: "Source code generator for method invocation expressions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"
	
class
	CODE_ROUTINE_INVOKE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_routine: like routine; a_arguments: like arguments) is
			-- Initialize `routine' and `arguments'.
		require
			non_void_routine: a_routine /= Void
		do
			routine := a_routine
			arguments := a_arguments
		ensure
			routine_set: routine = a_routine
			arguments_set: arguments = a_arguments
		end
		
feature -- Access

	routine: CODE_REFERENCE_EXPRESSION
			-- Routine to invoke
			
	arguments: LIST [CODE_EXPRESSION] 
			-- Routine arguments
			
	code: STRING is
			-- | Result := "`routine'[ (`arguments',...)]"
			-- Eiffel code of routine invoke expression
		local
			l_argument: CODE_EXPRESSION
		do
			create Result.make (120)
			Result.append (routine.code)
			
			if arguments /= Void then
				from
					arguments.start
					if not arguments.after then
						l_argument := arguments.item
						if l_argument /= Void then
							Result.append (" (")
							Result.append (l_argument.code)
						end
						arguments.forth
					end
				until
					arguments.after
				loop
					l_argument := arguments.item
					if l_argument /= Void then
						Result.append (", ")
						Result.append (l_argument.code)
					end
					arguments.forth
				end
				if arguments.count > 0 then
					Result.append_character (')')
				end
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := routine.type
		end
		
invariant
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
end -- class CODE_ROUTINE_INVOKE_EXPRESSION

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