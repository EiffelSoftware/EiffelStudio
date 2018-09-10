note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_ENTITY

inherit

	IV_EXPRESSION

inherit {NONE}

	IV_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_type: IV_TYPE)
			-- Initialize with name `a_name' and type `a_type'.
		require
			a_name_valid: is_valid_name (a_name)
		do
			name := a_name.twin
			type := a_type
		ensure
			name_set: name ~ a_name
			type_set: type = a_type
		end

feature -- Access

	name: STRING
			-- Name of entity.

	type: IV_TYPE
			-- Type of entity.

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

	has_free_var_named (a_name: STRING): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
			Result := name ~ a_name
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		do
			Result := attached {IV_ENTITY} a_other as e and then e.name ~ name
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_entity (Current)
		end

invariant
	valid_name: is_valid_name (name)

end
