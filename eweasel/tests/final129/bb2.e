class BB2

inherit

	BB1
		redefine
			z
		end

feature

	z: ZZ2
		do
			check False then end
		end

end