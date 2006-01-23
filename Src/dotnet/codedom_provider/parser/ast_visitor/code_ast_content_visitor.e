indexing
	description: "AST content Visitor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
deferred class
	CODE_AST_CONTENT_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	CODE_USER_DATA_KEYS

feature {AST_YACC} -- Implementation

	process_routine_as (l_as: ROUTINE_AS) is
			-- Process `l_as'.
		local
			l_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD
		do
			l_current_routine ?= current_element
			check
				non_void_current_routine: l_current_routine /= Void
			end

				-- Add pre and post conditions in user_data.
			if l_as.has_precondition then
				-- l_current_routine.user_data.add (Precondition, l_as.preconditions)
				l_as.precondition.process (Visitor)
			end
			if l_as.has_postcondition then
				-- l_current_routine.user_data.add (Postcondition, l_as.postconditions)
				l_as.postcondition.process (Visitor)
			end
				-- Add rescue statements
			if l_as.has_rescue then
				-- l_current_routine.user_data.add (Retry_feature, l_as.rescue_clause)
				l_as.rescue_clauses.process (Visitor)
			end

				-- Add locals variables to statements
			if l_as.locals /= Void then
				from
					l_as.locals.start
					set_current_element (l_current_routine.statements)
				until
					l_as.locals.after
				loop
					l_as.locals.item.process (Visitor)
					l_as.locals.forth
				end
				pop_current_element (l_current_routine.statements)
			end
				-- Call process to add body statements.
			l_as.routine_body.process (Visitor)
		end

	process_constant_as (l_as: CONSTANT_AS) is
			-- Process `l_as'.
		do
			-- Do nothing.
			-- Work done in {AST_SKELETON_VISITOR}.`initialize_member_field'.
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- CODE_AST_CONTENT_VISITOR