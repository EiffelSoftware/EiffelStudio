class TEST1 [G]
inherit
	ANY
		redefine
			is_equal
		end

convert
	to_array: {ARRAY [G]}

feature

	to_array: ARRAY [G]
		do
			create Result.make_empty
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
		end
	
end

