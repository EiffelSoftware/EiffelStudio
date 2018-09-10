note
	description: "Map update expression."
	date: "$Date$"
	revision: "$Revision$"

class
	IV_MAP_UPDATE

inherit
	IV_EXPRESSION

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

create
	make

feature {NONE} -- Implementation

	make (a_target: IV_EXPRESSION; a_indexes: ARRAY [IV_EXPRESSION]; a_value: IV_EXPRESSION)
			-- Make map update of `a_target' at index `a_indexes' with `a_value'.
		require
			a_target_attached: attached a_target
			a_target_valid: attached {IV_MAP_TYPE} a_target.type as t and then t.domain_types.count = a_indexes.count
			a_indexes_attached: attached a_indexes and then across a_indexes as i all attached i.item end
			a_value_attached: attached a_value
		do
			target := a_target
			indexes := a_indexes
			value := a_value
		ensure
			target_set: target = a_target
			indexes_set: indexes = a_indexes
			value_set: value = a_value
		end

feature -- Access

	target: IV_EXPRESSION
			-- Target.

	indexes: ARRAY [IV_EXPRESSION]
			-- Indexes.

	value: IV_EXPRESSION
			-- New value.

	type: IV_TYPE
			-- Type of map access.
		do
			Result := target.type
		end

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of smallest subexpressions of `Current' with a valid triggers for a bound variable `a_bound_var'.
			-- If one of the indexes/value is `a_bound_var', use the whole map update; other combine triggers for all indexes/value.
		do
			create Result.make (3)
			if across indexes as i some i.item.same_expression (a_bound_var) end or value.same_expression (a_bound_var) then
				Result.extend (Current)
			else
				across indexes as i loop
					Result.append (i.item.triggers_for (a_bound_var))
				end
				Result.append (value.triggers_for (a_bound_var))
			end
		end

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.	
		local
			l_indexes: like indexes
			l_res, l_res_value: like with_simple_vars
			l_fresh_var: IV_ENTITY
			l_subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]
		do
			create l_indexes.make (indexes.lower, indexes.upper)
			create l_subst.make (3)
			across
				indexes as i
			loop
				l_res := i.item.with_simple_vars (a_bound_var)
				l_subst.append (l_res.subst) -- Preserve substitution that happened in the argument
				if i.item.is_arithmetic and i.item.has_free_var_named (a_bound_var.name) then
					-- Argument is a nontrivial expression with a bound variable: replace with a fresh bound variable
					l_fresh_var := factory.unique_entity (a_bound_var.name, l_res.expr.type)
					l_indexes [i.target_index] := l_fresh_var
					l_subst.extend ([l_fresh_var, l_res.expr])
				else
					-- No substitution
					l_indexes [i.target_index] := l_res.expr
				end
			end
			l_res := target.with_simple_vars (a_bound_var)
			l_subst.append (l_res.subst)
			l_res_value := value.with_simple_vars (a_bound_var)
			l_subst.append (l_res_value.subst)
			Result := [create {like Current}.make (l_res.expr, l_indexes, l_res_value.expr), l_subst]
		end

feature -- Status report

	has_free_var_named (a_name: STRING): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
			Result := target.has_free_var_named (a_name) or
				across indexes as i some i.item.has_free_var_named (a_name) end or
				value.has_free_var_named (a_name)
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		do
			Result := attached {IV_MAP_UPDATE} a_other as m and then
				(target.same_expression (m.target) and
				indexes.count = m.indexes.count and
				across 1 |..| indexes.count as i all indexes [i.item].same_expression (m.indexes [i.item]) end and
				value.same_expression (m.value))
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_map_update (Current)
		end

invariant
	target_attached: attached target
	indexes_attached: attached indexes
	target_valid: attached {IV_MAP_TYPE} target.type as t and then t.domain_types.count = indexes.count
	indexes_nonempty: not indexes.is_empty
	value_attached: attached value

end
