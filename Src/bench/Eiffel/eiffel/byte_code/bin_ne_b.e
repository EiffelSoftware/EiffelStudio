class BIN_NE_B 

inherit

	BIN_EQUAL_B
		rename
			generate_equal as generate_equal_test
		redefine
			generate_operator, enlarged		
		end;

	BIN_EQUAL_B
		redefine
			generate_equal,
			generate_operator, enlarged
		select
			generate_equal
		end;
	
feature

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" != ");
		end;

	generate_boolean_constant is
			-- Generate true constant
		do
			generated_file.putstring ("'\01'");
		end;
	
	generate_equal is
			-- Generate non-equality
		do
			generated_file.putchar ('!');
			generate_equal_test;
		end;

	enlarged: BIN_NE_BL is
			-- Enlarge node
		do
			!!Result;
			Result.fill_from (Current);
		end;

feature -- Byte code generation
	
	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_ne
		end;

	obvious_operator_constant: CHARACTER is
			-- Byte code constant associated to an obvious true
			-- comparison
		do
			Result := Bc_true_compar;
		end;

	expanded_operator_constant: CHARACTER is
			-- Byte code constant associated to current expanded
			-- unequality
		do
			Result := Bc_not_standard_equal;
		end;

end
