-- Error when an access to Result is invalid: invariant or procedure

class VRLE3 obsolete "NOT IN THE BOOK"

inherit
	
	FEATURE_ERROR
		redefine
			subcode
		end;

feature 

	code: STRING is "VRLE";
			-- Error code

	subcode: INTEGER is 3;

end
