-- Access to Current

class CURRENT_B 

inherit

	ACCESS_B
		redefine
			enlarged, is_current, make_byte_code,
			register_name
		end;
	
feature 

	type: TYPE_I is
			-- Current type
		do
			Result := context.current_type;
		end;

	is_current: BOOLEAN is True;
			-- This is an access to Current

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			current_b: CURRENT_B;
		do
			current_b ?= other;
			Result := current_b /= Void
		end;

	enlarged: CURRENT_BL is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			!!Result;
		end;

	register_name: STRING is
			-- The "Current" string
		do
			Result := Buffer;
			Result.wipe_out;
			Result.append("Current");
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an access to Current
		do
			ba.append (Bc_current);
		end;

end
