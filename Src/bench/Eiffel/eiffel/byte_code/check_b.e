class CHECK_B 

inherit

	INSTR_B
		redefine
			enlarge_tree, analyze, generate, make_byte_code
		end;
	ASSERT_TYPE
		
		export
			{NONE} all
		end;
	
feature 

	check_list: BYTE_LIST [BYTE_NODE];
			-- Assertion list {list of ASSERT_B}: can be Void

	set_check_list (c: like check_list) is
			-- Assign `c' to `chcek_list'.
		do
			check_list := c;
		end;

	enlarge_tree is
			-- Enlarge the generation tree
		do
			if check_list /= Void then
				check_list.enlarge_tree;
			end;
		end;
	
	analyze is
			-- Analyze the assertions
		local
			workbench_mode: BOOLEAN;
		do
			if check_list /= Void then
				workbench_mode := context.workbench_mode;
				if 	workbench_mode
					or else
					context.assertion_level.check_check
				then
					if workbench_mode then
						context.add_dt_current;
					end;
					check_list.analyze;
				end;
			end;
		end;

	generate is
			-- Generate the assertions
		local
			workbench_mode: BOOLEAN;
		do
			if check_list /= Void then
				workbench_mode := context.workbench_mode;
				context.set_assertion_type (In_check);
				if workbench_mode then
					generated_file.putstring ("if (RTAL & CK_CHECK) {");
					generated_file.new_line;
					generated_file.indent;
					check_list.generate;
					generated_file.exdent;
					generated_file.putchar ('}');
					generated_file.new_line;
				elseif context.assertion_level.check_check then
					generated_file.putstring ("if (~in_assertion) {");
					generated_file.new_line;
					generated_file.indent;
					check_list.generate;
					generated_file.exdent;
					generated_file.putchar ('}');
					generated_file.new_line;
				end;
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a check instruction.
		do
			if check_list /= Void then
					-- Set assertion type
				context.set_assertion_type (In_check);

				ba.append (Bc_check);
					-- In case, the check assertions won't be checked, we
					-- have to put a jump offset
				ba.mark_forward;
					-- Assertion byte code
				check_list.make_byte_code (ba);
					-- Jump offset evaluation
				ba.write_forward;
			end;
			make_breakable (ba)
		end;

end
