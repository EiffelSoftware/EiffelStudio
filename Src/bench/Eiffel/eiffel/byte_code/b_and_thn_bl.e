-- Enlarged byte code for "and then"

class B_AND_THN_BL 

inherit

	B_AND_THEN_B
		rename
			analyze as old_analyze,
			generate as old_generate,
			free_register as old_free_register,
			print_register as old_print_register,
			propagate as old_propagate
		redefine
			c_type, register, set_register
		end;

	B_AND_THEN_B
		redefine
			propagate, free_register, print_register, generate, analyze,
			c_type, register, set_register
		select
			propagate, free_register, print_register, generate, analyze
		end;

feature 

	register: REGISTRABLE;
			-- Where result of expression should be stored

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r;
		end;

	c_type: CHAR_I is
			-- Type is boolean
		once
			!!Result;
		end;

	free_register is
			-- Free register used by expression
		do
			if has_call then
				register.free_register
			else
				old_free_register;
			end;
		end;

	print_register is
			-- Print value of the expression
		do
			if has_call then
				register.print_register;
			else
				old_print_register;
			end;
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate register `r' throughout the expression
		do
			if has_call then
				if 	not context.propagated
					and register = Void
					and r /= No_register
					and then not used (r)
				then
					register := r;
					context.set_propagated;
				end;
			else
				old_propagate (r);
			end;
		end;

	analyze is
			-- Analyze expression
		do
			if has_call then
				get_register;
				context.init_propagation;
				left.propagate (No_register);
				context.init_propagation;
				right.propagate (No_register);
				left.analyze;
				left.free_register;
				right.analyze;
				right.free_register;
			else
				old_analyze;
			end;
		end;

	generate is
			-- Generate expression
		do
			if has_call then
					-- Initialize value to false
				register.print_register;
				generated_file.putstring (" = '\0';");
				generated_file.new_line;
					-- Test first value. If it is false, then the whole
					-- expression is false and the right handside is not evaled.
				left.generate;
				generated_file.putstring (gc_if_l_paran);
				left.print_register;
				generated_file.putstring (") {");
				generated_file.new_line;
					-- Left handside was true. Value of the expression is the
					-- value of the right handside.
				generated_file.indent;
				right.generate;
				register.print_register;
				generated_file.putstring (" = ");
				right.print_register;
				generated_file.putchar (';');
				generated_file.new_line;
				generated_file.exdent;
				generated_file.putchar ('}');
				generated_file.new_line;
			else
				old_generate;
			end;
		end;

end
