-- Error for a rename clause where the old name appears more than once
-- in rename clauses

class VHRC2 

inherit

	VHRC
		redefine
			subcode
		end;

feature

	subcode:INTEGER is 2;

end
