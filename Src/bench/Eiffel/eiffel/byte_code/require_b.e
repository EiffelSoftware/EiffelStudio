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
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if Context.is_prec_first_block then
				-- Generate the recording of the assertion
				if tag /= Void then
					buf.putstring ("RTCT(");
					buf.putchar ('"');
					buf.putstring (tag);
					buf.putchar ('"');
					buf.putstring (gc_comma);
				else
					buf.putstring ("RTCS(");
				end;
				generate_assertion_code (context.assertion_type);
				buf.putstring (gc_rparan_comma);
				buf.new_line;
			end;
				-- Now evaluate the expression
			expr.generate;
			buf.putstring ("RTTE(");
			expr.print_register;
			buf.putstring (gc_comma);
			if System.has_separate and then expr.has_separate_call then
				context.print_concurrent_label;
			else
				context.print_current_label;
			end;
			buf.putstring (gc_rparan_comma);
			buf.new_line;
			if Context.is_prec_first_block then
				buf.putstring ("RTCK;");
				buf.new_line;
			end;
		end;

end
