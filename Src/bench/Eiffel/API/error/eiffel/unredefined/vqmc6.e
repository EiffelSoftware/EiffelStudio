-- Error when a constant value type doesn't match the constant type

class VQMC6 

inherit

	VQMC
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 6;

end
