indexing
	description: "List of precomputed TYPE_I instances that can be reused."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_TYPE_I
	
feature -- Access

	Boolean_c_type: BOOLEAN_I is
			-- Boolean C type
		once
			create Result
		end

	Char_c_type: CHAR_I is
			-- Char C type
		once
			create Result.make (False)
		end

	Wide_char_c_type: CHAR_I is
			-- Wide char C type
		once
			create Result.make (True)
		end

	Pointer_c_type: POINTER_I is
			-- Pointer C type
		once
			create Result
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
			create Result.make (32)
		end

	int64_c_type: LONG_I is
			-- int64 C type
		once
			create Result.make (64)
		end

	Float_c_type: FLOAT_I is
			-- Float C type
		once
			create Result
		end

	Double_c_type: DOUBLE_I is
			-- Double C type
		once
			create Result
		end

	Reference_c_type: REFERENCE_I is
			-- Reference C type
		once
			create Result
		end

	Void_c_type: VOID_I is
			-- Void C type
		once
			create Result
		end

	None_c_type: NONE_I is
			-- None C type
		once
			create Result
		end

end
