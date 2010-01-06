indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
		B


feature -- Noise, not directly used in this test.
	make is
			--
		do
			io.put_string ("make of B%N")
		end

	f: DOUBLE is
			-- f
		do
			io.put_string ("f of B%N")
			Result := 73
		end

	g: ANY is
			-- g
		do
			io.put_string ("g of B%N")
			Result := Current
		end
feature -- Used for contract testing

	increase_count is
			-- Increases the count
		deferred
		ensure
			count_increased: count = old count + 1
		end
	count: INTEGER is
		deferred
		end
end
