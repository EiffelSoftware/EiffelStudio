-- An enalarged loop variant

class VARIANT_BL 

inherit

	VARIANT_B
		redefine
			analyze, generate, free_register,
			register, set_register,
			print_register, unanalyze
		end;

	ASSERT_TYPE
		export
			{NONE} all
		end;

feature 

	register: REGISTRABLE;
			-- Register in which old variant value is kept

	new_register: REGISTRABLE;
			-- Register in which new value of variant is kept

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	analyze is
			-- Analyze variant
		local
			void_reg: REGISTER;
		do
			get_register;			-- Assignment in register
			new_register := register;
			register := void_reg;
			context.init_propagation;
			get_register;
			expr.propagate (No_register);
			expr.analyze;
			expr.free_register;
		end;
	
	generate is
			-- Generate variant initializations
		do
			register.print_register;
			generated_file.putstring (" = -1L;");
			generated_file.new_line;
		end;

	print_register is
			-- Generate variant tests
		do
				-- Assertion recording on stack
			if tag /= Void then
				generated_file.putstring ("RTCT(");
				generated_file.putchar ('"');
				generated_file.putstring (tag);
				generated_file.putchar ('"');
				generated_file.putstring(", ");
			else
				generated_file.putstring ("RTCS(");
			end;
			generate_assertion_code (In_loop_variant);
			generated_file.putstring(");");
			generated_file.new_line;
			expr.generate;
			new_register.print_register;
			generated_file.putstring (" = ");
			expr.print_register;
			generated_file.putchar (';');
			generated_file.new_line;
				-- Variant check
			generated_file.putstring ("if ((");
			register.print_register;
			generated_file.putstring (" == -1L || ");
			register.print_register;
			generated_file.putstring (" > ");
			new_register.print_register;
			generated_file.putstring (") && ");
			new_register.print_register;
			generated_file.putstring (" >= 0) {");
			generated_file.new_line;
			generated_file.indent;
			generated_file.putstring ("RTCK;");
			generated_file.new_line;
			register.print_register;
			generated_file.putstring (" = ");
			new_register.print_register;
			generated_file.putchar (';');
			generated_file.new_line;
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
			generated_file.putstring ("else {");
			generated_file.new_line;
			generated_file.indent;
			generated_file.putstring ("RTCF;");
			generated_file.new_line;
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
		end;

	free_register is
			-- Free registers used by the invariant
		do
			new_register.free_register;
			register.free_register;
		end;

	unanalyze is
			-- Undo the analysis
		local
			void_reg: REGISTER;
		do
			expr.unanalyze;
			set_register (void_reg);
		end;

	fill_from (v: VARIANT_B) is
			-- Fill in current node
		do
			tag := v.tag;
			expr := v.expr.enlarged;
		end;

end
