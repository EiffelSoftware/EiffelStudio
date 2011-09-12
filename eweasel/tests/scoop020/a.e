class A [G]

feature

	f (x: G; y: separate G)
		local
			xx: G
			yy: separate G
		do
			xx := x
			yy := y
			xx := y -- Error
			yy := x
		end

end