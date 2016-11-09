class TEST

create
	make

feature

	make
		local
			x: ANY
		do
			io.put_string ("Test 1: ")
			if attached x as y then
				io.put_string ("Failed")
				io.put_new_line
				io.put_string (y.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line
			io.put_string ("Test 2: ")
			if attached x as y then
				io.put_string ("Failed")
				io.put_new_line
				io.put_string (x.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line
			io.put_string ("Test 3: ")
			if attached x then
				io.put_string ("Failed")
				io.put_new_line
				io.put_string (x.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line
		end

end