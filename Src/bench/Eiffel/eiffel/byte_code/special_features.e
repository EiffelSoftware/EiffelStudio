class SPECIAL_FEATURES

inherit

	BYTE_CONST

feature -- Access

	has (feature_name: STRING): BOOLEAN is
			-- Does Current have `feature_name'?
		do
			Result :=
				feature_name.is_equal ("is_equal") or else
				feature_name.is_equal ("standard_is_equal") or else
				feature_name.is_equal ("deep_equal") or else
				feature_name.is_equal ("standard_deep_equal")
		end

feature -- Byte code

	bc_code: CHARACTER is
			-- Byte code constant associated to current special
			-- feature from find.
		do
			Result := Bc_eq 
		end

	c_operation: STRING is
			-- C code constant associated to current special
			-- feature from find.
		do
			Result := "==" 
		end;

end
