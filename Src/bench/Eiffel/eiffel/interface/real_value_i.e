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
			generate, is_double, is_real, unary_minus, set_real_type
		end

create
	make_double, make_real

feature {NONE} -- Initialization

	make_double (d: like double_value) is
			-- Create instance of current with `double_value' set to `d'.
		do
			double_value := d
			is_double := True
		ensure
			double_value_set: double_value = d
			is_double: is_double
		end

	make_real (r: like real_value) is
			-- Create instance of current with `real_value' set to `r'.
		do
			real_value := r
			is_double := False
		ensure
			real_value_set: real_value = r
			not_is_double: not is_double
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := (is_double = other.is_double) and 
				(double_value = other.double_value) and
				(real_value = other.real_value)
		end

feature -- Access

	double_value: DOUBLE
			-- Double value.

	real_value: REAL
			-- Real value.

feature -- Status report

	is_double: BOOLEAN
			-- Is the current constant a double one?
			
	is_real: BOOLEAN is
			-- Is current constant a real one?
		do
			Result := not is_double
		end
		
	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_real or t.is_double
		end

feature -- Settings

	set_real_type (t: TYPE_A) is
			-- Update current value accordingly to context `t'.
		local
			l_is_double: BOOLEAN
		do
			l_is_double := is_double
			if t.is_double /= l_is_double then
				if l_is_double then
						-- Convert `double_value' to `real_value'.
					real_value := double_value
					double_value := 0.0
				else
						-- Convert `real_value' to `double_value'.
					double_value := real_value
					real_value := 0.0
				end
				is_double := not l_is_double
			end
		end
		
feature -- Unary operators

	unary_minus: VALUE_I is
			-- Apply `-' operator to Current.
		do
			if is_double then
				create {REAL_VALUE_I} Result.make_double (-double_value)
			else
				create {REAL_VALUE_I} Result.make_real (-real_value)
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
			if is_double then
				l_val := double_value.out
			else
				l_val := real_value.out
			end
			l_buf.put_string (l_val)
			l_nb := l_val.count
			if
				l_val.last_index_of ('.', l_nb) = 0 and
				l_val.last_index_of ('e', l_nb) = 0
			then
				l_buf.put_character ('.')
			end
			if is_real then
				l_buf.put_character ('f')
			end
		end

	generate_il is
			-- Generate IL code for real constant value.
		do
			if is_double then
				il_generator.put_double_constant (double_value)
			else
				il_generator.put_double_constant (real_value)
				il_generator.convert_to_real
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real constant value
		do
			if is_double then
				ba.append (Bc_double)
				ba.append_double (double_value)
			else
				ba.append (Bc_float)
				ba.append_double (real_value)
			end
		end

feature -- Output

	dump: STRING is
			-- Textual representation of `double_value'.
		do
			if is_double then
				Result := double_value.out
			else
				Result := real_value.out
			end
		end

invariant
	is_double_or_real: is_double = not is_real

end
