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
			generate, is_double, unary_minus
		end

create
	make

feature {NONE} -- Initialization

	make (d: like double_value) is
			-- Create instance of current with `double_value' set to `d'.
		do
			double_value := d
		ensure
			double_value_set: double_value = d
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := double_value = other.double_value
		end

feature -- Access

	double_value: DOUBLE
			-- Duble value.

feature -- Status report

	is_double: BOOLEAN is True
			-- Is the current constant a real one ?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_real or t.is_double
		end

feature -- Unary operators

	unary_minus: VALUE_I is
			-- Apply `-' operator to Current.
		do
			create {REAL_VALUE_I} Result.make (-double_value)
		end

feature -- Code generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.putstring (double_value.out)
		end

	generate_il is
			-- Generate IL code for real constant value.
		do
			il_generator.put_double_constant (double_value)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a real constant value
		do
			ba.append (Bc_double)
			ba.append_real (double_value)
		end

feature -- Output

	dump: STRING is
			-- Textual representation of `double_value'.
		do
			Result := double_value.out
		end

end
