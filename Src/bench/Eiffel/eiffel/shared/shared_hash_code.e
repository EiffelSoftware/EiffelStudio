-- Hash code for instance of TYPE_I: search of patterns is done through
-- hash coding in the pattern table.

class SHARED_HASH_CODE
	
feature {NONE}

	Character_code: INTEGER is 1
	Wide_char_code: INTEGER is 2

	Boolean_code: INTEGER is 3

	Integer_8_code: INTEGER is 4
	Integer_16_code: INTEGER is 5
	Integer_32_code: INTEGER is 6
	Integer_64_code: INTEGER is 7
	
	natural_8_code: INTEGER is 8
	natural_16_code: INTEGER is 9
	natural_32_code: INTEGER is 10
	natural_64_code: INTEGER is 11

	Real_32_code: INTEGER is 12
	Real_64_code: INTEGER is 13

	Pointer_code: INTEGER is 14
	
	Typed_pointer_code: INTEGER is 15

	Void_code: INTEGER is 16

	Reference_code: INTEGER is 17

	None_code: INTEGER is 18

	Other_code: INTEGER is 19

end
