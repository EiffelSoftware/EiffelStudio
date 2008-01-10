indexing
	description	: "Byte code for instruction inside an enalarged loop variant."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class VARIANT_BL

inherit
	VARIANT_B
		redefine
			analyze, generate, free_register,
			register, set_register,
			print_register, unanalyze
		end

	ASSERT_TYPE
		export
			{NONE} all
		end

feature

	register: REGISTRABLE
			-- Register in which old variant value is kept

	new_register: REGISTRABLE
			-- Register in which new value of variant is kept

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r
		end

	analyze is
			-- Analyze variant
		do
			get_register			-- Assignment in register
			new_register := register
			register := Void
			context.init_propagation
			get_register
			expr.propagate (No_register)
			expr.analyze
			expr.free_register
		end

	generate is
			-- Generate variant initializations
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer

				-- generate a debugger hook
			generate_frozen_debugger_hook

				-- Assertion recording on stack
			buf.put_new_line
			if tag /= Void then
				buf.put_string ("RTCT(")
				buf.put_character ('"')
				buf.put_string (tag)
				buf.put_character ('"')
				buf.put_string (gc_comma)
			else
				buf.put_string ("RTCS(")
			end
			generate_assertion_code (In_loop_variant)
			buf.put_string (gc_rparan_semi_c)
			expr.generate
			buf.put_new_line
			register.print_register
			buf.put_string (" = ")
			expr.print_register
			buf.put_character (';')
			buf.put_new_line
			buf.put_string ("if (")
			register.print_register
			buf.put_string (" >= 0) {")
			buf.indent
			buf.put_new_line
			buf.put_string ("RTCK;");
			buf.exdent
			buf.put_new_line
			buf.put_string("} else {")
			buf.indent
			buf.put_new_line
			buf.put_string ("RTCF;")
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

	print_register is
			-- Generate variant tests
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer

				-- generate a debugger hook
			generate_frozen_debugger_hook

				-- Assertion recording on stack
			buffer.put_new_line
			if tag /= Void then
				buf.put_string ("RTCT(")
				buf.put_character ('"')
				buf.put_string (tag)
				buf.put_character ('"')
				buf.put_string (gc_comma)
			else
				buf.put_string ("RTCS(")
			end
			generate_assertion_code (In_loop_variant)
			buf.put_string (gc_rparan_semi_c)
			expr.generate
			buf.put_new_line
			new_register.print_register
			buf.put_string (" = ")
			expr.print_register
			buf.put_character (';')
			buf.put_new_line
				-- Variant check
			buf.put_string ("if ((")
			register.print_register
			buf.put_string (" > ")
			new_register.print_register
			buf.put_string (") && ")
			new_register.print_register
			buf.put_string (" >= 0) {")
			buf.indent
			buf.put_new_line
			buf.put_string ("RTCK;")
			buf.put_new_line
			register.print_register
			buf.put_string (" = ")
			new_register.print_register
			buf.put_character (';')
			buf.exdent
			buf.put_new_line
			buf.put_string ("} else {")
			buf.indent
			buf.put_new_line
			buf.put_string ("RTCF;")
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

	free_register is
			-- Free registers used by the invariant
		do
			new_register.free_register;
			register.free_register;
		end;

	unanalyze is
			-- Undo the analysis
		do
			expr.unanalyze
			set_register (Void)
		end

	fill_from (v: VARIANT_B) is
			-- Fill in current node
		do
			tag := v.tag
			expr := v.expr.enlarged
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
