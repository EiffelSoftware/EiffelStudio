class INT_VALUE_I 

inherit

	VALUE_I
		redefine
			generate, is_integer, is_equal, is_propagation_equivalent
		end
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := int_val = other.int_val
		end

feature 

	int_val: INTEGER
			-- Integer constant value

	set_int_val (i: INTEGER) is
			-- Assign `i' to `int_val'.
		do
			int_val := i
		end

	is_integer: BOOLEAN is
			-- Is the current constant a boolean one ?
		do
			Result := True
		end

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_integer
		end

	is_equal (other: INT_VALUE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := int_val = other.int_val
		end

	is_propagation_equivalent (other: INT_VALUE_I): BOOLEAN is
		do
			Result := same_type (other) and then int_val = other.int_val
		end

	generate (file: INDENT_FILE) is
			-- Generate value in `file'.
			-- The '()' are present for the case where int_val=INT32_MIN,
			-- ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		do
			file.putchar('(')
			file.putint (int_val)
			file.putstring ("L)")
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant value.
		do
			ba.append (Bc_int)
			ba.append_integer (int_val)
		end

	vqmc: VQMC is
		do
			!VQMC3!Result
		end

	dump: STRING is
		do
			Result := int_val.out
		end

end
