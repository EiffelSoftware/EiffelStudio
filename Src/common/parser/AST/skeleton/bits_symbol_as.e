class BITS_SYMBOL_AS

inherit

	BASIC_TYPE
		redefine
			set, append_clickable_signature
		end

feature -- Attributes

	bits_symbol: ID_AS;
			-- Bits value

feature -- Initialization

	set is
			-- Yacc initilization
		do
			bits_symbol ?= yacc_arg (0);
		ensure then
			bits_symbol_exists: bits_symbol /= Void
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_A is
		local
			vtbt: VTBT;
			constant: CONSTANT_I;
			bits_value: INTEGER;
			error: BOOLEAN;
			int_value: INT_VALUE_I;
		do
			constant ?= feat_table.item (bits_symbol);
			error := constant = Void;
			if not error then
				int_value ?= constant.value;
				error := int_value = Void;
				if not error then
					bits_value := int_value.int_val;
					error := bits_value <= 0;
				end;
			end;
			if error then
				!!vtbt;
				vtbt.set_class (feat_table.associated_class);
				vtbt.set_feature (f);
				if bits_value < 0 then
					vtbt.set_value (bits_value);
				end;
				Error_handler.insert_error (vtbt);
					-- Cannot go on here
				Error_handler.raise_error;
			end;
			check
				positive_bits_value: bits_value > 0;
			end;
			!!Result;
			Result.set_base_type (bits_value);
		end; -- solved_type

	actual_type: BITS_A is
			-- Actual bits type
		do
			-- Do nothing
		ensure then
			False
		end; -- actual_type

	dump: STRING is
			-- Debug purpose
		do
			!!Result.make (5 + bits_symbol.count);
			Result.append ("BITS ");
   		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("BITS ");
		end;

			
end
