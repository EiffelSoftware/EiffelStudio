-- Error when a constant value type doesn't match the constant type

class VQMC3 

inherit

	VQMC
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 3;

end
