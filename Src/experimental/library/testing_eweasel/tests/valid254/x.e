class X

feature

	set_2 is
		do
			b := not (b xor b)
		end

	b: BIT 2

end
