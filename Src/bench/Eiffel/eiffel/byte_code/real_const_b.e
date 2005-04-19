indexing
	description: "Real constant for code generation"
	date: "$Date$"
	revision: "$Revision$"

class REAL_CONST_B 

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

	make (v: STRING) is
			-- Assign `v' to `value'.
			-- Remove the '_' signs in the real number.
		require
			v_not_void: v /= Void
			no_undescores_in_v: not v.has ('_')
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Access

	value: STRING
			-- Value to generate

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluation of Current.
		do
			create {REAL_VALUE_I} Result.make_real_64 (value.to_double)
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expresion

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	type: TYPE_I is
			-- Float type
		once
			Result := real64_c_type
		end

feature -- C code generation

	print_register is
			-- Print real value
		do
			buffer.put_string ("(EIF_REAL_64) ")
			buffer.put_string (value)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

	generate_il is
			-- Generate IL code for double constant.
		do
			il_generator.put_real_64_constant (value.to_double)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real manifest constant.
		do
			ba.append (Bc_real64)
			ba.append_double (value.to_double)
		end

invariant
	value_not_void: value /= Void
	value_has_no_undescores: not value.has ('_')

end
