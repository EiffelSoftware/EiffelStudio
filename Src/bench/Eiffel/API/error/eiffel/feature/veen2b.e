-- Error when a local entity is used in a precondition or a postcondition

class VEEN2B 

inherit

	VEEN
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 22;

end
