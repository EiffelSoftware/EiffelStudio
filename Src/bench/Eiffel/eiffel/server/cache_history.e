indexing
	description: "History used for cache remembering system, so that element%
				%accessed more often are kept as much as possible."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_HISTORY [G]

inherit
		ARRAY[G]
			rename
				count as count_array,
				make as make_array,
				wipe_out as array_wipe_out,
				clear_all as array_clear_all
			end

creation
	make

feature

	next: ARRAY[INTEGER]
		-- Position of the next element in the history
		-- Understand next arrived

	previous: ARRAY[INTEGER]
		-- Position of the previous element in the history
		-- Understand previously arrived

	free_cells: ARRAY[INTEGER]
		-- Record of the cells still free in the history

	size: INTEGER
		-- Size of the history

	count: INTEGER
		-- Number of elements in the history

	older: INTEGER
		-- Index of the older element in the history

	younger: INTEGER
		-- Index of the younger element in the history
	
	to_remove: G
		-- Last element removed from the history
		--  by the force function
	
	make (n: INTEGER) is
			-- Create an history of size n
		local
			i: INTEGER
			int_array: ARRAY[INTEGER]
		do
			make_array (0,n - 1)
			!! next.make (0, n - 1)
			!! previous.make (0, n - 1)
			!! free_cells.make (0, n - 1)
			from
				int_array := free_cells
			until
				i = n
			loop
				int_array.put (i, i)
				i := i + 1
			end
			size := n
			younger := -1
			older := -1
		end

	add (e: G) is
			-- Add a new element in the history
		require
			non_void_arguement:	e /= Void
		local
			new_one: INTEGER
		do
			if count < size then
				new_one := free_cells.item (count)
				count := count + 1
				if younger /= -1 then
					next.put(new_one, younger)
				else
					older := 0
				end
				next.put(-1, new_one)
				previous.put(younger, new_one)
				younger := new_one
				put (e, new_one)
				to_remove := Void
			else
				-- we are full: the older must leave
				new_one := older
				older := next.item(new_one)
				previous.put (-1, older)
				previous.put (younger, new_one)
				next.put (new_one, younger)
				next.put (-1, new_one)
				younger := new_one
				to_remove := item (new_one)
				put (e, new_one)
			end
		ensure
			
		end
			
	make_younger (i: INTEGER) is
			-- Make the element of index i younger
			-- as it is accessed in the cache
		require
				out_of_bound: i <= capacity
		local
			next_i, previous_i: INTEGER
		do
			if younger /= i then
				previous_i := previous.item (i)
				next_i := next.item (i)
				if i = older then
					older := next_i
					previous.put (-1, next_i)
				else
					next.put (next_i, previous_i)
					previous.put (previous_i, next_i)
				end
				previous.put (younger, i)
				next.put (-1, i)
				next.put (i, younger)
				younger := i
				
			end		
		end

	remove (i: INTEGER) is
			-- Remove the item of index i from the
			-- history
			-- Do not check if i is really a used cell
		require
				out_of_bound: i <= capacity
		local
			previous_i, next_i: INTEGER
		do
			put (Void, i)
			if count > 1 then		
				previous_i := previous.item (i)
				next_i := next.item (i)
				if i = older then
					older := next_i
					previous.put (-1, next_i)
				elseif i = younger then
					younger := previous_i
					next.put (-1, previous_i)
				else
					next.put (next_i, previous_i)
					previous.put (previous_i, next_i)
				end
				count := count - 1
				free_cells.put (i, count)
			else
				older := -1
				younger := -1
				count := 0
			end
		end

	wipe_out, clear_all is
		local
			int_array: ARRAY [INTEGER]
			i: INTEGER
		do
			count := 0
			younger := -1
			older := -1
			from
				int_array := free_cells
			until
					i = size
			loop
					int_array.put (i, i)
					i := i + 1
			end
			to_remove := Void
		end	
		
	set_item (e: G; i: INTEGER) is
		-- change the item at the index i
		do
			put (e, i)
		end			

invariant
	older_good: older >= -1 and older <= size
	younger_good: younger >= -1 and younger <= size
	count_good: count >= 0 and count <= size
end


