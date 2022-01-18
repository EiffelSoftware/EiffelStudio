class
	IV_EXISTS

inherit

	IV_QUANTIFIER

create
	make

feature -- Access		

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.	
		local
			l_res: like with_simple_vars
			l_expr: IV_EXISTS
		do
			l_res := expression.with_simple_vars (a_bound_var)
			create l_expr.make (l_res.expr)
			l_expr.type_variables.append (type_variables)
			l_expr.bound_variables.append (bound_variables)
			l_expr.triggers.append (triggers)
			Result := [l_expr, l_res.subst]
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
			-- ToDo: this is not really correct, we should be comparing DeBrujn versions.
		do
			Result := attached {IV_EXISTS} a_other as q and then
				(expression.same_expression (q.expression) and
				bound_variables.count = q.bound_variables.count and
				across 1 |..| bound_variables.count as i all
					bound_variables [i].entity.same_expression (q.bound_variables [i].entity)
				end)
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_exists (Current)
		end

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
