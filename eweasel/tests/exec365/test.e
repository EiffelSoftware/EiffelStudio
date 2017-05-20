class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			s: STRING_8
		do
			s := "£"
			if s.count /= 1 then
				io.put_string ("Not OK, string should only have one character.")
				io.put_new_line
			end

			s := "abc£de"
			s.replace_substring_all (once "£" , "xx")

			if not s.same_string ("abcxxde") then
				io.put_string ("Not OK, wrong substitution")
				io.put_new_line
			end
		end

end 
