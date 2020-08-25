class
	ATTRIBUTES

inherit
	BASE
	
feature -- Access

	test_a: attached STRING
		attribute
			create Result.make_from_string ("A")
		end
		
end

