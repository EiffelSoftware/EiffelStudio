indexing
	description: "List of dependencies of external clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USE_LIST_AS

inherit
	EIFFEL_LIST [ID_AS]
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature -- Array representaion

	array_representation: ARRAY [INTEGER] is
			-- Array representation of list of files required by external.
		local
			i: INTEGER
			l_names_heap: like Names_heap
		do
			from
				create Result.make (1, count)
				l_names_heap := Names_heap
				i := 1
				start
			until
				after
			loop
				l_names_heap.put (item)
				Result.put (l_names_heap.found_item, i)
				i := i + 1
				forth
			end
		end

end -- class USE_LIST_AS
