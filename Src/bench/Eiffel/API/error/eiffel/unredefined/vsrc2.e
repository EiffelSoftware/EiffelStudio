-- Error for deferred root class

class VSRC2

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature 

	code: STRING is "VSRC";
			-- Error code

	subcode: INTEGER is 2;

end 
