class A [G -> TUPLE [x, y: INTEGER]]

feature

	foo (p: G)
		do
			p.x.do_nothing
		end

end
