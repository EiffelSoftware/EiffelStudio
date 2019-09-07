note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_BINARY_OPERATION

inherit

	IV_EXPRESSION
		redefine
			is_arithmetic
		end

create
	make

feature {NONE} -- Initialization

	make (a_left: IV_EXPRESSION; a_operator: STRING; a_right: IV_EXPRESSION; a_type: IV_TYPE)
			-- Initialize binary operation.
		require
			a_left_attached: attached a_left
			a_operator_attached: attached a_operator
			a_operator_valid: True -- TODO
			a_right_attached: attached a_right
			a_type_valid: True -- TODO
		do
			left := a_left
			operator := a_operator.twin
			right := a_right
			type := a_type
		ensure
			left_set: left = a_left
			operator_set: operator ~ a_operator
			right_set: right = a_right
		end

feature -- Access

	type: IV_TYPE
			-- <Precursor>

	operator: STRING
			-- Operator represented as a string.

	left: IV_EXPRESSION
			-- Left expression.

	right: IV_EXPRESSION
			-- Right expression.

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of subexpressions of `Current' which are valid triggers for a bound variable `a_bound_var'.
		do
			Result := left.triggers_for (a_bound_var)
			Result.append (right.triggers_for (a_bound_var))
		end

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.	
		local
			rl, rr: like with_simple_vars
		do
			rl := left.with_simple_vars (a_bound_var)
			rr := right.with_simple_vars (a_bound_var)
			rl.subst.append (rr.subst)
			Result := [create {IV_BINARY_OPERATION}.make (rl.expr, operator, rr.expr, type), rl.subst]
		end

feature -- Status report

	is_arithmetic: BOOLEAN
			-- Does this expression involeve arithmetic operators on the top level?
		do
			Result := type.is_integer
		end

	has_free_var_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
			Result := left.has_free_var_named (a_name) or right.has_free_var_named (a_name)
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		do
			Result := attached {IV_BINARY_OPERATION} a_other as binop and then
				(operator ~ binop.operator and left.same_expression (binop.left) and right.same_expression (binop.right))
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_binary_operation (Current)
		end

invariant
	left_attached: attached left
	right_attached: attached right
	operator_attached: attached operator

end
