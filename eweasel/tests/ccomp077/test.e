class
	TEST

create
	make

feature

	make is
		do
			io.put_integer (5 \\ bar (2))
			io.put_new_line
			io.put_integer (5 // bar (2))
			io.put_new_line
			io.put_integer (5 * bar (2))
			io.put_new_line
			io.put_double (5 / bar (2))
			io.put_new_line
			io.put_integer (5 + bar (2))
			io.put_new_line
			io.put_integer (5 - bar (2))
			io.put_new_line

			io.put_boolean (5 < bar (3))
			io.put_new_line
			io.put_boolean (5 <= bar (3))
			io.put_new_line
			io.put_boolean (5 > bar (3))
			io.put_new_line
			io.put_boolean (5 >= bar (3))
			io.put_new_line
			
			io.put_boolean ('5' < bar ('3'))
			io.put_new_line
			io.put_boolean ('5' <= bar ('3'))
			io.put_new_line
			io.put_boolean ('5' > bar ('3'))
			io.put_new_line
			io.put_boolean ('5' >= bar ('3'))
			io.put_new_line

			io.put_boolean (True or bar (False))
			io.put_new_line
			io.put_boolean (True and bar (True))
			io.put_new_line
			io.put_boolean (True or else bar (True))
			io.put_new_line
			io.put_boolean (True and then bar (True))
			io.put_new_line
			io.put_boolean (True implies bar (True))
			io.put_new_line
			io.put_boolean (True xor bar (True))
			io.put_new_line
		end

	bar (o: ANY): like o is
		do
			Result := o
		end

end
