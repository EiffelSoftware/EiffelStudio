-- Error when the result type of a feature has not the good number of
-- generic parameter

class VTUG1 

inherit

	VTUG
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 1

end
