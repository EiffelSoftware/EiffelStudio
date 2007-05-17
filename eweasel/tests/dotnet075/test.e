class
	TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
		end

feature -- Tests


	bad_property is
		indexing
			property: auto
		do
		end
		
	another_bad_property is
		indexing
			property: "ABadProperty"
		do
		end

end
