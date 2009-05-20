class A [G -> detachable ANY]

feature

	f (x: G)
		local
			y: G
		do
			y := x
			x.do_nothing
			y.do_nothing
		end

end