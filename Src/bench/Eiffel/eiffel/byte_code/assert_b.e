class ASSERT_B 

inherit

	EXPR_B
		redefine
			analyze, generate, unanalyze, enlarged, make_byte_code
		end;
	ASSERT_TYPE
		export
			{NONE} all
		end;
	
feature 

	tag: STRING;
			-- Assertion tag: can be Void

	expr: EXPR_B;
			-- Assertion expression which returns a boolean

	set_tag (s: STRING) is
			-- Assign `s' to `tag'.
		do
			tag := s;
		end;

	set_expr (e: EXPR_B) is
			-- Assign `e' to `expr'.
		do
			expr := e;
		end;

	type: TYPE_I is
			-- Expression type
		do
			Result := expr.type;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end;

	analyze is
			-- Analyze assertion
		do
			context.init_propagation;
			expr.propagate (No_register);
			expr.analyze;
			expr.free_register;
		end;
	
	generate is
			-- Generate assertion
		do
				-- Generate the recording of the assertion
			if tag /= Void then
				generated_file.putstring ("RTCT(");
				generated_file.putchar ('"');
				generated_file.putstring (tag);
				generated_file.putchar ('"');
				generated_file.putstring(", ");
			else
				generated_file.putstring ("RTCS(");
			end;
			generate_assertion_code (context.assertion_type);
			generated_file.putstring(");");
			generated_file.new_line;
				-- Now evaluate the expression
			expr.generate;
			generated_file.putstring ("if (");
			expr.print_register;
			generated_file.putstring (")");
			generate_sucess;
			generated_file.putstring ("else");
			generate_failure;
		end;

	generate_sucess is
			-- Generate a success in assertion
		do
			generated_file.new_line;
            generated_file.indent;
            generated_file.putstring ("RTCK;");
            generated_file.new_line;
            generated_file.exdent;
		end;

	generate_failure is
			-- Generate a failure in assertion
		do
			generated_file.new_line;
			generated_file.indent;
			generated_file.putstring ("RTCF;");
			generated_file.new_line;
			generated_file.exdent;
		end;

	
	unanalyze is
			-- Undo the analysis
		do
			expr.unanalyze;
		end;

	enlarged: like Current is
			-- Tree enlarging
		local
			inv_assert: INV_ASSERT_B;
		do
			if context.assertion_type = In_invariant then
				!!inv_assert;
				inv_assert.fill_from (Current);
				Result := inv_assert;
			else
				expr := expr.enlarged;
					-- Make sure the expression has never been analyzed before,
					-- which it could be if the assertion retrieved was in
					-- the cache
				expr.unanalyze;
				Result := Current;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an assertion
		do
			check
				expr_exists: expr /= Void
			end;
				-- Assertion mark
			ba.append (Bc_assert);
			inspect
                context.assertion_type
            when In_precondition then
                ba.append (Bc_pre);
            when In_postcondition then
                ba.append (Bc_pst);
            when In_check then
                ba.append (Bc_chk);
            when In_loop_invariant then
                ba.append (Bc_linv);
            when In_loop_variant then
                ba.append (Bc_lvar);
            when In_invariant then
                ba.append (Bc_inv);
            end;
			if tag = Void then
				ba.append (Bc_notag);
			else
				ba.append (Bc_tag);
				ba.append_raw_string (tag);
			end;

				-- Assertion byte code
			expr.make_byte_code (ba);

				-- End assertion mark
			ba.append (byte_for_end);
		end;

	byte_for_end: CHARACTER is
			-- Byte mark for end of assertion
		do
			Result := Bc_end_assert;
		end;

end
