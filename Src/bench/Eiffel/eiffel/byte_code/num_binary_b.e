-- Binary expression byte code for a possible numeric expression

deferred class NUM_BINARY_B 

inherit
	BINARY_B
		redefine
			generate_standard_il
		end
	
feature

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (left.type).is_numeric;
		end;

feature -- IL code generation

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		do
			generate_converted_standard_il
		end

end
