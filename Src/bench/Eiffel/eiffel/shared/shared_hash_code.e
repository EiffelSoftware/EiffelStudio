-- Hash code for instance of TYPE_I: search of patterns is done through
-- hash coding in the pattern table.

class SHARED_HASH_CODE
	
feature {NONE}

	Character_code: 	INTEGER is 1
	Wide_char_code: INTEGER is 2

	Boolean_code: 		INTEGER is 3

	Integer8_code:		INTEGER is 4
	Integer16_code:		INTEGER is 5
	Integer32_code:		INTEGER is 6
	Integer64_code:		INTEGER is 7

	Real_32_code:		INTEGER is 8
	Real_64_code:		INTEGER is 9

	Pointer_code:		INTEGER is 10
	
	Typed_pointer_code: INTEGER is 11

	Void_code:			INTEGER is 12

	Reference_code:		INTEGER is 13

	None_code:			INTEGER is 14

	Other_code:			INTEGER is 15

end
