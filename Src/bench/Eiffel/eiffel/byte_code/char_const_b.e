indexing
	description: "Character constant for code generation"
	date: "$Date$"
	revision: "$Revision$"

class CHAR_CONST_B 

inherit
	EXPR_B
		redefine
			print_register, make_byte_code,
			is_simple_expr, is_predefined, generate_il
		end
	
feature -- Access

	value: CHARACTER
			-- Character value

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expression

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	type: TYPE_I is
			-- Expression type
		once
			Result := Char_c_type
		end

feature -- Settings

	set_value (v: CHARACTER) is
			-- Assign `v' to `value'.
		do
			value := v
		end

feature -- C code generation

	print_register is
			-- Print the character constant
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("(EIF_CHARACTER) %'")
			buf.escape_char (buf, value)
			buf.putchar ('%'')
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

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
			ba.append (Bc_char)
			ba.append (value)
		end

end -- class CHAR_CONST_B
