-- Enlarged byte code for semi-strict "implies"

class B_IMPLIES_BL 

inherit
	B_IMPLIES_B
		redefine
			propagate, free_register, print_register, generate, analyze,
			register, set_register, c_type
		end;
	
feature 

	register: REGISTRABLE;
			-- Where result of expression should be stored

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r;
		end;

	c_type: BOOLEAN_I is
			-- Type is boolean
		once
			create Result;
		end;

	free_register is
			-- Free register used by expression
		do
			if has_call then
				register.free_register
			else
				{B_IMPLIES_B} Precursor;
			end;
		end;

	print_register is
			-- Print value of the expression
		do
			if has_call then
				register.print_register;
			else
				{B_IMPLIES_B} Precursor;
			end;
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate register `r' throughout the expression
		do
			if has_call then
				if
					not context.propagated
					and register = Void
					and r /= No_register
					and then not used (r)
				then
					register := r;
					context.set_propagated;
				end;
			else
				{B_IMPLIES_B} Precursor (r);
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
				{B_IMPLIES_B} Precursor;
			end;
		end;

	generate is
			-- Generate expression
		local
			buf: GENERATION_BUFFER
		do
			if has_call then
					-- Initialize value to true
				register.print_register;
				buf := buffer
				buf.putstring (" = '\01';");
				buf.new_line;
					-- Test first value. If it is false, then the whole
					-- expression is true and the right handside is not evaled.
				left.generate;
				buf.putstring (gc_if_l_paran);
				left.print_register;
				buf.putstring (") {");
				buf.new_line;
					-- Left handside was true. Value of the expression is the
					-- value of the right handside.
				buf.indent;
				right.generate;
				register.print_register;
				buf.putstring (" = ");
				right.print_register;
				buf.putchar (';');
				buf.new_line;
				buf.exdent;
				buf.putchar ('}');
				buf.new_line;
			else
				{B_IMPLIES_B} Precursor;
			end;
		end;

end
