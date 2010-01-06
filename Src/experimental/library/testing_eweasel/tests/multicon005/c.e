indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
		C

feature -- Noise, not directly used in this test.

	make  is
			--
		do
			io.put_string ("make of C%N")
		end

	f is
			-- f
		do
			io.put_string ("f of C%N")
		end

	g: DOUBLE is
			-- g
		do
			io.put_string ("g of C%N")
			Result := 1.337
		end

feature -- Used in this test to test contracts

	set_valid (a_value: BOOLEAN) is
			-- Set `is_valid' to `a_value'
		do
			is_valid := a_value
		ensure
			is_valid_set: is_valid = a_value
		end

	is_valid: BOOLEAN
		-- Used for contract testing.

	set_count (a_i: INTEGER) is
			-- Sets `count' to `a_i'
		require
			a_i > 1
		deferred
		ensure
			count_set: count = a_i
		end

	count: INTEGER
			-- count

end

