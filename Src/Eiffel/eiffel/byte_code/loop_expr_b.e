note
	description: "Byte node for a loop expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	LOOP_EXPR_B

inherit
	EXPR_B

create

	make

feature {NONE} -- Creation

	make (
		it: BYTE_LIST [BYTE_NODE];
		inv: detachable BYTE_LIST [BYTE_NODE];
		var: detachable VARIANT_B;
		exit: EXPR_B;
		expr: EXPR_B;
		is_all_variant: BOOLEAN;
		adv: BYTE_NODE
	)
				-- Create a loop expression byte node with the given parts.
		do
			iteration_code := it
			invariant_code := inv
			variant_code := var
			exit_condition_code := exit
			expression_code := expr
			is_all := is_all_variant
			advance_code := adv
		ensure
			iteration_code_set: iteration_code = it
			invariant_code_set: invariant_code = inv
			variant_code_set: variant_code = var
			exit_condition_code_set: exit_condition_code = exit
			expression_code_set: expression_code = expr
			is_all_set: is_all = is_all_variant
			advance_code_set: advance_code = adv
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
--			v.process_object_test_b (Current)
		end

feature -- Access

	iteration_code: BYTE_LIST [BYTE_NODE]
			-- Iteration code

	invariant_code: detachable BYTE_LIST [BYTE_NODE]
			-- Invariant code

	variant_code: detachable VARIANT_B
			-- Variant code

	exit_condition_code: EXPR_B
			-- Exit condition code

	expression_code: EXPR_B
			-- Expression code

	is_all: BOOLEAN
			-- Is it "all" variant of a loop expression?

	advance_code: BYTE_NODE
			-- Code to advance the loop

feature

	type: TYPE_A
			-- Expression type
		do
			Result := boolean_type
		end

feature -- C code generation

	used (r: REGISTRABLE): BOOLEAN
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			Result :=
				-- iteration_code.used (r) or else
				-- attached invariant_code as i and then i.used (r) or else
				attached variant_code as v and then v.used (r) or else
				exit_condition_code.used (r) or else
				expression_code.used (r)
				-- advance_code.used (r)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
