-- Error when an attribute name appears more than once in the attribute
-- name list of a strip expression

class VWST2 

inherit

	VWST1
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 2;

end
