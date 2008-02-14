class TEST1 [G -> A create make end]

feature

	f (a: G) is
		local
			b: like a
		do
			create b.make
			print (b.generating_type)
			io.new_line
		end

	g (a: like s) is
		local
			b: like a
		do
			create b.make
			print (b.generating_type)
			io.new_line
		end

	h (a: like Current) is
		local
			b: like a
		do
			create b
			print (b.generating_type)
			io.new_line
		end


	s: A

end
