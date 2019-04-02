class CC2

inherit

	CC1
		redefine
			b
		end

feature

	b: BB2
		do
			check False then end
		end

end