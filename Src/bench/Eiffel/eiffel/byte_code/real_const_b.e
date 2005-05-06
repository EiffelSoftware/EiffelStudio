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

	make (v: STRING; a_type: TYPE_A) is
			-- Assign `v' to `value'.
			-- Remove the '_' signs in the real number.
		require
			v_not_void: v /= Void
			no_undescores_in_v: not v.has ('_')
			a_type_not_void: a_type /= Void
		do
			value := v
			if a_type.is_real_64 then
				real_size := 64
			else
				real_size := 32
			end
		ensure
			value_set: value = v
			real_size_set: real_size = 32 or real_size = 64
		end

feature -- Access

	value: STRING
			-- Value to generate

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluation of Current.
		do
			if real_size = 64 then
				create {REAL_VALUE_I} Result.make_real_64 (value.to_double)
			else
				create {REAL_VALUE_I} Result.make_real_32 (value.to_real)
			end
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expresion

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	real_size: NATURAL_8
			-- Size of REAL constant

	type: TYPE_I is
			-- Float type
		do
			if real_size = 64 then
				Result := real64_c_type
			else
				Result := real32_c_type
			end
		end

feature -- C code generation

	print_register is
			-- Print real value
		do
			if real_size = 64 then
				buffer.put_string ("(EIF_REAL_64) ")
			else
				buffer.put_string ("(EIF_REAL_32) ")
			end
			buffer.put_string (value)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is True
			-- Is expression calculation as fast as loading a local?

	generate_il is
			-- Generate IL code for double constant.
		do
			if real_size = 64 then
				il_generator.put_real_64_constant (value.to_double)
			else
				il_generator.put_real_32_constant (value.to_real)
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real manifest constant.
		do
			if real_size = 64 then
				ba.append (Bc_real32)
			else
				ba.append (Bc_real64)
			end
			ba.append_double (value.to_double)
		end

invariant
	value_not_void: value /= Void
	value_has_no_undescores: not value.has ('_')
	real_size_valid: real_size = 32 or real_size = 64
end
