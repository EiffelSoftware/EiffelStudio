indexing
	description: "Boolean constant for code generation"
	date: "$Date$"
	revision: "$Revision$"

class BOOL_CONST_B 

inherit
	EXPR_B
		redefine
			print_register, make_byte_code, generate_il,
			is_simple_expr, is_predefined, evaluate
		end
	
feature -- Access

	value: BOOLEAN
			-- Boolean value

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluation of Current.
		do
			create {BOOL_VALUE_I} Result.make (value)
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expression.

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	type: TYPE_I is
			-- Boolean type
		once
			Result := Boolean_c_type
		end

feature -- Settings

	set_value (v: BOOLEAN) is
			-- Assign `v' to `value'.
		do
			value := v
		end

feature -- C code generation

	print_register is
			-- Print boolean constant
		do
			if value then
				buffer.putstring ("(EIF_BOOLEAN) 1")
			else
				buffer.putstring ("(EIF_BOOLEAN) 0")
			end
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for boolean constant.
		do
			il_generator.put_boolean_constant (value)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a boolean constant
		do
			ba.append (Bc_bool)
			if value then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end
		end

end -- class BOOL_CONST_B
