class
	TEST_CPP

creation
	make

feature

	make is
		do
			!! s.make ("Hello World!")
			io.print ("The string is: ")
			io.print (s.value)
			io.print ("%NThe length is: ")
			io.print (s.length)
			io.new_line
		end

	s: MYSTRING

end -- class TEST_CPP
