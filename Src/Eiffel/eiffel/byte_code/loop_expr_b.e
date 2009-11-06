note
	description: "Byte node for a loop expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	LOOP_EXPR_B

inherit
	EXPR_B
		redefine
			allocates_memory,
			calls_special_features,
			enlarged,
			has_call,
			has_gcable_variable,
			inlined_byte_code,
			optimized_byte_node,
			pre_inlined_code,
			size
		end

	SHARED_TYPES
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Creation

	make (
		it: BYTE_LIST [BYTE_NODE];
		inv: detachable BYTE_LIST [BYTE_NODE];
		var: detachable VARIANT_B;
		ie: EXPR_B;
		oe: detachable EXPR_B;
		expr: EXPR_B;
		is_all_variant: BOOLEAN;
		adv: BYTE_NODE
	)
				-- Create a loop expression byte node with the given parts.
		do
			iteration_code := it
			invariant_code := inv
			variant_code := var
			iteration_exit_condition_code := ie
			exit_condition_code := oe
			expression_code := expr
			is_all := is_all_variant
			advance_code := adv
		ensure
			iteration_code_set: iteration_code = it
			invariant_code_set: invariant_code = inv
			variant_code_set: variant_code = var
			iteration_exit_condition_code_set: iteration_exit_condition_code = ie
			exit_condition_code_set: exit_condition_code = oe
			expression_code_set: expression_code = expr
			is_all_set: is_all = is_all_variant
			advance_code_set: advance_code = adv
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_loop_expr_b (Current)
		end

feature -- Access

	iteration_code: BYTE_LIST [BYTE_NODE]
			-- Iteration code

	invariant_code: detachable BYTE_LIST [BYTE_NODE]
			-- Invariant code

	variant_code: detachable VARIANT_B
			-- Variant code

	iteration_exit_condition_code: EXPR_B
			-- Iteration exit condition code

	exit_condition_code: detachable EXPR_B
			-- Optional exit condition code

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

	enlarged: LOOP_EXPR_BL
			-- Enlarged current node
		do
			create Result.make (Current)
		end

	used (r: REGISTRABLE): BOOLEAN
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			Result :=
				-- iteration_code.used (r) or else
				-- attached invariant_code as i and then i.used (r) or else
				attached variant_code as v and then v.used (r) or else
				iteration_exit_condition_code.used (r) or else
				attached exit_condition_code as e and then e.used (r) or else
				expression_code.used (r)
				-- advance_code.used (r)
		end

feature -- Status report

	has_gcable_variable: BOOLEAN = True
			-- <Precursor>
			-- This expression cannot be expanded into an inline return.

	has_call: BOOLEAN = True
			-- <Precursor>
			-- Several calls are made during the execution of the loop.

	allocates_memory: BOOLEAN = True
			-- <Precursor>
			-- It might be that there is no creation in `new_cursor',
			-- but a general implementation allocates a new cursor.

feature -- Array optimization

	calls_special_features (array_desc: INTEGER_32): BOOLEAN
			-- <Precursor>
		do
			Result :=
				iteration_code.calls_special_features (array_desc) or else
				attached invariant_code as i and then i.calls_special_features (array_desc) or else
				attached variant_code as v and then v.calls_special_features (array_desc) or else
				iteration_exit_condition_code.calls_special_features (array_desc) or else
				attached exit_condition_code as e and then e.calls_special_features (array_desc) or else
				expression_code.calls_special_features (array_desc) or else
				advance_code.calls_special_features (array_desc)
		end

	optimized_byte_node: like Current
			-- <Precursor>
		do
			Result := Current
			iteration_code := iteration_code.optimized_byte_node
			if attached invariant_code as i then
				invariant_code := i.optimized_byte_node
			end
			if attached variant_code as v then
				variant_code := v.optimized_byte_node
			end
			iteration_exit_condition_code := iteration_exit_condition_code.optimized_byte_node
			if attached exit_condition_code as e then
				exit_condition_code := e.optimized_byte_node
			end
			expression_code := expression_code.optimized_byte_node
			advance_code := advance_code.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER_32
			-- <Precursor>
		do
			Result := 1 + iteration_code.size + iteration_exit_condition_code.size + expression_code.size + advance_code.size
			if attached invariant_code as i then
				Result := Result + i.size
			end
			if attached variant_code as v then
				Result := Result + v.size
			end
			if attached exit_condition_code as e then
				Result := Result + e.size
			end
		end

	pre_inlined_code: like Current
			-- <Precursor>
		do
			Result := Current
			iteration_code := iteration_code.pre_inlined_code
			if attached invariant_code as i then
				invariant_code := i.pre_inlined_code
			end
			if attached variant_code as v then
				variant_code := v.pre_inlined_code
			end
			iteration_exit_condition_code := iteration_exit_condition_code.pre_inlined_code
			if attached exit_condition_code as e then
				exit_condition_code := e.pre_inlined_code
			end
			expression_code := expression_code.pre_inlined_code
			advance_code := advance_code.pre_inlined_code
		end

	inlined_byte_code: like Current
			-- <Precursor>
		do
			Result := Current
			iteration_code := iteration_code.inlined_byte_code
			if attached invariant_code as i then
				invariant_code := i.inlined_byte_code
			end
			if attached variant_code as v then
				variant_code := v.inlined_byte_code
			end
			iteration_exit_condition_code := iteration_exit_condition_code.inlined_byte_code
			if attached exit_condition_code as e then
				exit_condition_code := e.inlined_byte_code
			end
			expression_code := expression_code.inlined_byte_code
			advance_code := advance_code.inlined_byte_code
		end

invariant
	iteration_code_attached: iteration_code /= Void
	iteration_exit_condition_code_attached: iteration_exit_condition_code /= Void
	expression_code_attached: expression_code /= Void
	advance_code_attached: advance_code /= Void
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
