-- Byte code for semi-strict "implies"

class
	B_IMPLIES_B 

inherit
	BOOL_BINARY_B
		redefine
			built_in_enlarged, print_register, make_standard_byte_code,
			generate_il
		end
	
feature 

	built_in_enlarged: B_IMPLIES_BL is
			-- Enlarge node
		do
			!!Result;
			Result.init (access.enlarged);
			Result.set_left (left.enlarged);
			Result.set_right (right.enlarged);
		end;

	print_register is
			-- Print the expression
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("(!(");
			left.print_register;
			buf.putstring (") || (");
			right.print_register;
			buf.putstring ("))");
		end;

feature -- IL code generation

	il_operator_constant: INTEGER is
			-- IL code constant associated to current binary operation.
		do
			check False end
		end

	generate_il is
			-- Generate IL code for `implies' expression.
		local
			unary_not: UN_NOT_B
			binary_or_else: B_OR_ELSE_B
		do
			create unary_not
			unary_not.set_expr (left)
			create binary_or_else
			binary_or_else.set_left (unary_not)
			binary_or_else.set_right (right)
			binary_or_else.generate_standard_il
		end

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			-- Do nothing
		ensure then
			False
		end; -- operator_constant

	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		local
			unary_not: UN_NOT_B;
			binary_or_else: B_OR_ELSE_B;
		do
			!!unary_not;
			unary_not.set_expr (left);
			!!binary_or_else;
			binary_or_else.set_left (unary_not);
			binary_or_else.set_right (right);
			binary_or_else.make_standard_byte_code (ba);
		end;

end
