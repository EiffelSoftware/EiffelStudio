-- Byte code for Eiffel string (allocated each time).

class STRING_B 

inherit

	EXPR_B
		redefine
			enlarged, make_byte_code, generate_il
		end;
	
feature 

	value: STRING;
			-- Character value

	set_value (v: STRING) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;

	type: CL_TYPE_I is
			-- String type
		once
			!!Result;
			Result.set_base_id (System.string_id);
		end;

	enlarged: STRING_BL is
			-- Enlarge node
		do
			!!Result;
			Result.set_value (value);
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Register `r' is not used for string value computation
		do
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for a manifest string.
		do
			il_generator.put_manifest_string (value)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest string
		do
			ba.append (Bc_string)
			ba.append_integer (value.count)
			ba.append_raw_string (value)
		end;

end
