-- Error when the argument number rule for redefinition is violated

class VDRD52 

inherit

	VDRD5
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 2;

end
