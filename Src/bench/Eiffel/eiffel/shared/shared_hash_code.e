-- Hash code for instance of TYPE_I: search of patterns is done through
-- hash coding in the pattern table.

class SHARED_HASH_CODE
	
feature {NONE}

	Character_code: 	INTEGER is 1;

	Boolean_code: 		INTEGER is 2;

	Integer_code:		INTEGER is 3;

	Real_code:			INTEGER is 4;

	Double_code:		INTEGER is 5;

	Pointer_code:		INTEGER is 6;

	Void_code:			INTEGER is 7;

	Reference_code:		INTEGER is 8;

	None_code:			INTEGER is 9;

	Other_code:			INTEGER is 10;

end
