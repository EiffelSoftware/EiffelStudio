-- Byte code for nested call

class NESTED_B 

inherit

	CALL_B
		redefine
			enlarged, make_byte_code, make_creation_byte_code,
			need_invariant, set_need_invariant
		end
	
feature 

	target: ACCESS_B;
			-- Target of the call

	message: CALL_B;
			-- Message to send to the target

	set_target (t: ACCESS_B) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	set_message (m: CALL_B) is
			-- Assign `m' to `message'.
		do
			message := m;
		end;

	type: TYPE_I is
			-- Expression of the remote call
		do
			Result := message.type;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in the local target or message ?
		do
			Result := message.forth_used (r) or target.used (r);
		end;

	forth_used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in the forthcomming expressions ?
		do
			Result := message.forth_used (r);
		end;

	is_single: BOOLEAN is
			-- Is call a single one ?
		do
			if message.target = message and
					-- First condition: must have a depth of 1.
				target.is_predefined
					-- Second condition: target has to be predefined.
			then
					-- Third condition: all the parameters must be predefined.
				Result := message.is_single;
			end;
		end;

	enlarged: NESTED_BL is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		local
			void_parent: NESTED_BL;
		do
				-- This is the root of the call tree
			Result := sub_enlarged (void_parent);
		end;

	sub_enlarged (p: NESTED_BL): NESTED_BL is
			-- Enlarge node and set parent to `p'
		do
			!!Result;
			Result.set_parent (p);
			Result.set_target (target.sub_enlarged (Result));
			Result.set_message (message.sub_enlarged (Result));
		end;

	generate_creation_call is
			-- Generation of a creation call
		do
		end;

	need_invariant: BOOLEAN is
		do
			Result := message.need_invariant
		end;

	set_need_invariant (b: BOOLEAN) is
		do
			message.set_need_invariant (b)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a nested call.
		do
			target.make_byte_code (ba);
			message.make_byte_code (ba);
		end;

	make_creation_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a nested call for a creation.
		do
			target.make_byte_code (ba);
			message.make_creation_byte_code (ba);
		end;

end
