-- Assertion has not a boolean expression as condition

class VWBE3 

inherit

	VWBE
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 3;

feature 

	assertion: TAGGED_AS;
			-- Clause involved

	set_assertion (c: TAGGED_AS) is
			-- Assign `c' to `assertion'.
		do
			assertion := c;
		end;

end
