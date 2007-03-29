class D [G]

feature

	p (a: ANY; b: G) is
		do
			io.put_string ("D.p")
			io.put_new_line
			j := b
		end

	j: G

end