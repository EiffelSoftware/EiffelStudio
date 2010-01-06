indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		C

create
	f

feature
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

end

