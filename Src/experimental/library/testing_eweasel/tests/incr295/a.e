class
	A [G -> STRING create make_from_string end]

feature

	f
		do
			print (g)
		end

	g: G do create Result.make_from_string ("g%N") end

end
