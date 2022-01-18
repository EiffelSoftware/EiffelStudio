class
	IV_FUNCTION_CALL

inherit

	IV_EXPRESSION

inherit {NONE}

	IV_HELPER

	IV_SHARED_FACTORY

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8; a_type: IV_TYPE)
			-- Initialize function call with `a_name' and `a_type'.
		do
			name := a_name.twin
			type := a_type
			create arguments.make
		ensure
			name_set: name ~ a_name
			type_set: type = a_type
		end

feature -- Access

	name: READABLE_STRING_8
			-- Name of called function.

	arguments: LINKED_LIST [IV_EXPRESSION]
			-- Arguments of function call.

	type: IV_TYPE
			-- Type of function.

	triggers_for (a_bound_var: IV_ENTITY): ARRAYED_LIST [IV_EXPRESSION]
			-- List of smallest subexpressions of `Current' with a valid triggers for a bound variable `a_bound_var'.
			-- If one of the arguments is `a_bound_var', use the function call; other combine triggers for all arguments.
		do
			create Result.make (3)
			if across arguments as i some i.same_expression (a_bound_var) end then
				Result.extend (Current)
			else
				across arguments as i loop
					Result.append (i.triggers_for (a_bound_var))
				end
			end
		end

	with_simple_vars (a_bound_var: IV_ENTITY): TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
			-- Current expression with all occurrences of arithmetic expressions as function/map argumetns replaces with fresh variables;
			-- together with the corresponding variable substitution.	
		local
			l_fcall: like Current
			l_res_arg: like with_simple_vars
			l_fresh_var: IV_ENTITY
			l_subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]
		do
			create l_fcall.make (name, type)
			create l_subst.make (3)
			across
				arguments as i
			loop
				l_res_arg := i.with_simple_vars (a_bound_var)
				l_subst.append (l_res_arg.subst) -- Preserve substitution that happened in the argument
				if i.is_arithmetic and i.has_free_var_named (a_bound_var.name) then
					-- Argument is an arithmetic expression with a bound variable: replace with a fresh bound variable
					l_fresh_var := factory.unique_entity (a_bound_var.name, l_res_arg.expr.type)
					l_fcall.arguments.extend (l_fresh_var)
					l_subst.extend ([l_fresh_var, l_res_arg.expr])
				else
					-- No substitution
					l_fcall.arguments.extend (l_res_arg.expr)
				end
			end
			Result := [l_fcall, l_subst]
		end

feature -- Status report

	has_free_var_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Does this expression contain a free variable with name `a_name'?
		do
			Result := across arguments as i some i.has_free_var_named (a_name) end
		end

feature -- Comparison

	same_expression (a_other: IV_EXPRESSION): BOOLEAN
			-- Does this expression equal `a_other' (if considered in the same context)?
		do
			Result := attached {IV_FUNCTION_CALL} a_other as c and then
				(name ~ c.name and arguments.count = c.arguments.count and
				across 1 |..| arguments.count as i all arguments [i].same_expression (c.arguments [i]) end)
		end

feature -- Element change

	add_argument (a_argument: IV_EXPRESSION)
			-- Add argument `a_argument'.
		require
			a_argument_attached: attached a_argument
		do
			arguments.extend (a_argument)
		end

feature -- Visitor

	process (a_visitor: IV_EXPRESSION_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_function_call (Current)
		end

invariant
	name_valid: is_valid_name (name)
	arguments_attached: attached arguments
	arguments_valid: not arguments.has (Void)

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
