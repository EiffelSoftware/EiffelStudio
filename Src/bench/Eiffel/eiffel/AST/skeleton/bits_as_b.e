class BITS_AS_B

inherit

	BITS_AS
		undefine
			same_as, associated_eiffel_class,
			append_to
		redefine
			bits_value
		end;

	BASIC_TYPE_B
		undefine
			set, is_equivalent
		redefine
			set
		end

feature -- Attributes

	bits_value: INTEGER_AS_B;
			-- Bits value

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		local
			vtbt: VTBT;
		do
			if (bits_value.value <= 0) then
				!!vtbt;
				vtbt.set_class (feat_table.associated_class);
				vtbt.set_feature (f);
				vtbt.set_value (bits_value.value);
				Error_handler.insert_error (vtbt);
					-- Cannot go on here
				Error_handler.raise_error;
			end;
			Result := actual_type;
		end;

	actual_type: BITS_A is
			-- Actual bits type
		do
			!!Result;
			Result.set_bit_count (bits_value.value);
		end;

end -- class BITS_AS_B
