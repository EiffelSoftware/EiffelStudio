-- Error when a decalred deferred class has no deferred features

class VCCH2 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature 

	code: STRING is "VCCH";
			-- Error code

	subcode: INTEGER is 2;

end
