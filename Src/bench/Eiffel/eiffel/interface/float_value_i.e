indexing
	description: "Representation of a REAL constant in source code."
	date: "$Date$"
	revision: "$date: $"

class
	FLOAT_VALUE_I 

inherit
	VALUE_I
		redefine
			generate, is_real
		end
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := real_value = other.real_value
		end

feature -- Access

	real_value: REAL
			-- Real value.

feature -- Settings

	set_real_value (r: like real_value) is
			-- Set `real_value' with `r'.
		do
			real_value := r
		ensure
			real_value_set: real_value = r
		end

feature -- Status Report

	is_real: BOOLEAN is True
			-- Is the current constant a real one ?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_real or t.is_double
		end

feature -- Code generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		local
			l_buf: like buffer
		do
			l_buf := buffer
			l_buf.putstring (real_value.out)
			l_buf.putchar ('f')
		end

	generate_il is
			-- Generate IL code for real constant value.
		do
			il_generator.put_double_constant (real_value)
			Il_generator.convert_to_real
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real constant value
		do
			ba.append (Bc_float)
				--|Note: It is actually a double which
				--|is appended to the byte code despite
				--|the name `append_real'
			ba.append_real (real_value)
		end

feature -- Output

	dump: STRING is
			-- Textual representation of `real_value'.
		do
			Result := real_value.out
		end

end
