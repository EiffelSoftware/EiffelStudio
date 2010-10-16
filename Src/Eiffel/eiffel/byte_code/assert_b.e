note
	description	: "Byte code for instruction inside a check/postcondition/[in]variant."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class ASSERT_B

inherit
	EXPR_B
		redefine
			analyze,
			calls_special_features,
			enlarged,
			generate,
			inlined_byte_code,
			is_unsafe,
			line_number,
			optimized_byte_node,
			pre_inlined_code,
			set_line_number,
			size,
			unanalyze
		end

	ASSERT_TYPE
		export
			{NONE} generate_assertion_code, buffer
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_assert_b (Current)
		end

feature -- Access

	tag: STRING
			-- Assertion tag: can be Void

	expr: EXPR_B
			-- Assertion expression which returns a boolean

	line_number : INTEGER

feature -- Line number setting

	set_line_number (lnr : INTEGER)
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

	set_tag (s: STRING)
			-- Assign `s' to `tag'.
		do
			tag := s
		end

	set_expr (e: EXPR_B)
			-- Assign `e' to `expr'.
		do
			expr := e
		end

	type: TYPE_A
			-- Expression type
		do
			Result := expr.type
		end

	used (r: REGISTRABLE): BOOLEAN
			-- False
		do
		end

	analyze
			-- Analyze assertion
		local
			l_expr: like expr
		do
			context.init_propagation
			l_expr := expr
			l_expr.propagate (No_register)
			l_expr.analyze
			l_expr.free_register
		end

	generate
			-- Generate assertion C code.
		local
			buf: GENERATION_BUFFER
			l_expr: like expr
		do
			buf := buffer

				-- generate a debugger hook
			generate_frozen_debugger_hook

				-- Generate the recording of the assertion
			buf.put_new_line
			buf.put_string ("RTCT")
			if context.assertion_type = in_guard then
				buf.put_character ('0')
			end
			buf.put_character ('(')
			if tag /= Void then
				buf.put_character ('"')
				buf.put_string (tag)
				buf.put_character ('"')
			else
				buf.put_string ("NULL")
			end
			buf.put_string ({C_CONST}.comma_space)
			generate_assertion_code (context.assertion_type)
			buf.put_two_character (')', ';')
				-- Now evaluate the expression
			l_expr := expr
			l_expr.generate
			buf.put_new_line
			buf.put_string ({C_CONST}.if_conditional)
			buf.put_two_character (' ', '(')
			l_expr.print_register
			buf.put_three_character (')', ' ', '{')
			generate_success (buf)
			buf.put_new_line
			buf.put_two_character ('}', ' ')
			buf.put_string ({C_CONST}.else_conditional)
			buf.put_two_character (' ', '{')
			generate_failure (buf)
			buffer.put_new_line
			buf.put_character ('}')
		end

	generate_success (buf: like buffer)
			-- Generate a success in assertion
		do
			buf.indent
			buf.put_new_line
			buf.put_string ("RTCK")
			if context.assertion_type = in_guard then
				buf.put_character ('0')
			end
			buf.put_character (';')
			buf.exdent
		end

	generate_failure (buf: like buffer)
			-- Generate a failure in assertion
		do
			buf.indent
			buf.put_new_line
			buf.put_string ("RTCF")
			if context.assertion_type = in_guard then
				buf.put_character ('0')
			end
			buf.put_character (';')
			buf.exdent
		end

	unanalyze
			-- Undo the analysis
		do
			expr.unanalyze
		end

	enlarged: ASSERT_B
			-- Tree enlarging
		local
			inv_assert: INV_ASSERT_B
			require_b: REQUIRE_B
		do
			if context.assertion_type = In_invariant then
				create inv_assert
				inv_assert.fill_from (Current)
				Result := inv_assert
			elseif context.assertion_type = In_precondition then
				create require_b
				require_b.fill_from (Current)
				Result := require_b
			else
				expr := expr.enlarged
					-- Make sure the expression has never been analyzed before,
					-- which it could be if the assertion retrieved was in
					-- the cache
				expr.unanalyze
				Result := Current
			end
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := expr.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := expr.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER
			-- Size of the assertion.
		do
			Result := expr.size
		end

	pre_inlined_code: like Current
		do
			Result := Current;
			expr := expr.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
