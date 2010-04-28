note
	description: "[
		A feature checker generator for evaluating expressions in the editor.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: ": 2009-10-07 11:40:56 -0700 (Wed, 07 Oct 2009) "
	revision: ": 81044 "

class
	ES_EXPRESSION_ANALYZER_FEATURE_CHECKER_GENERATOR

inherit
	ANY

	AST_FEATURE_CHECKER_GENERATOR
		rename
			init as make
		export
			{NONE} all
			{ANY} last_type
		redefine
			is_void_safe_call,
			set_routine_ids
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {AST_FEATURE_CHECKER_GENERATOR} -- Status report

	is_void_safe_call (a_class: CLASS_C): BOOLEAN
			-- <Precursor>
		do
				-- Ignore Void-Safety.
		end

feature -- Basic operations

	add_local (a_type: TYPE_A; a_id: READABLE_STRING_8)
			-- Adds a local declaration.
			--
			-- `a_type': Type of local declaration
			-- `a_id': Name of local entity.
		require
			a_type_attached: a_type /= Void
			a_type_is_valid: a_type.is_valid
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		local
			l_local: LOCAL_INFO
			l_id: INTEGER
			l_key: STRING
		do
			create l_local
			l_local.set_position (context.locals.count + 1)
			l_local.set_type (a_type)
			l_id := names_heap.id_of (a_id.string)
			if l_id = 0 then
				names_heap.put (a_id.string)
				l_id := names_heap.found_item
			end
			context.locals.extend (l_local, l_id)
		end

	evaluate_expression (a_expr: EXPR_AS)
			-- Evaluates the expression AST node.
			--
			-- `a_expr': Expression to evaluate.
		require
			a_expr_attached: a_expr /= Void
		do
			--reset_types

			-- Most context initialiation should go into here, and pass the locals via an argument.

			context.set_is_ignoring_export (True)
--Note (jfiat): should we add the following commented line?
--			context.init_attribute_scopes
			context.init_local_scopes
			current_feature := context.current_feature
			a_expr.process (Current)
		end

feature {INSPECT_CONTROL} -- AST modification

	set_routine_ids (ids: ID_SET; a: ID_SET_ACCESSOR)
			-- <Precursor/>
			--| Redefined to avoid doing the `touch' for expression evaluation
		do
			if not ids.is_equal_id_list (a) then
				a.set_id_set (ids)
--					-- Record that AST node is modified.
--				tmp_ast_server.touch (context.current_class.class_id)
				is_ast_modified := True
			end
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
