-- Invariant assertion

class INV_ASSERT_B 

inherit

	ASSERT_B
		redefine
			generate
		end
	
feature 

	fill_from (a: ASSERT_B) is
			-- Initialization
		require
			good_argument: not (a = Void);
		do
			expr := a.expr.enlarged;
			-- Make sure the expression has never been analyzed before
			expr.unanalyze;
			tag := a.tag;
		end;

	 generate is
			-- Generate assertion
		do
				-- Generate the recording of the assertion
			if tag /= Void then
				generated_file.putstring ("RTIT(");
				generated_file.putchar ('"');
				generated_file.putstring (tag);
				generated_file.putchar ('"');
				generated_file.putstring (gc_comma);
			else
				generated_file.putstring ("RTIS(");
			end;
			context.Current_register.print_register_by_name;
			generated_file.putstring (gc_rparan_comma);
			generated_file.new_line;
				-- Now evaluate the expression
			expr.generate;
			generated_file.putstring (gc_if_l_paran);
			expr.print_register;
			generated_file.putstring (") {");
			generate_sucess;
			generated_file.putstring (gc_lacc_else_r_acc);
			generate_failure;
			generated_file.putchar ('}');
			generated_file.new_line;
		end;

end
