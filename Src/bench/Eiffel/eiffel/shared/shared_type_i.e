class SHARED_TYPE_I
	
feature {NONE}

	Boolean_c_type: BOOLEAN_I is
			-- Boolean C type
		once
			!!Result;
		end;

	Char_c_type: CHAR_I is
			-- Char C type
		once
			create Result.make (False)
		end;

	Wide_char_c_type: CHAR_I is
			-- Wide char C type
		once
			create Result.make (True)
		end

	Pointer_c_type: POINTER_I is
			-- Pointer C type
		once
			!! Result
		end

	int8_c_type: LONG_I is
			-- int8 C type
		once
			create Result.make (8)
		end

	int16_c_type: LONG_I is
			-- int16 C type
		once
			create Result.make (16)
		end

	Long_c_type: LONG_I is
			-- long C type
		once
			create Result.make (32);
		end;

	int64_c_type: LONG_I is
			-- int64 C type
		once
			create Result.make (64)
		end

	Float_c_type: FLOAT_I is
			-- Float C type
		once
			!!Result;
		end;

	Double_c_type: DOUBLE_I is
			-- Double C type
		once
			!!Result;
		end;

	Reference_c_type: REFERENCE_I is
			-- Reference C type
		once
			!!Result;
		end;

	Void_c_type: VOID_I is
			-- Void C type
		once
			!!Result;
		end;

	None_c_type: NONE_I is
			-- None C type
		once
			!! Result
		end
end
