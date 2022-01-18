note
	description: "Translator for across expressions."

deferred class
	E2B_ACROSS_HANDLER

inherit

	E2B_SHARED_CONTEXT
		export {NONE} all end

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

feature {NONE} -- Initialization

	make (a_translator: E2B_EXPRESSION_TRANSLATOR; a_bound_var: OBJECT_TEST_LOCAL_B; a_domain: like domain; a_scoped_expr: LOOP_EXPR_B)
			-- Initialize handler for "across domain as a_bound_var _ a_scoped_expr end", using `a_translator'.
		do
			bound_variable := a_bound_var
			expression_translator := a_translator
			domain := a_domain
			scoped_expression := a_scoped_expr
		end

feature -- Access

	expression_translator: E2B_EXPRESSION_TRANSLATOR
			-- Expression translator for this handler.

	bound_variable: OBJECT_TEST_LOCAL_B
			-- The local variable of the across.			

	domain: EXPR_B
			-- The domain of the across.

	scoped_expression: LOOP_EXPR_B
			-- The inner expression of the across.

feature -- Basic operations

	handle_across_expression
			-- Handle across loop expression.
		local
			l_expression: IV_EXPRESSION
			l_bound_var: IV_ENTITY
			l_old_side_effect, l_new_side_effect: like expression_translator.side_effect
			l_assert: IV_ASSERT
		do
				-- Domain
			translate_domain

				-- Save old side effect
			l_old_side_effect := expression_translator.side_effect
			expression_translator.clear_side_effect
				-- Add bound variable to locals
			expression_translator.create_iterator (bound_var_type)
			l_bound_var := expression_translator.last_local
			expression_translator.locals_map.put (l_bound_var, bound_variable.position)
				-- Translate scoped expression
			scoped_expression.expression_code.process (expression_translator)
			l_expression := expression_translator.last_expression
				-- Remove bound variable from locals
			expression_translator.locals_map.remove (bound_variable.position)
				-- Restore old side effect
			l_new_side_effect := expression_translator.side_effect
			expression_translator.restore_side_effect (l_old_side_effect)

				-- Build quantifier
			expression_translator.set_last_expression (quantifier (l_bound_var, l_expression, scoped_expression.is_all))
			across
				l_new_side_effect as checks
			loop
				if attached {IV_ASSERT} checks as assert then
						-- It is a check
					if assert.expression.has_free_var_named (l_bound_var.name) then
						if attached {IV_BINARY_OPERATION} assert.expression as binop and then
							binop.operator ~ "==>"  and then
							not binop.right.has_free_var_named (l_bound_var.name) then
								-- It is an implication where the consequent does not contain the bound variable; do not include antecedents that do.
							if assert.is_free then
								create l_assert.make_assume (factory.implies_ (bound_conjuncts_removed (binop.left, l_bound_var), binop.right))
							else
								create l_assert.make (factory.implies_ (bound_conjuncts_removed (binop.left, l_bound_var), binop.right))
							end
						else
							if assert.is_free then
								create l_assert.make_assume (quantifier (l_bound_var, assert.expression, True))
							else
								create l_assert.make (quantifier (l_bound_var, assert.expression, True))
							end
						end
						l_assert.node_info.load (assert.node_info)
						expression_translator.side_effect.extend (l_assert)
					else
						expression_translator.side_effect.extend (assert)
					end
				end
			end
		end

	handle_call_item (a_feature: FEATURE_I)
			-- Handle call to `item'.
		deferred
		end

	handle_call_cursor_index (a_feature: FEATURE_I)
			-- Handle call to `item'.
		deferred
		end

	handle_call_after (a_feature: FEATURE_I)
			-- Handle call to `item'.
		deferred
		end

	handle_call_forth (a_feature: FEATURE_I)
			-- Handle call to `item'.
		deferred
		end

feature {NONE} -- Implementation

	quantifier (a_bound_var: IV_ENTITY; a_expr: IV_EXPRESSION; a_is_all: BOOLEAN): IV_QUANTIFIER
			-- Expression "quant a_bound_var :: a_expr", where quant depends on `scoped_expression'.
		local
			l_guard: IV_EXPRESSION
		do
			l_guard := guard (a_bound_var)
			if a_is_all then
				create {IV_FORALL} Result.make (factory.implies_ (l_guard, a_expr))
			else
				create {IV_EXISTS} Result.make (factory.and_ (l_guard, a_expr))
			end
			Result.add_bound_variable (a_bound_var)
			if options.is_generating_triggers and expression_translator.use_triggers then
				add_triggers (Result)
			end
		end

	translate_domain
			-- Translate `domain' and store relevant information.
		deferred
		end

	bound_var_type: IV_TYPE
			-- Type of the bound variable in Boogie.
		deferred
		end

	guard (a_bound_var: IV_ENTITY): IV_EXPRESSION
			-- Antecedent in the resulting quantifier, with bound variable `a_bound_var'.
		deferred
		end

	add_triggers (a_quantifier: IV_QUANTIFIER)
			-- Add triggers to `a_quantifier' generated from the current across expression.
		require
			single_variable: a_quantifier.bound_variables.count = 1
		deferred
		end

	bound_conjuncts_removed (a_expr: IV_EXPRESSION; a_bound_var: IV_ENTITY): IV_EXPRESSION
			-- Conjunction `a_expr' with all conjuncts that contain `a_bound_var' removed.
		do
			if attached {IV_BINARY_OPERATION} a_expr as binop and then binop.operator ~ "&&" then
				Result := factory.and_clean (bound_conjuncts_removed (binop.left, a_bound_var), bound_conjuncts_removed (binop.right, a_bound_var))
			elseif a_expr.has_free_var_named (a_bound_var.name) then
				Result := factory.true_
			else
				Result := a_expr
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
