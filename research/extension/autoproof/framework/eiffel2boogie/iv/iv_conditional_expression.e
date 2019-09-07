note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_CONDITIONAL_EXPRESSION

inherit

	IV_EXPRESSION

create
	make_if_then_else

feature {NONE} -- Initialization

	make_if_then_else (a_condition: IV_EXPRESSION; a_then: IV_EXPRESSION; a_else: IV_EXPRESSION)
			-- Initialize conditional with condition `a_condition',
			-- then expression `a_then', and else expression `a_else'.
		require
			a_condition_attached: attached a_condition
			a_condition_valid: a_condition.type.is_boolean
			a_then_attached: attached a_then
			a_else_attached: attached a_else
			a_then_and_else_compatible: a_then.type ~ a_else.type
		do
			condition := a_condition
			then_expression := a_then
			else_expression := a_else
		ensure
			condition_set: condition = a_condition
			then_expression_set: then_expression = a_then
			else_expression_set: else_expression = a_else
		end

feature -- Access

	type: IV_TYPE
			-- <Precursor>
		do
			Result := then_expression.type
		end

	condition: IV_EXPRESSION
			-- Condition expression.

	then_expression: IV_EXPRESSION
			-- Block for then branch.

	else_expression: IV_EXPRESSION
			-- Block for else branch.

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of subexpressions of `Current' which are valid triggers for a bound variable `a_bound_var'.
		do
			Result := condition.triggers_for (a_bound_var)
			Result.append (then_expression.triggers_for (a_bound_var))
			Result.append (else_expression.triggers_for (a_bound_var))
		end

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.	
		local
			rc, rt, re: like with_simple_vars
		do
			rc := condition.with_simple_vars (a_bound_var)
			rt := then_expression.with_simple_vars (a_bound_var)
			re := else_expression.with_simple_vars (a_bound_var)
			rc.subst.append (rt.subst)
			rc.subst.append (re.subst)
			Result := [create {IV_CONDITIONAL_EXPRESSION}.make_if_then_else (rc.expr, rt.expr, re.expr), rc.subst]
		end

feature -- Status report

	has_free_var_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
			Result := condition.has_free_var_named (a_name) or
				then_expression.has_free_var_named (a_name) or
				else_expression.has_free_var_named (a_name)
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		do
			Result := attached {IV_CONDITIONAL_EXPRESSION} a_other as cond and then
				(condition.same_expression (cond.condition) and
				then_expression.same_expression (cond.then_expression) and
				else_expression.same_expression (cond.else_expression))
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_conditional_expression (Current)
		end

invariant
	condition_attached: attached condition
	condition_valid: condition.type.is_boolean
	then_expression_attached: attached then_expression
	else_expression_valid: attached else_expression
	expressions_compatible: then_expression.type ~ else_expression.type

end
