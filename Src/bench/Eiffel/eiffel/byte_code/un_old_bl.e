-- The enlarged "old" operator

class UN_OLD_BL 

inherit

	UN_OLD_B
		redefine
			register, set_register,
			generate, unanalyze, analyze,
			print_register, free_register
		end;
	
feature 

	register: REGISTRABLE;
			-- Register which stores the old value.
			-- This register is never freed, of course.
	
	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	special_analyze is
			-- Analyze expression and get a register
		local
			target_type: TYPE_I
		do
			target_type := Context.real_type (type);
			context.init_propagation;
			expr.propagate (No_register);
			get_register;
			expr.analyze;
			expr.free_register;
		end;

	initialize is
			-- Initialize the value of the old variable.
		local
			target_type: TYPE_I
			buf: GENERATION_BUFFER
		do
			expr.generate;
			target_type := Context.real_type (type);
			register.print_register;
			buf := buffer
			buf.putstring (" = ");
			expr.print_register;
			buf.putchar (';');
			buf.new_line;
		end;

	unanalyze is
			-- Undo the analysis
		local
			void_reg: REGISTER;
		do
			expr.unanalyze;
			set_register (void_reg);
		end;

	analyze is
			-- Do nothing
		do
		end;

	generate is
			-- Do nothing
		do
		end;
	
	print_register is
			-- Print the value of the old variable
		do
			register.print_register;
		end;

	free_register is
			-- Do nothing
		do
		end;

end
