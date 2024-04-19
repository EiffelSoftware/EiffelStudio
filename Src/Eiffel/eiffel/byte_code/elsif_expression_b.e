note
	description: "Byte code for conditional expression alternative."

class ELSIF_EXPRESSION_B

inherit
	EXPR_B
		redefine
			allocates_memory,
			analyze,
			calls_special_features,
			enlarge_tree,
			generate,
			has_call,
			has_gcable_variable,
			inlined_byte_code,
			is_unsafe,
			line_number,
			optimized_byte_node,
			pre_inlined_code,
			set_line_number,
			size,
			enlarged
		end

create
	make

feature {NONE}

	make (c: like condition; e: like expression)
		do
			condition := c
			expression := e
		ensure
			condition_set: condition = c
			expression_set: expression = e
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- <Precursor>
		do
			v.process_elsif_expression_b (Current)
		end

feature -- Access

	line_number : INTEGER
			-- Line number in the text file.

	condition: EXPR_B
			-- Condition.

	expression: EXPR_B
			-- Value if `condition' evaluates to `True'.

	type: TYPE_A
			-- <Precursor>
		do
			Result := expression.type
		end

feature -- Status report

	has_gcable_variable: BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.has_gcable_variable or else
				expression.has_gcable_variable
		end

	has_call: BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.has_call or else
				expression.has_call
		end

	allocates_memory: BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.allocates_memory or else
				expression.allocates_memory
		end

feature -- Status setting

	set_line_number (lnr : INTEGER)
			-- Set `line_number' to `lnr'.
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

feature -- Code generation: C

	used (r: REGISTRABLE): BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.used (r) or else
				expression.used (r)
		end

	enlarged: ELSIF_EXPRESSION_B
			-- Redefined for type check.
		do
			Result := Current
		end

	enlarge_tree
			-- Enlarge the elsif construct
		do
			condition := condition.enlarged
			expression := expression.enlarged
		end

	analyze
			-- Builds a proper context (for C code).
		do
			context.init_propagation
			condition.propagate (No_register)
			condition.analyze
			condition.free_register
			expression.propagate (No_register)
			expression.analyze
			expression.free_register
		end

	generate
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_character (' ')
			buf.put_string ({C_CONST}.else_conditional)
			buf.put_two_character (' ', '{')
			generate_line_info
			buf.indent
				-- Generate a hook for the evaluation/test of the condition.
			generate_frozen_debugger_hook
			condition.generate
			buf.put_new_line
			buf.put_string ({C_CONST}.if_conditional)
			buf.put_two_character (' ', '(')
			condition.print_register
			buf.put_three_character (')', ' ', '{')
			buf.indent
			expression.generate
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result :=
				condition.calls_special_features (array_desc) or else
				expression.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := condition.is_unsafe or else expression.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			condition := condition.optimized_byte_node
			expression := expression.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER
		do
			Result := condition.size + expression.size + 1
		end

	pre_inlined_code: like Current
		do
			Result := Current
			condition := condition.pre_inlined_code
			expression := expression.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			condition := condition.inlined_byte_code
			expression := expression.inlined_byte_code
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
