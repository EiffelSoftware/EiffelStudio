class BIN_EQ_BL 

inherit

	BIN_EQ_B
		redefine
			left_register, set_left_register,
			right_register, set_right_register
		end;

create
	make
	
feature {NONE} -- Initialization

	make (a_left: like left; a_right: like right) is
			-- Create new BIN_EQ_BL instance with `a_left' and `a_right'.
		require
			a_left_not_void: a_left /= Void
			a_right_not_void: a_right /= Void
		do
			left := a_left
			right := a_right
		ensure
			left_set: left = a_left
			right_set: right = a_right
		end
	
feature

	left_register: REGISTRABLE;
			-- Where metamorphosed left value is kept
		
	right_register: REGISTRABLE;
			-- Where metamorphosed right value is kept
	
	set_left_register (r: REGISTRABLE) is
			-- Assign `r' to `left_register'
		do
			left_register := r;
		end;
	
	set_right_register (r: REGISTRABLE) is
			-- Assign `r' to `right_register'
		do
			right_register := r;
		end;

end
