-- Byte code for "or else"

class B_OR_ELSE_B 

inherit

	BOOL_BINARY_B
		rename
			Bc_or as operator_constant
		redefine
			built_in_enlarged, generate_operator, make_standard_byte_code,
			is_commutative
		end;
	
feature 

	built_in_enlarged: B_OR_ELSE_BL is
			-- Enlarge node
		do
			!!Result;
			Result.init (access.enlarged);
			Result.set_left (left.enlarged);
			Result.set_right (right.enlarged);
		end;

	generate_operator is
			-- Generate the operator
		do
			buffer.putstring (" || ");
		end;

	is_commutative: BOOLEAN is
			-- Is operation commutative ?
		do
			Result := not has_call;
		end;

feature -- Byte code generation

	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		do
			left.make_byte_code (ba);
			ba.append (Bc_or_else);
			ba.mark_forward;
			right.make_byte_code (ba);
			ba.append (operator_constant); -- Bc_or
			ba.write_forward;
		end;

end
