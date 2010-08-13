class
	TEST1 [G]

feature

	do_something
		local
			l_g: like g
			l_f: like f
		do
			io.put_string (generating_type)
			io.put_new_line
			io.put_string ({like Current})
			io.put_new_line

			create l_g
			io.put_string (l_g.generating_type)
			io.put_new_line

			create l_f
			io.put_string (l_f.generating_type)
			io.put_new_line
		end


	f: like Current
		do
			create Result
		end

	g: TEST1 [G]
		do
			create Result
		end

end
