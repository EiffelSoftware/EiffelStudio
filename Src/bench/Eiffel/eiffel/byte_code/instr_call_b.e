-- Call as an instruction

class INSTR_CALL_B 

inherit

	INSTR_B
		redefine
			enlarge_tree, analyze, generate, make_byte_code,
			is_unsafe, optimized_byte_node, calls_special_features
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
			call.generate;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an intruction call
		do
			make_breakable (ba);
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

end
