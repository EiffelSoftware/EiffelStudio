class A

create
	make

feature
	
	make is
		local
			i: INTEGER
			n: like o_numeric
			s: STRING
			c: A
		do
			from
				i := 1
			until
				i > 5
			loop
				print ("[" + i.out + "] ")
				o_procedure
				print ("procedure=done%N")

				print ("[" + i.out + "] ")
				n := o_numeric
				print ("numeric=" + n.out + "%N")

				print ("[" + i.out + "] ")
				s := o_string
				print ("string=" + s.out + "%N")

				print ("[" + i.out + "] ")
				c := o_current
				print ("current=" + c.generator + "%N")
				i := i + 1
			end
		end

	o_procedure
		once ("THREAD")
			print (" [Execute procedure] ")
		end

	o_numeric: NATURAL
		once ("OBJECT")
			print (" [Get numeric] ")
			Result := 123
		end

	o_string: STRING
		once ("THREAD")
			print (" [Get string] ")
			Result := "a_string"
		end

	o_current: A
		once ("OBJECT")
			print (" [Get current] ")
			Result := Current
		end
		

end
