-- Byte code for reverse assignment

class REVERSE_B 

inherit

	ASSIGN_B
		redefine
			enlarged, make_byte_code
		end
	
feature 

	enlarged: REVERSE_BL is
			-- Enlarge current node.	
		do
			!!Result;
			Result.set_target (target.enlarged);
			Result.set_source (source.enlarged);
			Result.set_line_number (line_number)
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a reverse assignment
		local
			cl_type_i: CL_TYPE_I;
			source_type: TYPE_I;
		do
			make_breakable (ba);

				-- Generate expression byte code
			source.make_byte_code (ba);

			source_type ?= context.real_type (source.type);
			target.make_reverse_code (ba, source_type);
		end;
		
end
