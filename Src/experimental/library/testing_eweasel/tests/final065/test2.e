class
	TEST2 [G]

feature

	g is
		local
			t1: TEST1 [G]
			a: ANY
		do
			create t1
			a := t1.item
			if a /= Void then
				io.put_string (a.generating_type)
				io.put_new_line
			end
		end

end
