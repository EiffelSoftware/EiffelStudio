indexing
	description: "Character constant for code generation"
	date: "$Date$"
	revision: "$Revision$"

class CHAR_CONST_B

inherit
	EXPR_B
		redefine
			print_register, evaluate,
			is_simple_expr, is_predefined,
			is_fast_as_local, is_constant_expression
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

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_char_const_b (Current)
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

	is_constant_expression: BOOLEAN is True
			-- A character constant is constant.

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

end -- class CHAR_CONST_B
