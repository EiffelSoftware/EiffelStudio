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
		do
			context.init_propagation;
			expr.propagate (No_register);
			expr.analyze;
			expr.free_register;
			get_register;
		end;

	initialize is
			-- Initialize the value of the old variable.
		do
			expr.generate;
			if 	not (type.is_basic and then
				(expr.register.register_name.is_equal (expr.register.register_name)))
			then
				register.print_register;
				generated_file.putstring (" = ");
				if type.is_basic then
					expr.print_register;
				else
					generated_file.putstring ("RTCL(");
					expr.print_register;
					generated_file.putchar(')');
				end;
				generated_file.putchar (';');
				generated_file.new_line;
			end
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
			register.print_register;
		end;

	free_register is
			-- Do nothing
		do
		end;

end
