class C [G -> H, H -> TUPLE [x, y: INTEGER]]

feature

	foo (p: G)
		do
			p.x.do_nothing
		end

end
