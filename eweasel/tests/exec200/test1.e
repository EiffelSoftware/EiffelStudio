class TEST1 [G -> A create make end]

feature

	f (a: G) is
		local
			b: like a
			b2: LINKED_LIST [like a]
			b3: LINKED_LIST [LINKED_LIST [like a]]
		do
			create b.make
			print (b.generating_type)
			io.new_line

			create b2.make
			print (b2.generating_type)
			io.new_line

			create b3.make
			print (b3.generating_type)
			io.new_line

			io.new_line
		end

	g (a: like s) is
		local
			b: like a
			b2: LINKED_LIST [like a]
			b3: LINKED_LIST [LINKED_LIST [like a]]
		do
			create b.make
			print (b.generating_type)
			io.new_line

			create b2.make
			print (b2.generating_type)
			io.new_line

			create b3.make
			print (b3.generating_type)
			io.new_line

			io.new_line
		end

	h (a: like Current) is
		local
			b: like a
			b2: LINKED_LIST [like a]
			b3: LINKED_LIST [LINKED_LIST [like a]]
		do
			create b
			print (b.generating_type)
			io.new_line

			create b2.make
			print (b2.generating_type)
			io.new_line

			create b3.make
			print (b3.generating_type)
			io.new_line

			io.new_line
		end

	s: A

end
