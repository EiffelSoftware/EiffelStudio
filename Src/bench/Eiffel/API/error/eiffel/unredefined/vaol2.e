-- Error when an old expression is not an expression: i.e procedure

class VAOL2 

inherit

	VAOL1
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 2;

end
