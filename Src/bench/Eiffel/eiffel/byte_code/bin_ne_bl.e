class BIN_NE_BL 

inherit

	BIN_NE_B
		redefine
			left_register, set_left_register,
			right_register, set_right_register
		end;
	
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

	fill_from (b: BIN_NE_B) is
			-- Fill `Current' from `b'
		do
			left := b.left.enlarged;
			right := b.right.enlarged;
		end;

end
