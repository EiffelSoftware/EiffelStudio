deferred class BASE

inherit
	SYSTEM_OBJECT

feature {NONE} -- Tests

	a: SYSTEM_STRING assign set_a
		indexing
			property: auto
		deferred
		end
		
	set_a (a_a: like a)
		do
		end

end
