-- Byte code for assignment

class ASSIGN_B 

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged, make_byte_code
		end;
	
feature 

	target: ACCESS_B;
			-- Target of the assignment

	source: EXPR_B;
			-- Source of the assignment

	set_target (t: ACCESS_B) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	set_source (s: EXPR_B) is
			-- Assign `s' to `source'.
		do
			source := s;
		end;

	need_enlarging: BOOLEAN is true;
			-- This node needs enlarging

	enlarged: ASSIGN_BL is
			-- Enlarge current node.
		local
			attr: ATTRIBUTE_B;
		do
			!!Result;
			Result.set_target (target.enlarged);
			Result.set_source (source.enlarged);
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an assignment
		local
			source_type: TYPE_I;
		do
				-- Generate expression byte code
			source.make_byte_code (ba);

				-- Generate assignment header depending of the type
				-- of the target (local, attribute or result).
			source_type ?= context.real_type (source.type);
			target.make_assignment_code (ba, source_type);

		end;

end
