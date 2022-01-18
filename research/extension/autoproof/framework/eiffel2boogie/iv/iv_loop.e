class
	IV_LOOP

inherit

	IV_STATEMENT

create
	make_until,
	make_until_body

feature {NONE} -- Initialization

	make_until (a_condition: IV_EXPRESSION)
			-- Initialize until loop with condition `a_condition'
			-- and empty loop body.
		require
			a_condition_attached: attached a_condition
			a_condition_valid: a_condition.type.is_boolean
		do
			condition := a_condition
			create body.make
			create invariants.make
			create variants.make
		ensure
			condition_set: condition = a_condition
			until_loop: is_until_loop
		end

	make_until_body (a_condition: IV_EXPRESSION; a_body: IV_BLOCK)
			-- Initialize until loop with condition `a_condition'
			-- and loop body `a_body'.
		require
			a_condition_attached: attached a_condition
			a_condition_valid: a_condition.type.is_boolean
			a_body_attached: attached a_body
		do
			condition := a_condition
			body := a_body
			create invariants.make
			create variants.make
		ensure
			condition_set: condition = a_condition
			body_set: body = a_body
			until_loop: is_until_loop
		end

feature -- Status report

	is_until_loop: BOOLEAN = True
			-- Is this an until loop?

	is_while_loop: BOOLEAN = False
			-- Is this a while loop?

feature -- Access

	condition: IV_EXPRESSION
			-- Loop condition.

	invariants: LINKED_LIST [IV_EXPRESSION]
			-- List of invariants.

	variants: LINKED_LIST [IV_EXPRESSION]
			-- List of variants.

	body: IV_BLOCK
			-- Loop body.

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_loop (Current)
		end

invariant
	condition_attached: attached condition
	condition_valid: condition.type.is_boolean
	body_attached: attached body
	valid_loop_type: is_until_loop xor is_while_loop
	invariants_attached: attached invariants
	invarianst_valid: across invariants as i all i.type.is_boolean end
	variants_attached: attached variants
	variants_valid: across variants as i all i.type.is_integer end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
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
