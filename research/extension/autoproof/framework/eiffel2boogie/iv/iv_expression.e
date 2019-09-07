note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_EXPRESSION

feature -- Access

	type: IV_TYPE
			-- Type of expression.
		deferred
		end

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of subexpressions of `Current' which are valid triggers for a bound variable `a_bound_var'.			
		deferred
		end

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.
		deferred
		end

feature -- Status report

	is_false: BOOLEAN
			-- Is this expression literal "false"?
		do
		end

	is_true: BOOLEAN
			-- Is this expression literal "true"?
		do
		end

	is_arithmetic: BOOLEAN
			-- Does this expression involeve arithmetic operators on the top level?
		do
		end

	has_free_var_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		deferred
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		deferred
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- Process `a_visitor'.
		deferred
		end

invariant
	type_attached: attached type

end
