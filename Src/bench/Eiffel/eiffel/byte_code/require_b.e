class REQUIRE_B 

inherit

	ASSERT_B
		redefine
			generate
		end;
	
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
			if Context.is_prec_first_block then
				-- Generate the recording of the assertion
				if tag /= Void then
					generated_file.putstring ("RTCT(");
					generated_file.putchar ('"');
					generated_file.putstring (tag);
					generated_file.putchar ('"');
					generated_file.putstring (gc_comma);
				else
					generated_file.putstring ("RTCS(");
				end;
				generate_assertion_code (context.assertion_type);
				generated_file.putstring (gc_rparan_comma);
				generated_file.new_line;
			end;
				-- Now evaluate the expression
			expr.generate;
			generated_file.putstring ("RTTE(");
			expr.print_register;
			generated_file.putstring (gc_comma);
			if System.has_separate and then expr.has_separate_call then
				context.print_concurrent_label;
			else
				context.print_current_label;
			end;
			generated_file.putstring (gc_rparan_comma);
			generated_file.new_line;
			if Context.is_prec_first_block then
				generated_file.putstring ("RTCK;");
				generated_file.new_line;
			end;
		end;

end
