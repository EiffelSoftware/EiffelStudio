indexing
	description: "List of dependencies of external clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USE_LIST_AS

inherit
	EIFFEL_LIST [ID_AS]

create
	make

feature -- Array representaion

	array_representation: ARRAY [STRING] is
			-- Array representation of list of files required by external.
		local
			i: INTEGER
		do
			from
				create Result.make (1, count)
				i := 1
				start
			until
				after
			loop
				Result.put (item, i)
				i := i + 1
				forth
			end
		end

end -- class USE_LIST_AS
