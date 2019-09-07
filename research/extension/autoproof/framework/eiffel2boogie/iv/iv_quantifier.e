note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_QUANTIFIER

inherit

	IV_EXPRESSION

	IV_SHARED_TYPES

feature {NONE} -- Initialization

	make (a_expression: IV_EXPRESSION)
			-- Initialize quantifier with expression `a_expression'.
		require
			a_expression_attached: attached a_expression
			a_expression_valid: a_expression.type = types.bool
		do
			expression := a_expression
			create bound_variables.make
			create type_variables.make
			create triggers.make
		end

feature -- Access

	expression: IV_EXPRESSION
			-- Forall expression.

	type_variables: LINKED_LIST [STRING]
			-- List of bound type variables.

	bound_variables: LINKED_LIST [IV_ENTITY_DECLARATION]
			-- List of bound variables.

	triggers: LINKED_LIST [ARRAY [IV_EXPRESSION]]
			-- List of triggers.

	type: IV_TYPE
			-- <Precursor>
		once
			Result := types.bool
		end

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of subexpressions of `Current' which are valid triggers for a bound variable `a_bound_var'.
		do
			Result := expression.triggers_for (a_bound_var)
		end

feature -- Status report

	has_free_var_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
			Result := not (across bound_variables as i some i.item.name.same_string (a_name) end) and expression.has_free_var_named (a_name)
		end

feature -- Element change

	add_type_variable (a_name: STRING)
			-- Add a type variable with name `a_name'.
		do
			type_variables.extend (a_name)
		end

	add_bound_variable (a_var: IV_ENTITY)
			-- Add a bound variable with name `a_name' and type `a_type'.
		do
			bound_variables.extend (create {IV_ENTITY_DECLARATION}.make (a_var.name, a_var.type))
		end

	add_trigger (a_expr: IV_EXPRESSION)
			-- Add `a_expr' to triggers for this quantifier.
		require
			a_expr_attached: attached a_expr
		do
			triggers.extend (<< a_expr >>)
		end

	add_compound_trigger (a_trigger: ARRAY [IV_EXPRESSION])
			-- Add `a_trigger' to triggers for this quantifier.
		require
			a_expr_attached: attached a_trigger
		do
			triggers.extend (a_trigger)
		end

	add_restrictive_trigger
			-- Add a default (relatively restrictive) trigger derived from `expression'.
		require
			single_variable: bound_variables.count = 1
		local
			l_trigger: ARRAY [IV_EXPRESSION]
		do
			l_trigger := expression.triggers_for (bound_variables.first.entity).to_array
			if not l_trigger.is_empty then
				triggers.extend (l_trigger)
			end
		end

invariant
	expression_attached: attached expression
	expression_valid: expression.type ~ types.bool
	type_variables_attached: attached type_variables
	bound_variables_attached: attached bound_variables
	bound_variables_valid: across bound_variables as i all i.item.property = Void end
	type_valid: type ~ types.bool

end
