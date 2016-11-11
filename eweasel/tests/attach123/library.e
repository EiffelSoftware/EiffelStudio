class LIBRARY

feature -- Test

	test (a: ANY)
		do
			if attached a as b and then attached b.out as s then
				io.put_string ("Test: Failed%N")
				io.put_string (s)
			else
				io.put_string ("Test: OK%N")
			end
		end

end