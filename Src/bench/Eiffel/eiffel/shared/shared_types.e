class SHARED_TYPES
	
feature {NONE}

	Integer_8_type: INTEGER_A is
			-- Actual integer type of 8 bits
		once
			create Result.make (8)
		end

	Integer_16_type: INTEGER_A is
			-- Actual integer type of 16 bits
		once
			create Result.make (16)
		end

	Integer_type: INTEGER_A is
			-- Actual integer type of 32 bits
		once
			create Result.make (32)
		end

	Integer_64_type: INTEGER_A is
			-- Actual integer type of 64 bits
		once
			create Result.make (64)
		end

	Boolean_type: BOOLEAN_A is
			-- Actual boolean type
		once
			create Result
		end

	Character_type: CHARACTER_A is
			-- Actual character type
		once
			create Result.make (False)
		end

	Wide_char_type: CHARACTER_A is
			-- Actual wide character type
		once
			create Result.make (True)
		end

	Real_type: REAL_A is
			-- Actual real type
		once
			create Result
		end

	Double_type: DOUBLE_A is
			-- Actual double type
		once
			create Result
		end

	Void_type: VOID_A is
			-- Actual void type
		once
			create Result
		end

	Pointer_type: POINTER_A is
			-- Actual pointer type
		once
			create Result
		end

end
