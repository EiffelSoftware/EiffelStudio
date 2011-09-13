class A [G]

feature

	f (x: G; y: separate G)
		local
			xx: G
			yy: separate G
			a: ANY
			d: detachable ANY
			sa: separate ANY
			sd: detachable separate ANY
		do
			xx := x
			yy := y
			xx := y -- Error.
			yy := x
			a := x -- Error.
			a := y -- Error.
			d := x -- Error.
			d := y -- Error.
			sa := x -- Error.
			sa := y -- Error.
			sd := x
			sd := y
		end

end