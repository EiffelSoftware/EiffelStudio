-- Binary expression byte code for a possible numeric expression

deferred class NUM_BINARY_B 

inherit
	BINARY_B
		redefine
			generate_standard_il,
			print_register
		end
	
feature

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := real_type (left.type).is_numeric
		end

feature -- Status report

	is_reverted: BOOLEAN is
			-- Has result of expression to be converted back to original type of expression
			-- so that result does not depend on implicit conversion performed by an underlying
			-- platform to a type with higher precision?
		do
				-- False by default
		end

feature -- C code generation

	print_register is
			-- Print expression value
		do
			if is_reverted and then is_c_promoted then
				c_type.generate_cast (buffer)
			end
			Precursor
		end

feature -- IL code generation

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		do
			generate_converted_standard_il
			if is_reverted and then is_il_promoted then
				il_generator.convert_to (real_type (type))
			end
		end

end
