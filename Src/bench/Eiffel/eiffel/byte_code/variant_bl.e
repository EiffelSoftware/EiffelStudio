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
				buf.putstring ("RTCT(")
				buf.putchar ('"')
				buf.putstring (tag)
				buf.putchar ('"')
				buf.putstring (gc_comma)
			else
				buf.putstring ("RTCS(")
			end
			generate_assertion_code (In_loop_variant)
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
			expr.generate
			register.print_register
			buf.putstring (" = ")
			expr.print_register
			buf.putchar (';')
			buf.new_line
			buf.putstring ("if (")
			register.print_register
			buf.putstring (" >= 0) {")
			buf.new_line
			buf.indent
			buf.putstring ("RTCK;");
			buf.new_line
			buf.exdent
			buf.putstring("} else {")
			buf.new_line
			buf.indent
			buf.putstring ("RTCF;")
			buf.new_line
			buf.exdent
			buf.putchar ('}')
			buf.new_line
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
				buf.putstring ("RTCT(")
				buf.putchar ('"')
				buf.putstring (tag)
				buf.putchar ('"')
				buf.putstring (gc_comma)
			else
				buf.putstring ("RTCS(")
			end
			generate_assertion_code (In_loop_variant)
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
			expr.generate
			new_register.print_register
			buf.putstring (" = ")
			expr.print_register
			buf.putchar (';')
			buf.new_line
				-- Variant check
			buf.putstring ("if ((")
			register.print_register
			buf.putstring (" > ")
			new_register.print_register
			buf.putstring (") && ")
			new_register.print_register
			buf.putstring (" >= 0) {")
			buf.new_line
			buf.indent
			buf.putstring ("RTCK;")
			buf.new_line
			register.print_register
			buf.putstring (" = ")
			new_register.print_register
			buf.putchar (';')
			buf.new_line
			buf.exdent
			buf.putchar ('}')
			buf.new_line
			buf.putstring ("else {")
			buf.new_line
			buf.indent
			buf.putstring ("RTCF;")
			buf.new_line
			buf.exdent
			buf.putchar ('}')
			buf.new_line
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
