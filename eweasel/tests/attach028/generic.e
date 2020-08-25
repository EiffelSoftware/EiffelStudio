class
	GENERIC [G -> STRING create make_from_string end]

feature -- Access

	test_a: attached G
		attribute
			create Result.make_from_string ("A")
		end

feature -- Output

	display
		do
			print (test_a)
			print ('%N')
		end

end

