class
	IV_MAP_ACCESS

inherit

	IV_EXPRESSION

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

create
	make

feature {NONE} -- Implementation

	make (a_target: IV_EXPRESSION; a_indexes: like indexes)
			-- Make map access to `a_target' with index `a_indexes'.
		require
			a_target_attached: attached a_target
			a_target_valid: attached {IV_MAP_TYPE} a_target.type as t and then t.domain_types.count = a_indexes.count
			a_indexes_attached: attached a_indexes and then across a_indexes as i all attached i end
		do
			target := a_target
			indexes := a_indexes
		ensure
			target_set: target = a_target
			indexes_set: indexes = a_indexes
		end

feature -- Access

	target: IV_EXPRESSION
			-- Target.

	indexes: ARRAYED_LIST [IV_EXPRESSION]
			-- Indexes.

	type: IV_TYPE
			-- Type of map access.
		do
			check attached {IV_MAP_TYPE} target.type as map_type then
				-- ToDo: find most general unifier of domain types with index types and instantiate the range type
				-- For now a workaround: heap is the only map type with a polymorphic result we use
				if map_type ~ types.heap then
					check attached {IV_USER_TYPE} indexes [2].type as field_type then
						Result := field_type.parameters [1]
					end
				else
					Result := map_type.range_type
				end
			end
		end

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of smallest subexpressions of `Current' with a valid triggers for a bound variable `a_bound_var'.			
			-- If one of the indexes is `a_bound_var', use the function call; other combine triggers for all indexes.
		do
			create Result.make (3)
			if across indexes as i some i.same_expression (a_bound_var) end then
				Result.extend (Current)
			else
				across indexes as i loop
					Result.append (i.triggers_for (a_bound_var))
				end
			end
		end

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.	
		local
			l_indexes: like indexes
			l_res: like with_simple_vars
			l_fresh_var: IV_ENTITY
			l_subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]
		do
			create l_indexes.make (indexes.count)
			create l_subst.make (3)
			across
				indexes as i
			loop
				l_res := i.with_simple_vars (a_bound_var)
				l_subst.append (l_res.subst) -- Preserve substitution that happened in the argument
				if i.is_arithmetic and i.has_free_var_named (a_bound_var.name) then
					-- Argument is a nontrivial expression with a bound variable: replace with a fresh bound variable
					l_fresh_var := factory.unique_entity (a_bound_var.name, l_res.expr.type)
					l_indexes.extend (l_fresh_var)
					l_subst.extend ([l_fresh_var, l_res.expr])
				else
					-- No substitution
					l_indexes.extend (l_res.expr)
				end
			end
			l_res := target.with_simple_vars (a_bound_var)
			l_subst.append (l_res.subst)
			Result := [create {like Current}.make (l_res.expr, l_indexes), l_subst]
		end

feature -- Status report

	has_free_var_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
			Result := target.has_free_var_named (a_name) or
				across indexes as i some i.has_free_var_named (a_name) end
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		do
			Result := attached {IV_MAP_ACCESS} a_other as m and then
				(target.same_expression (m.target) and
				indexes.count = m.indexes.count and
				across 1 |..| indexes.count as i all indexes [i].same_expression (m.indexes [i]) end)
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_map_access (Current)
		end

invariant
	target_attached: attached target
	indexes_attached: attached indexes
	target_valid: attached {IV_MAP_TYPE} target.type as t and then t.domain_types.count = indexes.count
	indexes_nonempty: not indexes.is_empty

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
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
