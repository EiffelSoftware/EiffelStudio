-- The enlarged "old" operator

class UN_OLD_BL 

inherit

	UN_OLD_B
		redefine
			register, set_register,
			analyze, generate, unanalyze,
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

	analyze is
			-- Analyze expression and get a register
		local
			target_type: TYPE_I
		do
			target_type := Context.real_type (type);
			context.init_propagation;
			expr.propagate (No_register);
			expr.analyze;
			if not target_type.is_basic then
				expr.free_register;
				get_register;
			end;
		end;

	initialize is
			-- Initialize the value of the old variable.
		local
			target_type: TYPE_I
		do
			expr.generate;
			target_type := Context.real_type (type);
			if not target_type.is_basic then
				register.print_register;
				generated_file.putstring (" = ");
				generated_file.putstring ("RTCL(");
				expr.print_register;
				generated_file.putchar(')');
				generated_file.putchar (';');
				generated_file.new_line;
			end;
		end;

	unanalyze is
			-- Undo the analysis
		local
			void_reg: REGISTER;
		do
			expr.unanalyze;
			set_register (void_reg);
		end;

	generate is
			-- Do nothing
		do
		end;
	
	print_register is
			-- Print the value of the old variable
		do
			if register = Void then
				-- Old value of basic 
				expr.print_register
			else
				register.print_register;
			end;
		end;

	free_register is
			-- Do nothing
		do
		end;

end
