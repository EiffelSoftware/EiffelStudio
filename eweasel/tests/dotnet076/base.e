deferred class
	BASE

inherit
	SYSTEM_BASE

feature {NONE} -- Tests

	a: ANY assign set_a
		indexing
			property: auto
		end
		
	set_a (a_a: like a) is
		do	
		end
		
	b: ANY assign set_b
		indexing
			property: auto
		deferred
		end
		
	set_b (a_b: like b) is
		do	
		end

end
