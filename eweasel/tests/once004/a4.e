class A

inherit
	FOO

create
	make

feature
	
	make is
		local
			i: INTEGER
			n: like o_numeric
			s: STRING_32
			c: ANY
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

end
