$STATUS class TEST2 [G -> {HASHABLE, COMPARABLE}]

inherit
	COMPARABLE

	HASHABLE
		undefine
			is_equal
		end

feature

	hash_code: INTEGER
		do

		end

	is_less alias "<" (other: like Current): BOOLEAN
		do

		end

end
