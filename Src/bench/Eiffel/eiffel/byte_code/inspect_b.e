-- Byte code for multi-branch instruction

class INSPECT_B 

inherit

	INSTR_B
		redefine
			analyze, generate, enlarge_tree, make_byte_code,
			has_loop, assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code
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
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_line_info;
			buf.new_line;
			switch.generate;
			buf.putstring ("switch (");
			switch.print_register;
			buf.putstring (") {");
			buf.new_line;
			if case_list /= Void then
				case_list.generate;
			end;
			if else_part = Void or else not else_part.empty then
				buf.putstring ("default:");
				buf.new_line;
				buf.indent;
				if else_part = Void then
						-- Raise an exception
					buf.putstring ("RTEC(EN_WHEN);");
				else
					else_part.generate;
					buf.putstring ("break;");
				end;
				buf.new_line;
				buf.exdent;
			end;
			buf.putchar ('}');
			buf.new_line;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a multi-branch instruction
		local
			i: INTEGER;
			case: CASE_B;
		do
			make_breakable (ba)

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
				make_breakable (ba);
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

feature -- Array optimization

	has_loop: BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.has_loop) or else
				(else_part /= Void and then else_part.has_loop)
		end

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.assigns_to (i)) or else
				(else_part /= Void and then else_part.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.calls_special_features (array_desc))
				or else (else_part /= Void and then else_part.calls_special_features (array_desc))
				or else switch.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.is_unsafe)
				or else (else_part /= Void and then else_part.is_unsafe)
				or else switch.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			switch := switch.optimized_byte_node
			if case_list /= Void then
				case_list := case_list.optimized_byte_node
			end
			if else_part /= Void then
				else_part := else_part.optimized_byte_node
			end
		end;

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + switch.size
			if case_list /= Void then
				Result := Result + case_list.size
			end
			if else_part /= Void then
				Result := Result + else_part.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if case_list /= Void then
				case_list := case_list.pre_inlined_code
			end
			if else_part /= Void then
				else_part := else_part.pre_inlined_code
			end
			switch := switch.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if case_list /= Void then
				case_list := case_list.inlined_byte_code
			end
			if else_part /= Void then
				else_part := else_part.inlined_byte_code
			end
			switch := switch.inlined_byte_code
		end

end
