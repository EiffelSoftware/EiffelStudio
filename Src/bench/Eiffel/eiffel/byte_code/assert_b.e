indexing
	description	: "Byte code for instruction inside a check/postcondition/[in]variant."
	date		: "$Date$"
	revision	: "$Revision$"

class ASSERT_B

inherit
	EXPR_B
		redefine
			analyze, generate, unanalyze, enlarged, make_byte_code,
			is_unsafe, optimized_byte_node, calls_special_features,
			size, pre_inlined_code, inlined_byte_code,
			has_separate_call, generate_il, line_number, set_line_number
		end

	ASSERT_TYPE
		export
			{NONE} generate_assertion_code, buffer
		end
	
feature -- Access

	tag: STRING
			-- Assertion tag: can be Void

	expr: EXPR_B
			-- Assertion expression which returns a boolean

	line_number : INTEGER

feature -- Line number setting

	set_line_number (lnr : INTEGER) is
		do
			line_number := lnr
		ensure then
			line_number_set : line_number = lnr
		end


	set_tag (s: STRING) is
			-- Assign `s' to `tag'.
		do
			tag := s
		end

	set_expr (e: EXPR_B) is
			-- Assign `e' to `expr'.
		do
			expr := e
		end

	type: TYPE_I is
			-- Expression type
		do
			Result := expr.type
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

	analyze is
			-- Analyze assertion
		do
			context.init_propagation
			expr.propagate (No_register)
			expr.analyze
			expr.free_register
		end
	
	generate is
			-- Generate assertion C code.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer

				-- generate a debugger hook
			generate_frozen_debugger_hook

				-- Generate the recording of the assertion
			if tag /= Void then
				buf.putstring ("RTCT(")
				buf.putchar ('"')
				buf.putstring (tag)
				buf.putchar ('"')
				buf.putstring (gc_comma)
			else
				buf.putstring ("RTCS(")
			end
			generate_assertion_code (context.assertion_type)
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
				-- Now evaluate the expression
			expr.generate
			buf.putstring (gc_if_l_paran)
			expr.print_register
			buf.putstring (") {")
			generate_success (buf)
			buf.putstring (gc_lacc_else_r_acc)
			generate_failure (buf)
			buf.putchar ('}')
			buf.new_line
		end

	generate_success (buf: like buffer) is
			-- Generate a success in assertion
		do
			buf.new_line
			buf.indent
			buf.putstring ("RTCK;")
			buf.new_line
			buf.exdent
		end

	generate_failure (buf: like buffer) is
			-- Generate a failure in assertion
		do
			buf.new_line
			buf.indent
			buf.putstring ("RTCF;")
			buf.new_line
			buf.exdent
		end
	
	unanalyze is
			-- Undo the analysis
		do
			expr.unanalyze
		end

	enlarged: like Current is
			-- Tree enlarging
		local
			inv_assert: INV_ASSERT_B
			require_b: REQUIRE_B
		do
			if context.assertion_type = In_invariant then
				create inv_assert
				inv_assert.fill_from (Current)
				Result := inv_assert
			elseif context.assertion_type = In_precondition then
				create require_b
				require_b.fill_from (Current)
				Result := require_b
			else
				expr := expr.enlarged
					-- Make sure the expression has never been analyzed before,
					-- which it could be if the assertion retrieved was in
					-- the cache
				expr.unanalyze
				Result := Current
			end
		end;

feature -- IL Code generation

	generate_il is
			-- Generate IL code for an assertion which is not a precondition
		do
			check
				expr_exists: expr /= Void
				not_in_precondition: context.assertion_type /= In_precondition
			end

			generate_il_line_info

			expr.generate_il

			if tag = Void then
				il_generator.generate_assertion_check (context.assertion_type, "")
			else
				il_generator.generate_assertion_check (context.assertion_type, tag)
			end
		end

	generate_il_precondition (failure_block: IL_LABEL) is
			-- Generate IL code for a precondition checking
		require
			in_precondition: context.assertion_type = In_precondition
		do
			expr.generate_il
			
			if tag = Void then
				il_generator.generate_precondition_check ("", failure_block)
			else
				il_generator.generate_precondition_check (tag, failure_block)
			end
		end

feature -- Byte Code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an assertion
		do
			check
				expr_exists: expr /= Void
			end

				-- Assertion mark
			inspect
				context.assertion_type
			when In_precondition then
				make_precondition_byte_code (ba)
			when In_postcondition then
					-- generate a debugger hook
				context.generate_melted_debugger_hook (ba)
				ba.append (Bc_assert)
				ba.append (Bc_pst)
			when In_check then
					-- generate a debugger hook
				context.generate_melted_debugger_hook (ba)
				ba.append (Bc_assert)
				ba.append (Bc_chk)
			when In_loop_invariant then
					-- generate a debugger hook
				context.generate_melted_debugger_hook (ba)
				ba.append (Bc_assert)
				ba.append (Bc_linv)
			when In_loop_variant then
					-- generate a debugger hook
				context.generate_melted_debugger_hook (ba)
				ba.append (Bc_assert)
				ba.append (Bc_lvar)
			when In_invariant then
					-- Do not generate a hook.
				ba.append (Bc_assert)
				ba.append (Bc_inv)
			end
			if context.assertion_type /= In_precondition then
				if tag = Void then
					ba.append (Bc_notag)
				else
					ba.append (Bc_tag)
					ba.append_raw_string (tag)
				end
					-- Assertion byte code
				expr.make_byte_code (ba)

					-- End assertion mark
				ba.append (byte_for_end)
			end
		end
			
	byte_for_end: CHARACTER is
			-- Byte mark for end of assertion
		do
			Result := Bc_end_assert
		end

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
			-- Size of the assertion.
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

feature {NONE} -- Implementation 

	make_precondition_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a precondition
		do
			if Context.is_new_precondition_block then
				Context.set_new_precondition_block (False)
				if Context.is_first_precondition_block_generated then
					from
					until
						ba.forward_marks4.count = 0
					loop
						ba.write_forward4
					end
					ba.append (Bc_goto_body)
					ba.mark_forward
				else
					Context.set_first_precondition_block_generated (True)
				end
			end

				-- generate a debugger hook
			context.generate_melted_debugger_hook (ba)

			ba.append (Bc_assert)
			ba.append (Bc_pre)
			if tag = Void then
				ba.append (Bc_notag)
			else
				ba.append (Bc_tag)
				ba.append_raw_string (tag)
			end

				-- Assertion byte code
			expr.make_byte_code (ba)
			if System.has_separate and then expr.has_separate_call then
				ba.append (Bc_sep_set)
			end
			ba.append (Bc_end_pre)
			ba.mark_forward4

		end

end
