class UN_MINUS_B 

inherit

	UNARY_B
		rename
			Bc_uminus as operator_constant,
			Il_uminus as il_operator_constant
		redefine
			generate_operator, is_built_in,
			generate_il,
			print_register
		end
	
feature

	generate_operator is
			-- Generate the unary operator
		local
			l_buf: like buffer
		do
			l_buf := buffer
				-- Space is important here otherwise eweasel test ccomp042
				-- would fail like in `d := - - 3.5'.
			l_buf.put_character (' ')
			l_buf.put_character ('-')
		end

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_numeric
		end

	print_register is
			-- Print expression value
		do
			if is_c_promoted then
					-- Result has to be converted to original type, because C promotes "char" and "short" to "int"
				c_type.generate_cast (buffer)
			end
			Precursor
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for an unary expression
		do
			Precursor
			if is_il_promoted then
					-- Result has to be converted to original type, because IL promotes "int8" and "in16" to "int32"
				il_generator.convert_to (real_type (type))
			end
		end

end
