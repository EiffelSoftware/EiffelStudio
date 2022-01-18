class
	E2B_INTERVAL_ACROSS_HANDLER

inherit
	E2B_ACROSS_HANDLER
		redefine
			domain,
			quantifier
		end

create
	make

feature -- Access

	domain: BIN_FREE_B
			-- <Precursor>	

	lower_bound: IV_EXPRESSION
			-- Lower bound of the interval.

	upper_bound: IV_EXPRESSION
			-- Upper bound of the interval.

feature -- Basic operations

	handle_call_item (a_feature: FEATURE_I)
			-- <Precursor>
		do
			expression_translator.set_last_expression (expression_translator.locals_map.item (bound_variable.position))
		end

	handle_call_cursor_index (a_feature: FEATURE_I)
			-- <Precursor>
		local
			l_binop1, l_binop2: IV_BINARY_OPERATION
		do
			create l_binop1.make (expression_translator.locals_map.item (bound_variable.position), "+", create {IV_VALUE}.make ("1", types.int), types.int)
			create l_binop2.make (l_binop1, "-", lower_bound, types.int)
			expression_translator.set_last_expression (l_binop2)
		end

	handle_call_after (a_feature: FEATURE_I)
			-- <Precursor>
		local
			l_binop: IV_BINARY_OPERATION
		do
			create l_binop.make (expression_translator.locals_map.item (bound_variable.position), ">", upper_bound, types.bool)
			expression_translator.set_last_expression (l_binop)
		end

	handle_call_forth (a_feature: FEATURE_I)
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	translate_domain
			-- <Precursor>
		do
			domain.left.process (expression_translator)
			lower_bound := expression_translator.last_expression
			domain.right.process (expression_translator)
			upper_bound := expression_translator.last_expression
		end

	bound_var_type: IV_TYPE
			-- <Precursor>
		once
			Result := types.int
		end

	quantifier (a_bound_var: IV_ENTITY; a_expr: IV_EXPRESSION; a_is_all: BOOLEAN): IV_QUANTIFIER
			-- Expression "quant a_bound_var :: a_expr", where quant depends on `scoped_expression'.
		local
			l_guard: IV_EXPRESSION
			l_res: TUPLE [expr: IV_EXPRESSION; subst: ARRAYED_LIST [TUPLE[var: IV_ENTITY; val: IV_EXPRESSION]]]
		do
			if options.is_arithmetic_extracted then
				l_guard := guard (a_bound_var)
				l_res := a_expr.with_simple_vars (a_bound_var)
				across l_res.subst as s loop
					l_guard := factory.and_ (l_guard, factory.equal (s.var, s.val))
				end

				if a_is_all then
					create {IV_FORALL} Result.make (factory.implies_ (l_guard, l_res.expr))
				else
					create {IV_EXISTS} Result.make (factory.and_ (l_guard, l_res.expr))
				end
				Result.add_bound_variable (a_bound_var)
				across l_res.subst as s loop
					Result.add_bound_variable (s.var)
				end
			else
				Result := Precursor (a_bound_var, a_expr, a_is_all)
			end
		end

	guard (a_bound_var: IV_ENTITY): IV_EXPRESSION
			-- <Precursor>
		do
			Result := factory.and_ (factory.less_equal (lower_bound, a_bound_var),
				factory.less_equal (a_bound_var, upper_bound))
		end

	add_triggers (a_quantifier: IV_QUANTIFIER)
			-- Add triggers to `a_quantifier' generated from the current across expression.
		do
			a_quantifier.add_restrictive_trigger
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
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
