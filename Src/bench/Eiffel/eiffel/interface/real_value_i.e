indexing
	description: "[
		Representation of a DOUBLE constant in source code. Name of class is
		not the best one since it is confusion that it is called REAL where it handles DOUBLE.
		]"
	date: "$Date$"
	revision: "$date: $"

class
	REAL_VALUE_I 

inherit
	VALUE_I
		redefine
			generate, is_real_64, is_real_32, unary_minus, set_real_type
		end

create
	make_real_64, make_real_32

feature {NONE} -- Initialization

	make_real_64 (d: like real_64_value) is
			-- Create instance of current with `real_64_value' set to `d'.
		do
			real_64_value := d
			is_real_64 := True
		ensure
			real_64_value_set: real_64_value = d
			is_real_64: is_real_64
		end

	make_real_32 (r: like real_32_value) is
			-- Create instance of current with `real_32_value' set to `r'.
		do
			real_32_value := r
			is_real_64 := False
		ensure
			real_32_value_set: real_32_value = r
			not_is_real_64: not is_real_64
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := (is_real_64 = other.is_real_64) and 
				(real_64_value = other.real_64_value) and
				(real_32_value = other.real_32_value)
		end

feature -- Access

	real_64_value: DOUBLE
			-- Double value.

	real_32_value: REAL
			-- Real value.

feature -- Status report

	is_real_64: BOOLEAN
			-- Is the current constant a double one?
			
	is_real_32: BOOLEAN is
			-- Is current constant a real one?
		do
			Result := not is_real_64
		end
		
	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_real_32 or t.is_real_64
		end

feature -- Settings

	set_real_type (t: TYPE_A) is
			-- Update current value accordingly to context `t'.
		local
			l_is_real_64: BOOLEAN
		do
			l_is_real_64 := is_real_64
			if t.is_real_64 /= l_is_real_64 then
				if l_is_real_64 then
						-- Convert `real_64_value' to `real_32_value'.
					real_32_value := real_64_value
					real_64_value := 0.0
				else
						-- Convert `real_32_value' to `real_64_value'.
					real_64_value := real_32_value
					real_32_value := 0.0
				end
				is_real_64 := not l_is_real_64
			end
		end
		
feature -- Unary operators

	unary_minus: VALUE_I is
			-- Apply `-' operator to Current.
		do
			if is_real_64 then
				create {REAL_VALUE_I} Result.make_real_64 (-real_64_value)
			else
				create {REAL_VALUE_I} Result.make_real_32 (-real_32_value)
			end
		end

feature -- Code generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		local
			l_buf: like buffer
			l_val: STRING
			l_nb: INTEGER
		do
			l_buf := buffer
			if is_real_64 then
				l_val := real_64_value.out
			else
				l_val := real_32_value.out
			end
			l_buf.put_string (l_val)
			l_nb := l_val.count
			if
				l_val.last_index_of ('.', l_nb) = 0 and
				l_val.last_index_of ('e', l_nb) = 0
			then
				l_buf.put_character ('.')
			end
			if is_real_32 then
				l_buf.put_character ('f')
			end
		end

	generate_il is
			-- Generate IL code for real constant value.
		do
			if is_real_64 then
				il_generator.put_double_constant (real_64_value)
			else
				il_generator.put_double_constant (real_32_value)
				il_generator.convert_to_real
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real constant value
		do
			if is_real_64 then
				ba.append (Bc_real64)
				ba.append_double (real_64_value)
			else
				ba.append (Bc_real32)
				ba.append_double (real_32_value)
			end
		end

feature -- Output

	dump: STRING is
			-- Textual representation of `real_64_value'.
		do
			if is_real_64 then
				Result := real_64_value.out
			else
				Result := real_32_value.out
			end
		end

invariant
	is_real_64_or_real_32: is_real_64 = not is_real_32

end
