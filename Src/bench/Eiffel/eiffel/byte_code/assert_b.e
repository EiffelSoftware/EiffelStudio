class ASSERT_B 

inherit

	EXPR_B
		redefine
			analyze, generate, unanalyze, enlarged, make_byte_code,
			is_unsafe, optimized_byte_node, calls_special_features,
			size, pre_inlined_code, inlined_byte_code,
			has_separate_call
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
		local
			f: INDENT_FILE
		do
			f := generated_file
				-- Generate the recording of the assertion
			if tag /= Void then
				f.putstring ("RTCT(");
				f.putchar ('"');
				f.putstring (tag);
				f.putchar ('"');
				f.putstring (gc_comma);
			else
				f.putstring ("RTCS(");
			end;
			generate_assertion_code (context.assertion_type);
			f.putstring (gc_rparan_comma);
			f.new_line;
				-- Now evaluate the expression
			expr.generate;
			f.putstring (gc_if_l_paran);
			expr.print_register;
			f.putstring (") {");
			generate_sucess;
			f.putstring (gc_lacc_else_r_acc);
			generate_failure;
			f.putchar ('}');
			f.new_line;
		end;

	generate_sucess is
			-- Generate a success in assertion
		local
			f: INDENT_FILE
		do
			f := generated_file
			f.new_line;
			f.indent;
			f.putstring ("RTCK;");
			f.new_line;
			f.exdent;
		end;

	generate_failure is
			-- Generate a failure in assertion
		local
			f: INDENT_FILE
		do
			f := generated_file
			f.new_line;
			f.indent;
			f.putstring ("RTCF;");
			f.new_line;
			f.exdent;
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
			require_b: REQUIRE_B;
		do
			if context.assertion_type = In_invariant then
				!!inv_assert;
				inv_assert.fill_from (Current);
				Result := inv_assert;
			elseif context.assertion_type = In_precondition then
				!!require_b;
				require_b.fill_from (Current);
				Result := require_b;
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
				make_precondition_byte_code (ba);
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
			if context.assertion_type /= In_precondition then
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
		end;
			
	make_precondition_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a precondition
		do
			ba.append (Bc_pre);
			if not context.is_prec_first_block then
				ba.append (Bc_not_rec);
			elseif tag = Void then
				ba.append (Bc_notag);
			else
				ba.append (Bc_tag);
				ba.append_raw_string (tag);
			end;
				-- Assertion byte code
			expr.make_byte_code (ba);
			if System.has_separate and then expr.has_separate_call then
				ba.append (Bc_sep_set);
			end
			if context.is_prec_first_block then
				ba.append (Bc_end_first_pre);
			else
				ba.append (Bc_end_pre);
			end;
			ba.mark_forward4;
		end;

	byte_for_end: CHARACTER is
			-- Byte mark for end of assertion
		do
			Result := Bc_end_assert;
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expr.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expr.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expr.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current;
			expr := expr.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

feature -- Concurrent Eiffel

	has_separate_call: BOOLEAN is
			-- Is there a separate call in this byte node?
		do
			Result := expr.has_separate_call
		end

end
