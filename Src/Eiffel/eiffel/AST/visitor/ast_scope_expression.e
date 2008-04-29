indexing
	description: "Detector of local scopes for an associative expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_SCOPE_EXPRESSION

inherit
	AST_SCOPE_MATCHER
		redefine
			add_argument_scope,
			add_local_scope,
			add_object_test_scope,
			add_result_scope,
			process_paran_as
		end

feature {AST_EIFFEL} -- Visitor pattern

	process_paran_as (l_as: PARAN_AS)
		local
			old_is_nested: BOOLEAN
		do
			old_is_nested := is_nested
			is_nested := True
			Precursor (l_as)
			is_nested := old_is_nested
		end

feature {NONE} -- Status report

	is_nested: BOOLEAN
			-- Is current expression nested, so that associativity rules
			-- should not be taken into account that is important for
			-- strict operators?

feature {NONE} -- Context

	add_argument_scope (id: INTEGER_32)
			-- Add scope of a non-void argument.
		do
			context.add_argument_expression_scope (id)
		end

	add_local_scope (id: INTEGER_32)
			-- Add scope of a non-void local.
		do
			context.add_local_expression_scope (id)
		end

	add_object_test_scope (id: INTEGER_32)
			-- Add scope of an object test.
		do
			context.add_object_test_expression_scope (id)
		end

	add_result_scope
			-- Add scope of a non-void Result.
		do
			context.add_result_expression_scope
		end

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
