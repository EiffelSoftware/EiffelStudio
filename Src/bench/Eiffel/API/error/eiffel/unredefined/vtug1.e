-- Error when the result type of a feature has not the good number of
-- generic parameter

class VTUG1 

inherit

	VTUG
		redefine
			subcode
		end;

feature 

	code: STRING is "VTUG";

	subcode: INTEGER is
		do
			NOT_USED;
		end;

end
