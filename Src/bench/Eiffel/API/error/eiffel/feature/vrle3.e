-- Error when an access to Result is invalid: invariant or procedure

class VRLE3 obsolete "NOT IN THE BOOK"

inherit
	
	FEATURE_ERROR
		redefine
			subcode
		end;

feature 

	code: STRING is "VEEN";
			-- Error code

	subcode: INTEGER is 2;

end
