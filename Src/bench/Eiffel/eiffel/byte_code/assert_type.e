deferred class ASSERT_TYPE 
	
feature

	In_precondition: INTEGER is 1;
			-- Assertion is a precondition
	
	In_postcondition: INTEGER is 2;
			-- Assertion is a postcondition
	
	In_check: INTEGER is 3;
			-- Assertion is a check

	In_loop_invariant: INTEGER is 4;
			-- Assertion in a loop

	In_loop_variant: INTEGER is 5;
			-- Variant in a loop

	In_invariant: INTEGER is 6;
			-- Class invariant

	generated_file: INDENT_FILE is
			-- File used for C code generation
		deferred
		end;

	generate_assertion_code (i: INTEGER) is
			-- Write the exception code associated with assertion code `i'
		do
			inspect i
			when In_precondition then
				generated_file.putstring ("EX_PRE");
			when In_postcondition then
				generated_file.putstring ("EX_POST");
			when In_check then
				generated_file.putstring ("EX_CHECK");
			when In_loop_invariant then
				generated_file.putstring ("EX_LINV");
			when In_loop_variant then
				generated_file.putstring ("EX_VAR");
			when In_invariant then
				generated_file.putstring ("(where ? EX_CINV:EX_INVC)");
			end;
		end;

end
