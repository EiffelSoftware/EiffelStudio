-- Error for a rename clause where the old name appears more than once
-- in rename clauses

class VHRC4 

inherit

	VHRC
		redefine
			subcode
		end;

feature

	subcode:INTEGER is 4;

end
