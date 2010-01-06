indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		B

create
	make

feature
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

end
