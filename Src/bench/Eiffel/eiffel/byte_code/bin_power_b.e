class BIN_POWER_B 

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_built_in
		end

feature

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" POWER ");
		end;

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_power
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		local
			left_type: TYPE_I;
		do
			left_type := context.real_type (type);
			Result := left_type.is_float or else left_type.is_double;
		end;

end
