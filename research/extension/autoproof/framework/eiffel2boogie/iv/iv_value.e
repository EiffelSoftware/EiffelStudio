note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_VALUE

inherit

	IV_EXPRESSION
		redefine
			is_false,
			is_true
		end

create
	make

feature {NONE} -- Initialization

	make (a_value: STRING; a_type: IV_TYPE)
			-- Initialize with value `a_value' of type `a_type'.
		do
			value := a_value.twin
			type := a_type
		ensure
			value_set: value ~ a_value
			type_set: type = a_type
		end

feature -- Access

	value: STRING
			-- Value expressed as a string.

	type: IV_TYPE
			-- Type of value.

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of subexpressions of `Current' which are valid triggers for a bound variable `a_bound_var'.
		do
			create Result.make (3)
		end

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.	
		do
			Result := [Current, create {ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]}.make (3)]
		end

feature -- Status report			

	is_false: BOOLEAN
			-- Is this expression literal "false"?
		do
			Result := value ~ "false"
		end

	is_true: BOOLEAN
			-- Is this expression literal "true"?
		do
			Result := value ~ "true"
		end

	has_free_var_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		do
			Result := attached {IV_VALUE} a_other as val and then value ~ val.value
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_value (Current)
		end

invariant
	value_attached: attached value

end
