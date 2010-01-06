
class B1

inherit

	B

feature -- Access

	b1: INTEGER

feature -- Basic operations

	call2 is
		do
			io.print (generating_type)
			io.print (" called%N")
		end

	call1 is
		do
			io.print (generating_type)
			io.print (" called%N")
		end

end

