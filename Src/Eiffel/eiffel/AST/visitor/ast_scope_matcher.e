note
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
			process_bin_and_as,
			process_bin_and_then_as,
			process_bin_eq_as,
			process_bin_free_as,
			process_bin_implies_as,
			process_bin_ne_as,
			process_bin_or_as,
			process_bin_or_else_as,
			process_converted_expr_as,
			process_expr_call_as,
			process_nested_expr_as,
			process_object_test_as,
			process_paran_as,
			process_un_free_as,
			process_un_not_as
		end

	SHARED_STATELESS_VISITOR
		export {NONE} all
		end

	SHARED_TYPES
		export {NONE} all
		end

feature {NONE} -- Initialization

	make (c: like context)
			-- Initialize Current
		require
			c_attached: c /= Void
		do
			context := c
			is_nested := True
		ensure
			context_set: context = c
		end

feature {AST_EIFFEL} -- Visitor pattern: boolean logic

	process_bin_and_as (a: BIN_AND_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `l_as' corresponds to the corresponding boolean operator.
			if a.class_id = boolean_type.class_id then
				process_conjunction (a.left, a.right)
			end
		end

	process_bin_and_then_as (a: BIN_AND_THEN_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `l_as' corresponds to the corresponding boolean operator.
			if a.class_id = boolean_type.class_id then
				process_semistrict_conjunction (a.left, a.right)
			end
		end

	process_bin_free_as (a: BIN_FREE_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `a` corresponds to a built-in boolean operator.
			if a.class_id = boolean_type.class_id then
				inspect boolean_type.base_class.feature_of_rout_id (a.first).feature_name_id
				when {PREDEFINED_NAMES}.conjuncted_name_id then
					process_conjunction (a.left, a.right)
				when {PREDEFINED_NAMES}.conjuncted_semistrict_name_id then
					process_semistrict_conjunction (a.left, a.right)
				when {PREDEFINED_NAMES}.disjuncted_name_id then
					process_disjunction (a.left, a.right)
				when {PREDEFINED_NAMES}.disjuncted_semistrict_name_id then
					process_semistrict_disjunction (a.left, a.right)
				when {PREDEFINED_NAMES}.implication_name_id then
					process_implication (a.left, a.right)
				else
						-- Non-built-in operator, nothing to do.
				end
			end
		end

	process_bin_implies_as (a: BIN_IMPLIES_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `l_as' corresponds to the corresponding boolean operator.
			if a.class_id = boolean_type.class_id then
				process_implication (a.left, a.right)
			end
		end

	process_bin_or_as (a: BIN_OR_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `a` corresponds to the boolean operator.
			if a.class_id = boolean_type.class_id then
				process_disjunction (a.left, a.right)
			end
		end

	process_bin_or_else_as (a: BIN_OR_ELSE_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `a` corresponds to the boolean operator.
			if a.class_id = boolean_type.class_id then
				process_semistrict_disjunction (a.left, a.right)
			end
		end

	process_expr_call_as (a: EXPR_CALL_AS)
			-- <Precursor>
		do
				-- Look for expressions of the form
				--     (something).negated
			a.call.process (Current)
		end

	process_nested_expr_as (a: NESTED_EXPR_AS)
			-- <Precursor>
		do
			if a.message.class_id = boolean_type.class_id then
				inspect a.message.feature_name.name_id
				when {PREDEFINED_NAMES}.conjuncted_name_id then
					if
						a.message.parameter_count = 1 and then
						attached a.message.parameters [1] as p
					then
						process_conjunction (a.target, p)
					end
				when {PREDEFINED_NAMES}.conjuncted_semistrict_name_id then
					if
						a.message.parameter_count = 1 and then
						attached a.message.parameters [1] as p
					then
						process_semistrict_conjunction (a.target, p)
					end
				when {PREDEFINED_NAMES}.disjuncted_name_id then
					if
						a.message.parameter_count = 1 and then
						attached a.message.parameters [1] as p
					then
						process_disjunction (a.target, p)
					end
				when {PREDEFINED_NAMES}.disjuncted_semistrict_name_id then
					if
						a.message.parameter_count = 1 and then
						attached a.message.parameters [1] as p
					then
						process_semistrict_disjunction (a.target, p)
					end
				when {PREDEFINED_NAMES}.implication_name_id then
					if
						a.message.parameter_count = 1 and then
						attached a.message.parameters [1] as p
					then
						process_implication (a.target, p)
					end
				when {PREDEFINED_NAMES}.negated_name_id then
					process_negation (a.target)
				else
						-- A call to some non-built-in feature.
				end
			end
		end

	process_un_free_as (a: UN_FREE_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `a' corresponds to the boolean operator.
			if
				a.class_id = boolean_type.class_id and then
				boolean_type.base_class.feature_of_rout_id (a.first).feature_name_id = {PREDEFINED_NAMES}.negated_name_id
			then
				process_negation (a.expr)
			end
		end

	process_un_not_as (a: UN_NOT_AS)
			-- <Precursor>
		do
				-- Apply the CAP only if `a' corresponds to the boolean operator.
			if a.class_id = boolean_type.class_id then
				process_negation (a.expr)
			end
		end

feature {NONE} -- Boolean connectives

	process_conjunction (l, r: EXPR_AS)
			-- Process conjunction with left-hand side `l` and right-hand side `r`.
		do
			if is_negated = is_negation_expected then
				if is_nested then
					l.process (Current)
				end
				r.process (Current)
			end
		end

	process_semistrict_conjunction (l, r: EXPR_AS)
			-- Process semistrict conjunction with left-hand side `l` and right-hand side `r`.
		do
			if is_negated = is_negation_expected then
				l.process (Current)
				r.process (Current)
			end
		end

	process_disjunction (l, r: EXPR_AS)
			-- Process disjunction with left-hand side `l` and right-hand side `r`.
		do
			if is_negated /= is_negation_expected then
				if is_nested then
					l.process (Current)
				end
				r.process (Current)
			end
		end

	process_semistrict_disjunction (l, r: EXPR_AS)
			-- Process semistrict disjunction with left-hand side `l` and right-hand side `r`.
		do
			if is_negated /= is_negation_expected then
				l.process (Current)
				r.process (Current)
			end
		end

	process_implication (l, r: EXPR_AS)
			-- Process implication with left-hand side `l` and right-hand side `r`.
		local
			old_is_nested: BOOLEAN
		do
				-- Apply the CAP only if `l_as' corresponds to the corresponding boolean operator.
			if is_negated /= is_negation_expected then
				old_is_nested := is_nested
				is_nested := True
				is_negated := not is_negated
				l.process (Current)
				is_negated := not is_negated
				r.process (Current)
				is_nested := old_is_nested
			end
		end

	process_negation (e: EXPR_AS)
			-- Process negation of expression `e`.
		do
				-- Boolean expression is negated.
			is_negated := not is_negated
			e.process (Current)
				-- Revert original status in case there are other voidness tests.
			is_negated := not is_negated
		end

feature {AST_EIFFEL} -- Visitor pattern: content

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

	process_converted_expr_as (l_as: CONVERTED_EXPR_AS)
		do
			l_as.expr.process (Current)
		end

	process_paran_as (l_as: PARAN_AS)
		local
			old_is_nested: BOOLEAN
		do
			old_is_nested := is_nested
			is_nested := True
			l_as.expr.process (Current)
			is_nested := old_is_nested
		end

feature {NONE} -- Check for void test

	process_object_test_as (l_as: OBJECT_TEST_AS)
		local
			expr: EXPR_AS
		do
			if is_negated = is_negation_expected then
				if l_as.name /= Void then
					add_object_test_scope (l_as.name)
				end
					-- Remove parentheses surrounding expression
				from
					expr := l_as.expression
				until
					not attached {PARAN_AS} expr as paran_as
				loop
					expr := paran_as.expr
				end
				if attached {EXPR_CALL_AS} expr as expr_call_as then
					if attached {ACCESS_INV_AS} expr_call_as.call as access_inv_as then
						add_access_scope (access_inv_as)
					end
				elseif attached {RESULT_AS} expr then
					add_result_scope
				end
			end
		end

	process_equality_as (equality_as: BINARY_AS)
		require
			equality_as_attached: equality_as /= Void
		local
			e: EXPR_AS
			left: EXPR_AS
			right: EXPR_AS
		do
			if is_negated = is_negation_expected then
					-- Remove parentheses surrounding left expression
				from
					left := equality_as.left
				until
					not attached {PARAN_AS} left as left_paran_as
				loop
					left := left_paran_as.expr
				end
					-- Remove parentheses surrounding right expression
				from
					right := equality_as.right
				until
					not attached {PARAN_AS} right as right_paran_as
				loop
					right := right_paran_as.expr
				end
					-- Check that one side of the equality expression is "Void".
				if attached {VOID_AS} left as v1 then
					e := right
				elseif attached {VOID_AS} right as v2 then
					e := left
				end
				if attached {EXPR_CALL_AS} e as expr_call_as then
					if attached {ACCESS_INV_AS} expr_call_as.call as access_inv_as then
						add_access_scope (access_inv_as)
					end
				elseif attached {RESULT_AS} e then
					add_result_scope
				end
			end
		end

feature -- Context manipulation

	add_scopes (a: AST_EIFFEL)
		require
			a_attached: a /= Void
		do
			is_negated := False
			a.process (Current)
		end

feature {NONE} -- Context

	context: AST_CONTEXT
			-- Associated AST context

	add_access_scope (a: ACCESS_INV_AS)
			-- Add scope for `a' if this is a recognized variable.
		require
			a_attached: a /= Void
		do
			if a.is_readonly then
				add_readonly_scope (a.feature_name.name_id)
			elseif a.is_local then
				add_local_scope (a.feature_name.name_id)
			elseif not a.is_tuple_access then
					-- It must be a feature.
				add_attribute_scope (a.feature_name.name_id)
			end
		end

	add_readonly_scope (id: INTEGER_32)
			-- Add scope of a non-void argument.
		do
			context.add_readonly_instruction_scope (id)
		end

	add_attribute_scope (id: INTEGER_32)
			-- Add scope of a non-void attribute.
		do
			context.add_attribute_instruction_scope (id)
		end

	add_local_scope (id: INTEGER_32)
			-- Add scope of a non-void local.
		do
			context.add_local_instruction_scope (id)
		end

	add_object_test_scope (id: ID_AS)
			-- Add scope of an object test local.
		require
			id_attached: id /= Void
		do
			context.add_object_test_instruction_scope (id)
		end

	add_result_scope
			-- Add scope of a non-void Result.
		do
			context.add_result_instruction_scope
		end

feature {NONE} -- Status report

	is_nested: BOOLEAN
			-- Is current expression nested, so that associativity rules
			-- should not be taken into account that is important for
			-- strict operators?

	is_negated: BOOLEAN
			-- Is last boolean expression negated?

	is_negation_expected: BOOLEAN
			-- Is negated value of a boolean expression expected?
		deferred
		end

invariant
	context_attached: context /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
