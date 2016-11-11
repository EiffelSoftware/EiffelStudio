class LIBRARY

feature -- Test

	test (a: ANY)
		do
			if attached a as b and then attached b.out as s then
				io.put_string ("Test: ")
				io.put_string (s)
			else
				io.put_string ("Test: OK")
			end
			io.put_new_line
		end

end