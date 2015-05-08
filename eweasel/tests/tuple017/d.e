class D [G -> {TUPLE [x1, y1: INTEGER], H}, H -> {TUPLE [x2, y2: INTEGER], G}]

feature

	foo (p: G)
		do
			p.x1.do_nothing
			p.x2.do_nothing
		end

end
