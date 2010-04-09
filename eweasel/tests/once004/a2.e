class A

create
	make

feature
	
	make is
		local
			i: INTEGER
			n: like f_numeric
			s: STRING
			c: ANY
		do
			from
				i := 1
			until
				i > 5
			loop
				print ("[" + i.out + "] ")
				f_procedure
				print ("procedure=done%N")

				print ("[" + i.out + "] ")
				n := f_numeric
				print ("numeric=" + n.out + "%N")

				print ("[" + i.out + "] ")
				s := f_string
				print ("string=" + s.out + "%N")

				print ("[" + i.out + "] ")
				c := f_current
				print ("current=" + c.generator + "%N")
				i := i + 1
			end
		end

	f_procedure
		do
			print (" [Execute procedure] ")
		end

	f_numeric: NATURAL
		do
			print (" [Get numeric] ")
			Result := 123
		end

	f_string: STRING
		do
			print (" [Get string] ")
			Result := "a_string"
		end

	f_current: ANY
		do
			print (" [Get current] ")
			Result := Current
		end
		

end
