class CHAR_CONST_B 

inherit

	EXPR_B
		redefine
			print_register, make_byte_code,
			is_simple_expr, is_predefined, generate_il
		end;
	
feature 

	value: CHARACTER;
			-- Character value

	set_value (v: CHARACTER) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;

	type: TYPE_I is
			-- Expression type
		once
			Result := Char_c_type;
		end;

	print_register is
			-- Print the character constant
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("(EIF_CHARACTER) %'");
			buf.escape_char (buf,value);
			buf.putchar ('%'');
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end;

	is_simple_expr: BOOLEAN is true;
			-- A constant is a simple expression

	is_predefined: BOOLEAN is true
			-- A constant is a predefined structure.

feature -- IL code generation

	generate_il is
			-- Generate IL code for character constant
		do
			il_generator.put_character_constant (value)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest character constant
		do
			ba.append (Bc_char);
			ba.append (value);
		end;

end
