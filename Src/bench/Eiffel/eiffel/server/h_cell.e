indexing
	description: "History cell for CACHE"
	date: "$Date$"
	revision: "$Revision$"

class H_CELL[T]

creation
		make

feature

	item: T
		-- item of the cache itself

	index: INTEGER
		-- index of the item in the cache

	make (e: T; i: INTEGER) is
		-- creation of a filled cell
		do
			item := e
			index := i
		end
	
	set_item (e: T) is
		-- set item to e
		do
			item := e
		end

	set_index (i: INTEGER) is
		-- set index to i
		do
			index := i
		end
	
end
