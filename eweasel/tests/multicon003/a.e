indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		A

create
	make

feature
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

end
