-- A feature name is repeated more than once in export adaptation

class VLEL3 

inherit

	VLEL2
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 3;

end
