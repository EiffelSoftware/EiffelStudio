-- Error for unvalid renaming

class VHRC1 

inherit

	VHRC
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 1;

end
