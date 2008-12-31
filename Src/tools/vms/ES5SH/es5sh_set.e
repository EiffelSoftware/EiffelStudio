note
	description: "set of objects, traversable, indexable, linear"
	author: "David Schwartz"
	date: "$Date$"
	revision: "$Revision$"
	archive: "$Archive: $"

class
	ES5SH_SET [G]

inherit
	ARRAYED_SET [G]
		rename
			make as make_set
		export 
			{NONE} all  --, changeable_comparison_criterion, arrayed_set_make
			{ANY}
				--compare_objects, 
				index, item, count, is_empty, has, off, after, before, 
				start, finish, forth, back, first, last, put, extend --, prune
		redefine
			make_from_array, default_create
		end
	
create
	make, make_empty, make_from_array
	
feature {NONE} -- Initialization

	make, make_empty, default_create
		do
			make_set (0)
			compare_objects
		end

	make_from_array (a: ARRAY[G])
		do
			make_set (0)
			compare_objects	-- can only be called on empty set
			Precursor (a)
		end
		
end -- class ES5SH_SET
