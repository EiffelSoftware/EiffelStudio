class C [G -> {TUPLE [out: INTEGER] rename out as standard_out end, TUPLE [standard_out: INTEGER]}]

feature

	foo (p: G)
		local
			i: INTEGER
		do
			i := p.out
			i := p.standard_out
		end

end
