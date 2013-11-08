class B

inherit
	A [B, B, B, B]

	E1
		rename
			parentheses as pe1,
			this as this_e1
		redefine
			this_e1
		end

	E2
		rename
			parentheses as pe2,
			this as this_e2
		redefine
			this_e2
		end
	
	I1
		rename
			parentheses as pi1,
			this as this_i1
		redefine
			this_i1
		end
	
	I2
		rename
			parentheses as pi2,
			this as this_i2
		redefine
			this_i2
		end

feature

	this_e1: E1
		do
			io.put_string (Precursor (11)); io.put_new_line
			Result := Current
		end

	this_e2: E2
		do
			io.put_string (Precursor (12, 13)); io.put_new_line
			Result := Current
		end

	this_i1: I1
		do
			Precursor (14)
			Result := Current
		end

	this_i2: I2
		do
			Precursor (15, 16)
			Result := Current
		end

end