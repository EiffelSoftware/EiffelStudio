indexing
	description: "Character constant for code generation"
	date: "$Date$"
	revision: "$Revision$"

class CHAR_CONST_B 

inherit
	EXPR_B
		redefine
			print_register, make_byte_code, evaluate,
			is_simple_expr, is_predefined, generate_il,
			is_fast_as_local
		end

create
	make

feature {NONE} -- Initialization

	make (v: CHARACTER) is
			-- Assign `v' to `value'.
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Access

	value: CHARACTER
			-- Character value

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluation of Current.
		do
			create {CHAR_VALUE_I} Result.make (value)
		end

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

feature -- C code generation

	print_register is
			-- Print the character constant
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("(EIF_CHARACTER) %'")
			buf.escape_char (value)
			buf.put_character ('%'')
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

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
