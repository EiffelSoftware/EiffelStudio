class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			a: ARRAY[EXPANDED_NAME]
			n: EXPANDED_NAME
		do 
			create a.make(1, 0)
			a.compare_objects
			n.set ("Blake")
			a.force (n, 1)
			-- we get a post-condition violation from ARRAY.put: "insertion_done"
		end

end
