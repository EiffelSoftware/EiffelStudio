class BITS_AS

inherit

	BASIC_TYPE
		redefine
			set, format, append_clickable_signature
		end

feature -- Attributes

	bits_value: INTEGER_AS;
			-- Bits value

feature -- Initialization

	set is
			-- Yacc initilization
		do
			bits_value ?= yacc_arg (0);
		ensure then
			bits_value_exists: bits_value /= Void
		end;

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
			Result.set_base_type (bits_value.value);
		end;

	dump: STRING is
			-- Debug purpose
		do
			!!Result.make (10);
			Result.append ("BITS ");
			Result.append_integer (bits_value.value);
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("BITS ");
			a_clickable.put_int (bits_value.value);
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.always_succeed;
			--ctxt.put_class_name("BITS ");
			ctxt.put_string(bits_value.value.out);
		end

end
