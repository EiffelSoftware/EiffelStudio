class B [G -> {TUPLE [x1, y1: INTEGER], TUPLE [x2, y2: INTEGER]}]

feature

	foo (p: G)
		do
			p.x1.do_nothing
			p.x2.do_nothing
		end

end
