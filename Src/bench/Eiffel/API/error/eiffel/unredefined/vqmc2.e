-- Error when a constant value type doesn't match the constant type

class VQMC2 

inherit

	VQMC
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 2;

	constant_value: VALUE_I;
			-- Constant value

	set_constant_value (t: VALUE_I) is	
			-- Assign `t' to `constant_value'.
		do
			constant_value := t;
		end;

end
