indexing
	description: "Real constant for code generation"
	date: "$Date$"
	revision: "$Revision$"

class REAL_CONST_B 

inherit
	EXPR_B
		redefine
			print_register, make_byte_code,
			is_simple_expr, is_predefined, generate_il
		end
	
feature -- Access

	value: STRING
			-- Value to generate

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expresion

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	type: TYPE_I is
			-- Float type
		once
			Result := Double_c_type
		end

feature -- Settings

	set_value (v: STRING) is
			-- Assign `v' to `value'.
			-- Remove the '_' signs in the real number.
		do
			value := v
			value.replace_substring_all ("_","")
		end

feature -- C code generation

	print_register is
			-- Print real value
		do
			buffer.putstring (value)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for double constant.
		do
			il_generator.put_double_constant (value.to_double)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real manifest constant.
		do
			ba.append (Bc_double)
			ba.append_real (value.to_double)
		end

end
