-- Creation instruction

class CREATION_B 

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged,
			make_byte_code, is_unsafe,
			optimized_byte_node,
			calls_special_features, size,
			inlined_byte_code, pre_inlined_code
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
debug
	info.trace;
end;
			make_breakable (ba);
			ba.append (Bc_create);
			info.make_byte_code (ba);
			target_type := Context.real_type (target.type);
			target.make_assignment_code (ba, target_type);
			if call /= Void then
				call.make_creation_byte_code (ba);
			end;
			if not target_type.is_basic then
				target.make_byte_code (ba);
				ba.append (Bc_create_inv);
			end;
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if call /= Void then
				Result := call.calls_special_features (array_desc)
			end
		end

	is_unsafe: BOOLEAN is
		do
			if call /= Void then
				Result := call.is_unsafe
			end
		end;

	optimized_byte_node: like Current is
		do
			Result := Current
				-- The current call won't be optimized:
				-- `item' and `put' are NOT creation routines
			if call /= Void then
				call ?= call.optimized_byte_node
			end
		end;

feature -- Inlining

	size: INTEGER is
		do
			Result := 100000
		end

	pre_inlined_code: like Current is
			-- This routine should NEVER be called
		do
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if call /= Void then
				call := call.inlined_byte_code
			end
		end

end
