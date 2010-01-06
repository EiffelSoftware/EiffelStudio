class TEST

create
	make

feature {NONE} -- Creation
	
	make is
			-- Run test.
		local
			x: TEST
		do
			io.put_string ("Evaluate.")
			io.put_new_line
			x := empty_once
			if x /= Void then
				io.put_string ("Failed.")
				io.put_new_line
			end
			io.put_string ("Access.")
			io.put_new_line
			x := empty_once
			if x /= Void then
				io.put_string ("Failed.")
				io.put_new_line
			end
			io.put_string ("Done.")
			io.put_new_line
		rescue
			io.put_string ("Failed.")
			io.put_new_line
		end

feature {NONE} -- Implementation

	empty_once: TEST is
			-- Once function that does not assign to a result.
		once
		end

end
