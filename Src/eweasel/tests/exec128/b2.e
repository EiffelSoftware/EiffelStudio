
class B2

inherit

	B

feature -- Access

	b2: INTEGER

feature -- Basic operations

	call2 is
		do
			io.print (generating_type)
			io.print (" called%N")
		end

end

