class BIT_CONST_B 

inherit

	EXPR_B
		redefine
			enlarged, make_byte_code, generate_il
		end

feature 

	value: STRING;
			-- Bit value (sequence of 0 and 1)

	set_value (v: STRING) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;

	type: BIT_I is
			-- Integer type
		do
			!!Result;
			Result.set_size (value.count);
		end;

	enlarged: BIT_CONST_BL is
			-- Enlarged node
		do
			!!Result;
			Result.set_value (value)
		end;

	used (r: REGISTRABLE): BOOLEAN is
            -- Is register `r' used in local or forthcomming dot calls ?
        do
        end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for bit constant.
			--| Not applicable
		do
			check False end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a bit constant
		do
			ba.append (Bc_bit);
			ba.append_integer (value.count)
			ba.append_bit (value)
		end;

end
