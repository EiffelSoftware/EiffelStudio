class SHARED_TYPES
	
feature {NONE}

	natural_8_type: NATURAL_A is
			-- Actual integer type of 8 bits
		once
			create Result.make (8)
		end

	natural_16_type: NATURAL_A is
			-- Actual integer type of 16 bits
		once
			create Result.make (16)
		end

	natural_32_type: NATURAL_A is
			-- Actual integer type of 32 bits
		once
			create Result.make (32)
		end

	natural_64_type: NATURAL_A is
			-- Actual integer type of 64 bits
		once
			create Result.make (64)
		end

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

	Real_32_type: REAL_32_A is
			-- Actual real 32 bits type
		once
			create Result
		end

	Real_64_type: REAL_64_A is
			-- Actual real 64 bits type
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
		
	None_type: NONE_A is
			-- Actual NONE type
		once
			create Result
		end

end
