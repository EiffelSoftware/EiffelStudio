class BITS_SYMBOL_AS_B

inherit

	BITS_SYMBOL_AS
		undefine
			same_as, associated_eiffel_class,
			append_to
		redefine
			bits_symbol
		end;

	BASIC_TYPE_B
		undefine
			set, is_equivalent
		redefine
			append_to
		end

feature -- Attributes

	bits_symbol: ID_AS_B;
			-- Bits value

feature 

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_SYMBOL_A is
		local
			vtbt: VTBT;
			veen: VEEN;
			constant: CONSTANT_I;
			bits_value: INTEGER;
			error: BOOLEAN;
			int_value: INT_VALUE_I;
			depend_unit: DEPEND_UNIT;
		do
			if not feat_table.has (bits_symbol) then
				!! veen;
				veen.set_class (feat_table.associated_class);
				veen.set_feature (f);
				veen.set_identifier (bits_symbol);
				Error_handler.insert_error (veen);
				Error_handler.raise_error
			end;
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
			!!Result.make (constant);
			Result.set_bit_count (bits_value);
			if System.in_pass3 then
				!!depend_unit.make (context.a_class.id, constant.feature_id);
				context.supplier_ids.extend (depend_unit);
			end;
		end; -- solved_type

	actual_type: BITS_A is
			-- Actual bits type
		do
			-- Do nothing
		ensure then
			False
		end; -- actual_type

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("BIT ");
			st.add_string (bits_symbol);
		end;

end -- class BITS_SYMBOL_AS_B
