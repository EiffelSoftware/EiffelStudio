-- Call as an instruction

class INSTR_CALL_B 

inherit

	INSTR_B
		redefine
			enlarge_tree, analyze, generate, make_byte_code,
			is_unsafe, optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code, generate_il
		end
	
feature 

	enlarge_tree is
			-- Enlarge byte code tree
		do
			call := call.enlarged;
		end;

	call: CALL_B;
			-- Instruction call
	
	set_call (c: like call) is
			-- Assign `c' to `call'.
		do
			call := c;
		end;

	analyze is
			-- Analyze the call
		do
			call.analyze;
		end;
	
	generate is
			-- Generate the call
		do
			generate_line_info;
			generate_frozen_debugger_hook
			call.generate;
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for an intruction call
		do
			generate_il_line_info
			call.generate_il
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an intruction call
		do
			generate_melted_debugger_hook (ba);
			call.make_byte_code (ba);
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := call.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := call.is_unsafe
		end;

	optimized_byte_node: like Current is
		do
			Result := Current
			call := call.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := call.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current;
			call := call.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			call := call.inlined_byte_code
		end

end
