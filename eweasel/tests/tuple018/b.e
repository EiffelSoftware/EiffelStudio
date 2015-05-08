class B [G -> {TUPLE [out: COMPARABLE] rename out as out1 end, TUPLE [out: NUMERIC] rename out as out2 end}]

feature

	foo (p: G)
		local
			c: COMPARABLE
			n: NUMERIC
		do
			c := p.out
			n := p.out
		end

end
