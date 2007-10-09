indexing
	description: "Detector of local scopes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AST_SCOPE_MATCHER

inherit
	AST_NULL_VISITOR
		redefine
			process_bin_eq_as,
			process_bin_ne_as,
			process_object_test_as,
			process_paran_as,
			process_un_not_as
		end

	SHARED_STATELESS_VISITOR
		export {NONE} all
		end

feature {AST_EIFFEL} -- Visitor pattern

	process_bin_eq_as (l_as: BIN_EQ_AS)
		do
				-- Boolean expression is negated, as we are looking for "/= Void" rather than for "= Void"
			is_negated := not is_negated
			process_equality_as (l_as)
				-- Revert original status in case there are other voidness tests
			is_negated := not is_negated
		end

	process_bin_ne_as (l_as: BIN_NE_AS)
		do
			process_equality_as (l_as)
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
		do
			if is_negated = is_negation_expected then
				context.add_object_test_scope (l_as.name.name_id)
			end
		end

	process_paran_as (l_as: PARAN_AS)
		do
			l_as.expr.process (Current)
		end

	process_un_not_as (l_as: UN_NOT_AS)
		do
				-- Boolean expression is negated
			is_negated := not is_negated
			l_as.expr.process (Current)
				-- Revert original status in case there are other voidness tests
			is_negated := not is_negated
		end

feature {NONE} -- Check for void test

	process_equality_as (equality_as: BINARY_AS)
		require
			equality_as_attached: equality_as /= Void
		local
			void_as: VOID_AS
			expr_call_as: EXPR_CALL_AS
			access_id_as: ACCESS_ID_AS
			id_as: ID_AS
		do
			if is_negated = is_negation_expected then
				void_as ?= equality_as.left
				if void_as /= Void then
					expr_call_as ?= equality_as.right
				else
					void_as ?= equality_as.right
					if void_as /= Void then
						expr_call_as ?= equality_as.left
					end
				end
				if expr_call_as /= Void then
					access_id_as ?= expr_call_as.call
					if access_id_as /= Void then
						id_as ?= access_id_as.feature_name
						if id_as /= Void and then context.current_feature.argument_position (id_as.name_id) /= 0 then
							context.add_argument_scope (id_as.name_id)
						end
					end
				end
			end
		end

feature -- Context manipulation

	add_scopes (a: AST_EIFFEL; c: AST_CONTEXT)
		require
			a_attached: a /= Void
			c_attached: c /= Void
		do
			context := c
			is_negated := False
			a.process (Current)
		end

feature {NONE} -- Context

	context: AST_CONTEXT
			-- Associated AST context

feature {NONE} -- Status

	is_negated: BOOLEAN
			-- Is last boolean expression negated?

	is_negation_expected: BOOLEAN
			-- Is negated value of a boolean expression expected?
		deferred
		end

invariant
	context_attached: context /= Void

indexing
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
