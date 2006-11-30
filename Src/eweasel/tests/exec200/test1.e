class TEST1 [G -> STRING create make end]

feature

	f (a: G) is
		local
			b: like a
		do
			create b.make (1)
			print (b.generating_type)
			io.new_line
		end
		
	g (a: like s) is
		local
			b: like a
		do
			create b.make (1)
			print (b.generating_type)
			io.new_line
		end

	s: STRING

end
