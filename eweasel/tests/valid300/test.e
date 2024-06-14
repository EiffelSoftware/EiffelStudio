class
	TEST

create
	make

feature

	make
		local
			d: D
		do
			create d.make ("B", "C")
			check_code (d.code, "bc")
			check_to_string (d.to_string, "b:B c:C")
		end

	check_code (c, a_expected_code: STRING)
		do
			if c.same_string (a_expected_code) then
				print ("valid ")
			else
				print ("WRONG ")
			end
			print ("code      ["+ a_expected_code + "]: %"" + c + "%"")
			print ("%N")
		end

	check_to_string (s, a_expected_string: STRING)
		do
			if s.same_string (a_expected_string) then
				print ("valid ")
			else
				print ("WRONG ")
			end
			print ("to_string ["+ a_expected_string + "]: %"" + s + "%"")
			print ("%N")
		end

end
