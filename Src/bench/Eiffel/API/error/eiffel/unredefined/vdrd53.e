-- Error when an argument type of a redefinition violates the rule
-- of signature conformance

class VDRD53 

inherit

	VDRD51
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 2;

end
