-- Error for generic root class

class VSRC1 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature 

	code: STRING is "VSRC";
			-- Error code

	subcode: INTEGER is 1;

end 
