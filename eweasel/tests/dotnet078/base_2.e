class BASE

feature -- Tests

	a: SYSTEM_STRING assign set_a
		indexing
			property: auto
		end
		
	set_a (a_a: like a)
		do
		end

end
