class A [H]

feature

	a: ARRAY [B]

	f
		do
			create a.make_filled (Void, 1, 6)
			print ("Type of a is: ")
			print (a.generating_type)
			io.new_line
		end

end
