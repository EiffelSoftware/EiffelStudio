-- Creation instruction

class CREATION_B 

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged,
			make_byte_code
		end
	
feature 

	target: ACCESS_B;
			-- Target to create

	info: CREATE_INFO;
			-- Creation info for creating the right type

	call: NESTED_B;
			-- Call after creation: can be Void

	set_target (t: ACCESS_B) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	set_info (i: CREATE_INFO) is
			-- Assign `i' to `info'
		do
			info := i;
		end;

	set_call (n: NESTED_B) is
			-- Assign `i' to `call'.
		do
			call := n;
		end;

feature -- C code generation

	need_enlarging: BOOLEAN is true;
			-- This node needs enlarging

	enlarged: CREATION_BL is
			-- Enlarge current node
		do
			!!Result;
			Result.set_target (target.enlarged);
			Result.set_info (info);
			if call /= Void then
				Result.set_call (call.enlarged);
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a creation instruction
		local
			target_type: TYPE_I;
		do
			ba.append (Bc_create);
			info.make_byte_code (ba);
			target_type := Context.real_type (target.type);
			target.make_assignment_code (ba, target_type);
			if call /= Void then
				call.make_creation_byte_code (ba);
			end;
		end;

end
