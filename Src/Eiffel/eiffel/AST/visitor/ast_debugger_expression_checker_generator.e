indexing
	description: "Perform type checking for debugger's expression evaluator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR

inherit
	AST_FEATURE_CHECKER_GENERATOR
		redefine
			check_type
		end

feature {NONE} -- Implementation: type validation

	check_type (a_type: TYPE_AS) is
			-- Evaluate `a_type' into a TYPE_A instance if valid.
			-- If not valid, raise a compiler error and return Void.
		local
			l_type: TYPE_A
			l_vtct: VTCT
		do
				-- Convert TYPE_AS into TYPE_A.
			l_type := type_a_generator.evaluate_type (a_type, context.current_class)
				-- Perform simple check that TYPE_A is valid.
			if l_type = Void then
						-- Check validity of type declaration for static access
				create l_vtct
				l_vtct.set_class_name (a_type.dump)
				l_vtct.set_location (a_type.start_location)
				l_vtct.set_class (context.current_class)
				error_handler.insert_error (l_vtct)
				error_handler.raise_error
			else
				l_type := type_a_checker.check_and_solved (l_type, a_type)
				if is_inherited then
						-- We need to update `l_type' to the context of `context.current_class'.
					l_type := l_type.instantiation_in (context.current_class.actual_type, context.written_class.class_id)
				end
					-- Check validity of type declaration
				type_a_checker.check_type_validity (l_type, a_type)
			end
				-- Update `last_type' with found type.
			last_type := l_type
		end

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

end
