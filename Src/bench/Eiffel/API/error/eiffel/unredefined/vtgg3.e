-- Error when a local type violated the constrained genericity validity
-- rule

class VTGG3 

inherit

	VTGG2
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 3;

end
