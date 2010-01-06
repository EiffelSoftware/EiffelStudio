indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
		A

feature -- Noise, not used in this test.

	make is
			--
		do
			io.put_string ("make of A%N")
		end

	f: INTEGER is
			-- f
		do
			io.put_string ("f of A%N")
			Result := 42
		end

	g is
			-- g
		do
			io.put_string ("g of A%N")
		end

feature -- Used in this test to test contracts and deferred features.

	same_as_count: INTEGER is
			-- Will returns `count' which is defined in C
		deferred
		end


end
