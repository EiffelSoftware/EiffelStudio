class A

create
	make

feature
	
	make
		local
			i: INTEGER
			n: like f
			s: STRING
			c: A
		do
			from
				i := 1
			until
				i > 5
			loop
				print ("[" + i.out + "] ")
				p
				print ("procedure=done%N")

				print ("[" + i.out + "] ")
				n := f
				print ("numeric=" + n.out + "%N")

				print ("[" + i.out + "] ")
				s := g
				print ("string=" + s.out + "%N")

				print ("[" + i.out + "] ")
				c := h
				print ("current=" + c.generator + "%N")
				i := i + 1
			end
		end

	p
		once ("OBJECT")
			print (" [Execute procedure] ")
		end

	f: NATURAL_8
		once ("OBJECT")
			print (" [Get numeric] ")
			Result := 123
		end

	g: STRING
		once ("OBJECT")
			print (" [Get string] ")
			Result := "a_string"
		end

	h: A
		once ("OBJECT")
			print (" [Get current] ")
			Result := Current
		end
		

end
