

class A

feature

	a: ARRAY [B]

	f is
		do
			!! a.make (1, 6)
			print ("Type of a is: ")
			print (a.generating_type)
			io.new_line
		end

end
