class A [G -> TUPLE [out: INTEGER]]

feature

	foo (p: G)
		local
			i: INTEGER
		do
			i := p.out
		end

end
