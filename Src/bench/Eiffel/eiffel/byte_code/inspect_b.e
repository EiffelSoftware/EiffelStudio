-- Byte code for multi-branch instruction

class INSPECT_B 

inherit

	INSTR_B
		redefine
			analyze, generate, enlarge_tree, make_byte_code
		end;
	VOID_REGISTER
		export
			{NONE} all
		end;
	
feature 

	switch: EXPR_B;
			-- Expression to inspect

	case_list: BYTE_LIST [BYTE_NODE];
			-- Alternaltives {list of CASE_B}: can be Void

	else_part: BYTE_LIST [BYTE_NODE];
			-- Default compound {list of INSTR_B}: can be Void

	set_switch (s: like switch) is
			-- Assign `s' to `switch'.
		do
			switch := s;
		end;

	set_case_list (c: like case_list) is
			-- Assign `c' to `case_list'.
		do
			case_list := c;
		end;

	set_else_part (e: like else_part) is
			-- Assign `e' to `else_part'.
		do
			else_part := e;
		end;

	enlarge_tree is
			-- Enlarge the inspect statement
		do
			switch := switch.enlarged;
			if case_list /= Void then
				case_list.enlarge_tree;
			end;
			if else_part /= Void then
				else_part.enlarge_tree;
			end;
		end;

	analyze is
			-- Builds a proper context (for C code).
		do
			context.init_propagation;
			switch.propagate (No_register);
			switch.analyze;
			switch.free_register;
			if case_list /= Void then
				case_list.analyze;
			end;
			if else_part /= Void then
				else_part.analyze;
			end;
		end;

	generate is
			-- Generate C code in `generated_file'.
		do
			generated_file.new_line;
			switch.generate;
			generated_file.putstring ("switch (");
			switch.print_register;
			generated_file.putstring (") {");
			generated_file.new_line;
			if case_list /= Void then
				case_list.generate;
			end;
			if else_part = Void or else not else_part.empty then
				generated_file.putstring ("default:");
				generated_file.new_line;
				generated_file.indent;
				if else_part = Void then
						-- Raise an exception
					generated_file.putstring ("RTEC(EN_WHEN);");
				else
					else_part.generate;
					generated_file.putstring ("break;");
				end;
				generated_file.new_line;
				generated_file.exdent;
			end;
			generated_file.putchar ('}');
			generated_file.new_line;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a multi-branch instruction
		local
			i: INTEGER;
			case: CASE_B;
		do
				-- Generate switch expression byte code
			switch.make_byte_code (ba);
			if case_list /= Void then
				from
					i := case_list.count
				until
					i < 1
				loop
					case ?= case_list.i_th (i);
					case.make_range (ba);
					i := i - 1;
				end;
				ba.append (Bc_jmp);
				ba.mark_forward3;		-- To else part
				case_list.make_byte_code (ba);
				ba.write_forward3;
			end;
			if else_part /= Void then
				else_part.make_byte_code (ba);
			else
				ba.append (Bc_inspect_excep);
			end;
				-- Jumps for cases compounds
			if case_list /= Void then
				from
					i := case_list.count;
				until
					i < 1
				loop
					ba.write_forward;
					i := i - 1;
				end;
			end;
			ba.append (Bc_inspect);
		end;

end
