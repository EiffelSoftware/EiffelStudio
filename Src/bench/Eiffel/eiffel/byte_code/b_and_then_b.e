-- Byte code for "and then"

class B_AND_THEN_B 

inherit

	BOOL_BINARY_B
		rename
			Bc_and as operator_constant,
			il_and as il_operator_constant
		redefine
			built_in_enlarged, generate_operator,
			is_commutative, make_standard_byte_code,
			generate_standard_il
		end
	
feature 

	built_in_enlarged: B_AND_THN_BL is
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
			buffer.putstring (" && ");
		end;

	
	is_commutative: BOOLEAN is
			-- Is operation commutative ?
		do
			Result := not has_call;
		end;

feature -- IL code generation

	generate_standard_il is
			-- Generate IL code for `and then' expression.
		local
			and_then_label, final_label: IL_LABEL
		do
			and_then_label := il_label_factory.new_label
			final_label := il_label_factory.new_label
			generate_il_with_label (and_then_label, final_label)
			il_generator.branch_to (final_label)
			il_generator.mark_label (and_then_label)
			il_generator.put_boolean_constant (False)
			il_generator.mark_label (final_label)
		end

	generate_il_with_label (and_then_label, final_label: IL_LABEL) is
		local
			b: like Current
		do
			b ?= left
			if b /= Void then
				b.generate_il_with_label (and_then_label, final_label)
			else
				left.generate_il
			end
			il_generator.branch_on_false (and_then_label)
			right.generate_il
		end

feature -- Byte code generation
	
	make_standard_byte_code (ba: BYTE_ARRAY) is
			-- Generate standard byte code for binary expression
		do
			left.make_byte_code (ba);
			ba.append (Bc_and_then);
			ba.mark_forward;
			right.make_byte_code (ba);
			ba.append (operator_constant); -- Bc_and
			ba.write_forward;
		end;
			
end
