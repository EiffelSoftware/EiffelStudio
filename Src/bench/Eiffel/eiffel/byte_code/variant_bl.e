indexing
	description	: "Byte code for instruction inside an enalarged loop variant."
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
			buf.put_new_line
			expr.generate
			register.print_register
			buf.put_string (" = ")
			expr.print_register
			buf.put_character (';')
			buf.put_new_line
			buf.put_string ("if (")
			register.print_register
			buf.put_string (" >= 0) {")
			buf.put_new_line
			buf.indent
			buf.put_string ("RTCK;");
			buf.put_new_line
			buf.exdent
			buf.put_string("} else {")
			buf.put_new_line
			buf.indent
			buf.put_string ("RTCF;")
			buf.put_new_line
			buf.exdent
			buf.put_character ('}')
			buf.put_new_line
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
			buf.put_new_line
			expr.generate
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
			buf.put_new_line
			buf.indent
			buf.put_string ("RTCK;")
			buf.put_new_line
			register.print_register
			buf.put_string (" = ")
			new_register.print_register
			buf.put_character (';')
			buf.put_new_line
			buf.exdent
			buf.put_character ('}')
			buf.put_new_line
			buf.put_string ("else {")
			buf.put_new_line
			buf.indent
			buf.put_string ("RTCF;")
			buf.put_new_line
			buf.exdent
			buf.put_character ('}')
			buf.put_new_line
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

end
