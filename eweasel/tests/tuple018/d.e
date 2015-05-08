class D [G -> {TUPLE [out: INTEGER] rename out as standard_out end, TUPLE [out: INTEGER]}]

feature

	foo (p: G)
		local
			i: INTEGER
			s: STRING
		do
			i := p.out
			s := p.out
		end

end
