class Y

inherit
	X
		redefine
			b
		end

feature

	set_1 is
		do
			b := 1B
		end

	b: BIT 1

end
