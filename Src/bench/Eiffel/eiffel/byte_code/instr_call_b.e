-- Call as an instruction

class INSTR_CALL_B 

inherit

	INSTR_B
		redefine
			enlarge_tree, analyze, generate, make_byte_code
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
			call.make_byte_code (ba);
		end;

end
