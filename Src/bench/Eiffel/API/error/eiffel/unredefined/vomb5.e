-- Error when there is a positive value in an inspect instruction 
-- involving uniwue features

class VOMB5 

inherit

	VOMB
		redefine
			subcode
		end

feature

	subcode: INTEGER is 5;

end
