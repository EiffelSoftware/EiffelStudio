-- Error for a rename clause an infix is renamed as a prefix
-- or the opposite

class VHRC4 

inherit

	VHRC
		redefine
			subcode
		end;

feature

	subcode:INTEGER is 4;

end
