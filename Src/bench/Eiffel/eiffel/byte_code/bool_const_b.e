class BOOL_CONST_B 

inherit

	EXPR_B
		redefine
			print_register, make_byte_code
		end;
	
feature 

	value: BOOLEAN;
			-- Boolean value

	set_value (v: BOOLEAN) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;

	type: TYPE_I is
			-- Boolean type
		once
			Result := Boolean_c_type;
		end;

	print_register is
			-- Print boolean constant
		do
			if value then
				buffer.putstring ("(char) 1");
			else
				buffer.putstring ("(char) 0");
			end;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a boolean constant
		do
			ba.append (Bc_bool);
			if value then
				ba.append ('%/001/');
			else
				ba.append ('%U');
			end;
		end;

end
