class BIT_CONST_B 

inherit

	EXPR_B
		redefine
			make_byte_code
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

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a bit constant
		do
			-- FIME
		end;

	used (r: REGISTRABLE): BOOLEAN is
            -- Is register `r' used in local or forthcomming dot calls ?
        do
			-- FIXME
        end;

end
